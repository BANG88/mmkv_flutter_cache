# mmkv_flutter_cache

[![pub package](https://img.shields.io/pub/v/mmkv_flutter_cache.svg)](https://pub.dartlang.org/packages/mmkv_flutter_cache)

> A cache for Flutter project implement it with mmkv framework. and support expires

## Getting Started


```yaml
dependencies:
  mmkv_flutter_cache: ^0.0.2
```

### Usage

```dart
import 'package:mmkv_flutter_cache/mmkv_flutter_cache.dart';

/// add value to cache will expired in 1 hour
final boolRes = await Cache.add('key', 'value', { expired: 1 } );

/// get value from cache
final value = await Cache.get('key');

```