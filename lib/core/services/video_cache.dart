import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// Downloads a network video **once** into a size-capped on-disk cache and
/// serves it as a local [File], so playback and thumbnailing never re-fetch it.
///
/// Without this, `VideoPlayerController.networkUrl` re-streams the whole clip on
/// every open (and the thumbnail generator would fetch it too) — the cause of
/// tens of MB per view. Here the first view downloads; every later view (and
/// the poster frame) reads the local file for free.
class VideoCache {
  VideoCache({Dio? dio}) : _dio = dio ?? Dio();

  final Dio _dio;

  /// Cap the cache directory; oldest files are evicted past this.
  static const int _maxBytes = 300 * 1024 * 1024; // 300 MB

  Directory? _dir;
  // De-dupes concurrent requests for the same url (e.g. player + poster).
  final Map<String, Future<File>> _inFlight = {};

  Future<Directory> _cacheDir() async {
    final existing = _dir;
    if (existing != null) return existing;
    final base = await getTemporaryDirectory();
    final dir = Directory(p.join(base.path, 'video_cache'));
    if (!await dir.exists()) await dir.create(recursive: true);
    _dir = dir;
    return dir;
  }

  /// Stable, filesystem-safe filename for [url] (FNV-1a hash — no crypto dep).
  String _keyFor(String url) {
    var hash = 0xcbf29ce484222325;
    for (final c in url.codeUnits) {
      hash ^= c;
      hash = (hash * 0x100000001b3) & 0xFFFFFFFFFFFFFFFF;
    }
    return 'v_${hash.toRadixString(16)}.mp4';
  }

  /// Returns the cached file for [url], downloading it once if absent.
  Future<File> fileFor(String url) {
    return _inFlight.putIfAbsent(url, () => _resolve(url))
      ..whenComplete(() => _inFlight.remove(url));
  }

  Future<File> _resolve(String url) async {
    final dir = await _cacheDir();
    final file = File(p.join(dir.path, _keyFor(url)));

    if (await file.exists() && await file.length() > 0) {
      // Touch so LRU keeps recently-played clips.
      try {
        await file.setLastModified(DateTime.now());
      } catch (_) {}
      return file;
    }

    // Download to a temp file, then atomically rename in — avoids a half-written
    // file being treated as cached if the download is interrupted.
    final tmp = File('${file.path}.part');
    await _dio.download(url, tmp.path);
    if (await file.exists()) await file.delete();
    await tmp.rename(file.path);

    // Best-effort eviction after adding a new file.
    unawaited(_evictIfNeeded());
    return file;
  }

  /// LRU-ish eviction: if the dir exceeds [_maxBytes], delete oldest files
  /// (by last-modified) until under the cap.
  Future<void> _evictIfNeeded() async {
    try {
      final dir = _dir;
      if (dir == null) return;
      final files = <File>[];
      var total = 0;
      await for (final e in dir.list()) {
        if (e is File && !e.path.endsWith('.part')) {
          files.add(e);
          total += await e.length();
        }
      }
      if (total <= _maxBytes) return;
      files.sort((a, b) =>
          a.statSync().modified.compareTo(b.statSync().modified));
      for (final f in files) {
        if (total <= _maxBytes) break;
        final len = await f.length();
        await f.delete();
        total -= len;
      }
    } catch (_) {
      // Eviction is best-effort; never let it break playback.
    }
  }
}

/// App-wide video cache. `keepAlive` so it persists across the session.
final videoCacheProvider = Provider<VideoCache>((ref) => VideoCache());
