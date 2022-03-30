import 'dart:collection';

abstract class RAction<D> {
  String? type;
  D? data;

  RAction.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['data'] != null) {
      data = parseData(json['data']);
    }
  }

  D parseData(Map<String, dynamic> json);
}

typedef T? RActionParserFunction<T extends RAction>(Map<String, dynamic> json);

class RActionParser {
  static final Map<String, RActionParserFunction> parsers = LinkedHashMap();
  static RAction? parse(Map<String, dynamic> json) {
    return parsers[json['type']]?.call(json);
  }
}
