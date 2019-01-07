library mmkv_flutter_cache;

import 'package:mmkv_flutter/mmkv_flutter.dart';

/// MMKV Cache with expire support
class Cache {
  static _getPrefix(String key) => 'cache_$key';

  /// add item to cache; ```expired: hours``` defaults to 0
  static Future<bool> add(String key, String value, {int expired = 0}) async {
    MmkvFlutter mmkv = await MmkvFlutter.getInstance();
    final timespan =
        DateTime.now().add(new Duration(hours: expired)).millisecondsSinceEpoch;

    /// add timespan to value so we can use it later.
    final v = '$timespan:$value';
    return mmkv.setString(_getPrefix(key), v);
  }

  /// get item from cache if its not exists or has expired return null
  static Future<String> get(String key) async {
    MmkvFlutter mmkv = await MmkvFlutter.getInstance();
    final value = await mmkv.getString(_getPrefix(key));
    if (value == null || value.isEmpty) {
      return '';
    }
    final index = value.indexOf(':');
    if (index < 0) {
      return '';
    }

    /// get timespan
    final timespan = value.substring(0, index);
    final diff =
        int.parse(timespan).compareTo(DateTime.now().millisecondsSinceEpoch);
    if (diff < 1) {
      await mmkv.removeByKey(_getPrefix(key));
      return '';
    }

    /// get user data except `:`
    final v = value.substring(index + 1);
    return v;
  }

  /// clear item by key or clear all if key not provided
  static Future<bool> clear({String key = ""}) async {
    MmkvFlutter mmkv = await MmkvFlutter.getInstance();
    if (key.isNotEmpty) {
      return mmkv.removeByKey(key);
    }
    return mmkv.clear();
  }
}
