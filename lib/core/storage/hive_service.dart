import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../errors/app_exception.dart';
import 'sync_flag_store.dart';

part 'hive_service.g.dart';

/// JSON-document cache on top of Hive.
///
/// Used exclusively for cached/offline data. Documents are stored as JSON
/// strings keyed by entity id, which keeps the cache schema-free and avoids
/// hand-written type adapters. Tokens and secrets are NEVER stored here.
class HiveService {
  const HiveService();

  static Future<void> init() => Hive.initFlutter();

  Future<Box<String>> _box(String name) async {
    try {
      return await Hive.openBox<String>(name);
    } catch (e) {
      throw CacheException('Failed to open box "$name": $e');
    }
  }

  Future<void> putJson(
    String boxName,
    String key,
    Map<String, dynamic> json,
  ) async {
    final box = await _box(boxName);
    await box.put(key, jsonEncode(json));
  }

  Future<void> putAllJson(
    String boxName,
    Map<String, Map<String, dynamic>> entries,
  ) async {
    final box = await _box(boxName);
    await box.putAll(entries.map((k, v) => MapEntry(k, jsonEncode(v))));
  }

  Future<Map<String, dynamic>?> getJson(String boxName, String key) async {
    final box = await _box(boxName);
    final raw = box.get(key);
    if (raw == null) return null;
    try {
      return jsonDecode(raw) as Map<String, dynamic>;
    } catch (e) {
      throw CacheException('Corrupt cache entry "$boxName/$key": $e');
    }
  }

  Future<List<Map<String, dynamic>>> getAllJson(String boxName) async {
    final box = await _box(boxName);
    try {
      return box.values
          .map((raw) => jsonDecode(raw) as Map<String, dynamic>)
          .toList();
    } catch (e) {
      throw CacheException('Corrupt cache in box "$boxName": $e');
    }
  }

  Future<void> delete(String boxName, String key) async {
    final box = await _box(boxName);
    await box.delete(key);
  }

  Future<void> clearBox(String boxName) async {
    final box = await _box(boxName);
    await box.clear();
  }

  /// Replaces the full contents of a box with [entries] (sync-from-server).
  Future<void> replaceAll(
    String boxName,
    Map<String, Map<String, dynamic>> entries,
  ) async {
    final box = await _box(boxName);
    await box.clear();
    await box.putAll(entries.map((k, v) => MapEntry(k, jsonEncode(v))));
  }
}

@Riverpod(keepAlive: true)
HiveService hiveService(Ref ref) => const HiveService();

@Riverpod(keepAlive: true)
SyncFlagStore syncFlagStore(Ref ref) => SyncFlagStore();
