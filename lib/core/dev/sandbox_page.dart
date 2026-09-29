import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app/notification_service.dart';
import '../storage/secure_storage_service.dart';
import '../utils/jwt_utils.dart';

/// Debug-only developer sandbox. Reached by long-pressing the home avatar in
/// debug builds; never linked in release. A place to trigger states that are
/// otherwise slow or awkward to reach naturally.
class SandboxPage extends ConsumerWidget {
  const SandboxPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sandbox')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _SectionHeader('Auth'),
          _ExpireAccessTokenTile(),
          SizedBox(height: 24),
          _SectionHeader('Notifications'),
          _LocalNotificationTile(),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);

  final String title;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(title, style: Theme.of(context).textTheme.titleMedium),
      );
}

/// Simulates the "day-2 cold launch" state: overwrites the stored access token
/// with an already-expired JWT while leaving the refresh token untouched. On
/// the next cold launch (or any authenticated request) this is exactly what the
/// app sees the morning after login — the path that used to log the user out.
///
/// Expected behaviour AFTER the fix: the app stays signed in. `hasSession()`
/// sees the expired access token, refreshes proactively, and the concurrent
/// 401s (if any slip through) share one single-flight refresh instead of racing
/// the rotating refresh token.
class _ExpireAccessTokenTile extends ConsumerStatefulWidget {
  const _ExpireAccessTokenTile();

  @override
  ConsumerState<_ExpireAccessTokenTile> createState() =>
      _ExpireAccessTokenTileState();
}

class _ExpireAccessTokenTileState
    extends ConsumerState<_ExpireAccessTokenTile> {
  bool _busy = false;

  Future<void> _expire() async {
    setState(() => _busy = true);
    final messenger = ScaffoldMessenger.of(context);
    final storage = ref.read(secureStorageServiceProvider);
    try {
      final refresh = await storage.readRefreshToken();
      if (refresh == null || refresh.isEmpty) {
        messenger.showSnackBar(
          const SnackBar(
            content: Text('No refresh token stored — log in first.'),
          ),
        );
        return;
      }
      // Overwrite ONLY the access token with a well-formed but already-expired
      // JWT. Refresh token is left intact so the refresh flow has something to
      // work with — the whole point of the repro.
      await storage.write('access_token', _expiredJwt());
      if (!mounted) return;
      messenger.showSnackBar(
        const SnackBar(
          content: Text(
            'Access token expired. Fully close & relaunch the app '
            '(or trigger any request) to test the day-2 refresh.',
          ),
          duration: Duration(seconds: 5),
        ),
      );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: ListTile(
        leading: const Icon(Icons.timer_off_outlined),
        title: const Text('Expire access token'),
        subtitle: const Text(
          'Simulate a day-2 cold launch: stale access token, valid refresh '
          'token. Then relaunch to verify the session survives.',
        ),
        trailing: _busy
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Icon(Icons.chevron_right),
        onTap: _busy ? null : _expire,
      ),
    );
  }
}

/// Fires one immediate local notification per category so you can verify
/// channels, icons, and sounds without waiting for a real health event.
class _LocalNotificationTile extends ConsumerStatefulWidget {
  const _LocalNotificationTile();

  @override
  ConsumerState<_LocalNotificationTile> createState() =>
      _LocalNotificationTileState();
}

class _LocalNotificationTileState
    extends ConsumerState<_LocalNotificationTile> {
  bool _busy = false;
  NotificationCategory _selected = NotificationCategory.medication;

  Future<void> _fire() async {
    setState(() => _busy = true);
    final svc = ref.read(notificationServiceProvider);
    await svc.show(
      id: 999000 + _selected.index,
      title: '[Test] ${_selected.channelName}',
      body: 'This is a test local notification for the '
          '${_selected.channelName} channel.',
      category: _selected,
    );
    if (mounted) setState(() => _busy = false);
  }

  Future<void> _schedule() async {
    setState(() => _busy = true);
    final svc = ref.read(notificationServiceProvider);
    final when = DateTime.now().add(const Duration(seconds: 5));
    await svc.schedule(
      id: 999100 + _selected.index,
      title: '[Test – 5s] ${_selected.channelName}',
      body: 'Scheduled 5 seconds ago for the ${_selected.channelName} channel.',
      when: when,
      category: _selected,
    );
    if (mounted) {
      setState(() => _busy = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Scheduled — fires in 5 s')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Local notification test',
                style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            const Text(
              'Pick a category then fire immediately or schedule in 5 s.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 12),
            DropdownButton<NotificationCategory>(
              value: _selected,
              isExpanded: true,
              onChanged: _busy
                  ? null
                  : (v) => setState(() => _selected = v!),
              items: NotificationCategory.values
                  .map(
                    (c) => DropdownMenuItem(
                      value: c,
                      child: Text(c.channelName),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: _busy ? null : _fire,
                    child: const Text('Fire now'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: _busy ? null : _schedule,
                    child: const Text('In 5 s'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// A structurally valid JWT (header.payload.signature) whose `exp` is far in the
/// past, so [JwtUtils.isExpired] reports true. The signature is a placeholder —
/// the backend rejects it on use (→ 401), which is precisely the day-2 path we
/// want to exercise; the client-side expiry check short-circuits before that.
String _expiredJwt() {
  // Pre-encoded to avoid pulling in dart:convert here; payload = {"exp":1000000000}
  // (2001-09-09 UTC), decoded fine by JwtUtils and clearly in the past.
  const header = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9';
  const payload = 'eyJleHAiOjEwMDAwMDAwMDB9';
  const signature = 'sandbox_expired_signature';
  assert(
    JwtUtils.isExpired('$header.$payload.$signature'),
    'sandbox expired JWT must read as expired',
  );
  return '$header.$payload.$signature';
}
