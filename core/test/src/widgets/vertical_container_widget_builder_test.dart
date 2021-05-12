import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rokeetui_core/core.dart';
import 'package:rokeetui_core/src/widgets/widget.container.dart';
import '../utils.dart';

void main() {
  RVerticalContainerWidgetBuilder? builder;
  Rokeet? rokeet;

  group("Vertical Container Widget Builder", () {
    setUp(() async {
      rokeet = Rokeet();
      rokeet?.widgetBuilderRegistry.register("label", RLabelWidgetBuilder());
      builder = RVerticalContainerWidgetBuilder();
    });

    test("should create vertical container with children", (){
      var verticalContainer = RVerticalContainerWidget.fromJson(loadJson('widgets/vertical_container'));
      var widget = builder!.build(rokeet!, verticalContainer) as Column;
      expect(widget.children.length, 2);
    });
  });
}
