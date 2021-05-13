import 'package:flutter/material.dart';
import '../actions/action.dart';
import 'widget.dart';
import 'widget.builder.dart';
import '../rokeet.dart';

class ButtonData {
  String? text;
  RAction? action;
}

class RButtonWidget extends RWidget<ButtonData> {
  static const TYPE = "button";

  RButtonWidget.fromJson(Map<String, dynamic> json) : super.fromJson(json);

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
    var data = widget.data!;
    return ElevatedButton(
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
