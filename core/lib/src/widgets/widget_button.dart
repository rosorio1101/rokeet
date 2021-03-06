import 'package:flutter/material.dart';

import '../actions/action.dart';
import '../rokeet.dart';
import 'widget.dart';
import 'widget_builder.dart';

class ButtonData {
  String? text;
  RAction? action;
}

class RButtonWidget extends RWidget<ButtonData> {
  static const TYPE = "button";

  static final RWidgetParserFunction<RButtonWidget> jsonParser =
      (json) => RButtonWidget._fromJson(json);

  RButtonWidget._fromJson(Map<String, dynamic> json) : super.fromJson(json);

  @override
  ButtonData? parseData(Map<String, dynamic> json) {
    var data = ButtonData();
    data.text = json['text'];
    if (json['action'] != null) {
      data.action = RActionParser.parse(json['action']);
    }
    return data;
  }
}

class RButtonWidgetBuilder extends RWidgetBuilder<RButtonWidget> {
  @override
  Widget build(Rokeet rokeet, RButtonWidget widget) {
    Key key = Key(widget.id!);
    var data = widget.data!;
    return ElevatedButton(
      key: key,
      onPressed: () => {
        if (widget.data?.action != null) {rokeet.performAction(data.action!)}
      },
      child: Text.rich(
        TextSpan(text: data.text!),
        textDirection: TextDirection.ltr,
      ),
    );
  }
}
