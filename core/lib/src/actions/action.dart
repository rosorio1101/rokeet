import 'action.navigate.dart';

abstract class RAction<D> {
  String? type;
  D? data;

  RAction.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if(json['data'] != null) {
      data = parseData(json['data']);
    }
  }

  D parseData(Map<String, dynamic> json);
}

class RActionParser {
  static RAction? parse(Map<String,dynamic> json) {
    switch(json['type']) {
      case RNavigateAction.TYPE:
        return RNavigateAction.fromJson(json);

      default: return null;
    }
  }
}