import 'dart:collection';

Map<String, V> caseInsensitiveKeyMap<V>([Map<String, V>? value]) {
  final Map<String, V> map = LinkedHashMap<String, V>(
      equals: (key1, key2) => key1.toLowerCase() == key2.toLowerCase(),
      hashCode: (String key) => key.toLowerCase().hashCode);

  if (value != null && value.isNotEmpty) map.addAll(value);
  return map;
}

List<V> listOf<V>([V? value]) {
  if (value != null)
    return List.of([value]);
  else
    return List.empty(growable: true);
}

ReturnType run<ReturnType>(ReturnType Function() operation) {
  return operation();
}

extension ScopeObject<T extends Object> on T {
  ReturnType let<ReturnType>(ReturnType Function(T) operation_for) {
    return operation_for(this);
  }

  T also(void Function(T) operation_for) {
    operation_for(this);
    return this;
  }

  T apply(T Function(T) operation_for) {
    return operation_for(this);
  }
}
