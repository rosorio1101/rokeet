import 'package:flutter/material.dart';
import 'widget.dart';
import 'widget_builder.dart';
import '../rokeet.dart';

class LabelData {
  String? text;
}

class RLabelWidget extends RWidget<LabelData> {
  static const TYPE = "label";

  RLabelWidget.fromJson(Map<String, dynamic> json) : super.fromJson(json);

  @override
  LabelData? parseData(Map<String, dynamic> json) {
    var data = LabelData();
    data.text = json['text'];
    return data;
  }
}

class RLabelWidgetBuilder extends RWidgetBuilder<RLabelWidget> {
  @override
  Widget build(Rokeet rokeet, RLabelWidget widget) {
    Key key = Key(widget.id!);
    return Text.rich(
      TextSpan(text: widget.data!.text),
      textDirection: TextDirection.ltr,
      key: key,
    );
  }
}
