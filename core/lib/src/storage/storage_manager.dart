import 'dart:collection';

class StorageManager {
  static final StorageManager _instance = StorageManager._internal();

  StorageManager._internal();

  factory StorageManager() {
    return _instance;
  }

  final Storage _storage = _DefaultStorage();

  Storage getStorage() {
    return _storage;
  }
}

abstract class Storage<K, V> {
  V? get(K key);

  void put(K key, V value);
}

class _DefaultStorage extends Storage<String, Object> {
  final Map<String, Object> _mapStorage = new LinkedHashMap();

  @override
  Object? get(String key) {
    return _mapStorage[key];
  }

  @override
  void put(String key, Object value) {
    if (_mapStorage.containsKey(key)) {
      _mapStorage.update(key, (_) => value);
    } else {
      _mapStorage.putIfAbsent(key, () => value);
    }
  }
}
