import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../domain/entities/community_entities.dart';
import '../providers/community_actions_providers.dart';

/// Records a share server-side and opens the OS share sheet for [post] with a
/// short caption + the post's deep link. The link opens the app directly when
/// installed (Universal / App Links) and the web portal otherwise.
///
/// [context] anchors the share-sheet popover on iPad / macOS (ignored on
/// phones). Safe to omit.
Future<void> sharePostToSheet(
  WidgetRef ref,
  Post post, {
  BuildContext? context,
}) async {
  final url = await ref
      .read(communityActionsProvider)
      .share(post, shareMethod: 'system');

  final text = _shareText(post, url);
  await SharePlus.instance.share(
    ShareParams(
      text: text,
      sharePositionOrigin: _originRect(context?.findRenderObject()),
    ),
  );
}

/// Records a share (method `copy_link`) and copies the link to the clipboard,
/// showing the localized "Link copied" confirmation. Used by the ⋯ sheet's
/// "Copy link" action.
Future<void> copyPostLink(WidgetRef ref, BuildContext context, Post post) async {
  final url = await ref
      .read(communityActionsProvider)
      .share(post, shareMethod: 'copy_link');
  await Clipboard.setData(ClipboardData(text: url));
  if (context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(context.l10n.pawHubLinkCopied)),
    );
  }
}

/// The message body shared alongside the link: the pet's name + a trimmed
/// caption when present, then the URL on its own line so chat apps render it as
/// a tappable link (and, once the web OG tags exist, a rich preview).
String _shareText(Post post, String url) {
  final caption = post.caption?.trim();
  final lead = (caption != null && caption.isNotEmpty)
      ? '${post.author.name}: ${_trim(caption, 140)}'
      : "Check out ${post.author.name}'s post on PetaVerse";
  return '$lead\n$url';
}

String _trim(String s, int max) =>
    s.length <= max ? s : '${s.substring(0, max).trimRight()}…';

Rect? _originRect(RenderObject? object) {
  if (object is! RenderBox || !object.hasSize) return null;
  final offset = object.localToGlobal(Offset.zero);
  return offset & object.size;
}
