import 'package:flutter/material.dart';
import '../rokeet.dart';
import 'widget.dart';
import 'widget.builder.dart';

class VerticalContainerData {}

class RVerticalContainerWidget extends RWidget<VerticalContainerData> {
  static const TYPE = "vertical_container";

  RVerticalContainerWidget.fromJson(Map<String, dynamic> json)
      : super.fromJson(json);

  @override
  VerticalContainerData? parseData(Map<String, dynamic> json) {}
}

class RVerticalContainerWidgetBuilder
    extends RWidgetBuilder<RVerticalContainerWidget> {
  @override
  Widget build(Rokeet rokeet, RVerticalContainerWidget widget) {
    List<Row> children = widget.children!
        .map((child) => Row(
              children: [rokeet.buildWidget(child)],
            ))
        .toList(growable: false);
    return Column(
      children: children,
    );
  }
}
