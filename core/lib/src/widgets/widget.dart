import 'package:rokeetui_core/rokeetui_core.dart';
import 'package:rokeetui_core/src/widgets/widget.button.dart';

abstract class RWidget<D> {
  String? id;
  String? uiType;
  D? data;
  List<RWidget>? children = [];

  RWidget.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uiType = json['ui_type'];
    if(json['data'] != null) {
      data = parseData(json['data']);
    }

    if (json['children'] != null) {
      json['children'].map((child) => RWidgetParser.parse(child)).forEach((widget) => {
        if(widget != null) {
          children?.add(widget!)
        }
      });
    }
  }

  D? parseData(Map<String, dynamic> json);
}

abstract class RWidgetDataParser<D> {
  D? parse(Map<String, dynamic> json);
}

class RWidgetParser {
  static RWidget? parse(Map<String, dynamic> json) {
    switch(json['ui_type']) {
      case RVerticalContainerWidget.TYPE: return RVerticalContainerWidget.fromJson(json);
      case RLabelWidget.TYPE: return RLabelWidget.fromJson(json);
      case RButtonWidget.TYPE: return RButtonWidget.fromJson(json);
      default: return null;
    }
  }
}