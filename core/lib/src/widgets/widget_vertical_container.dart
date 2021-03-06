import 'package:flutter/material.dart';

import '../rokeet.dart';
import 'widget.dart';
import 'widget_builder.dart';

class VerticalContainerData {}

class RVerticalContainerWidget extends RWidget<VerticalContainerData> {
  static const TYPE = "vertical_container";

  static final RWidgetParserFunction<RVerticalContainerWidget> jsonParser =
      (json) => RVerticalContainerWidget._fromJson(json);

  RVerticalContainerWidget._fromJson(Map<String, dynamic> json)
      : super.fromJson(json);

  @override
  VerticalContainerData? parseData(Map<String, dynamic> json) {}
}

class RVerticalContainerWidgetBuilder
    extends RWidgetBuilder<RVerticalContainerWidget> {
  @override
  Widget build(Rokeet rokeet, RVerticalContainerWidget widget) {
    Key key = Key(widget.id!);
    List<Row> children = widget.children!
        .map((child) => rokeet.buildWidget(child))
        .where((element) => element != null)
        .map((e) => Row(
              children: [e!],
            ))
        .toList(growable: false);
    return Column(
      key: key,
      children: children,
    );
  }
}
