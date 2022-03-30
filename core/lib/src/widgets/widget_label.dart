import 'package:flutter/material.dart';

import '../rokeet.dart';
import 'widget.dart';
import 'widget_builder.dart';

class LabelData {
  String? text;
}

class RLabelWidget extends RWidget<LabelData> {
  static const TYPE = "label";

  static final Map<String, RWidgetParserFunction> parser = {TYPE: jsonParser};

  static final RWidgetParserFunction<RLabelWidget> jsonParser =
      (json) => RLabelWidget._fromJson(json);

  RLabelWidget._fromJson(Map<String, dynamic> json) : super.fromJson(json);

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
