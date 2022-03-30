import 'dart:collection';

abstract class RWidget<D> {
  String? id;
  String? uiType;
  D? data;
  List<RWidget>? children = [];

  RWidget.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uiType = json['ui_type'];
    if (json['data'] != null) {
      data = parseData(json['data']);
    }

    if (json['children'] != null) {
      json['children']
          .map((child) => RWidgetParser.parse(child))
          .forEach((widget) => {
                if (widget != null) {children?.add(widget!)}
              });
    }
  }

  D? parseData(Map<String, dynamic> json);
}

typedef T? RWidgetParserFunction<T extends RWidget>(Map<String, dynamic> json);

class RWidgetParser {
  static final Map<String, RWidgetParserFunction> parsers = LinkedHashMap();

  static RWidget? parse(Map<String, dynamic> json) {
    return parsers[json['ui_type']]?.call(json);
  }
}
