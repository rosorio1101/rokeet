import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rokeetui_core/core.dart';
import 'package:rokeetui_core/src/widgets/widget.button.dart';

import '../utils.dart';

void main() {
  group("Widget Button Test", () {
    RButtonWidgetBuilder? builder;
    Rokeet? rokeet;
    setUp(() {
      builder = RButtonWidgetBuilder();
      rokeet = Rokeet();
    });

    test("Builder should build a Button with Data", () {
      var button = RButtonWidget.fromJson(loadJson('widgets/button_builder/button'));
      var buttonWidget = builder!.build(rokeet!, button) as ElevatedButton;
      var buttonLabel = buttonWidget.child as Text;
      expect(button.data!.text, buttonLabel.data);
    });
  });
}