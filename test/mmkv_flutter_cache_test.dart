import 'package:flutter_test/flutter_test.dart';

import 'package:mmkv_flutter_cache/mmkv_flutter_cache.dart';

void main() {
  test('adds item to cache', () async {
    final c = await Cache.add('t', 'v');
    expect(c, true);
  });
}
