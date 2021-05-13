import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rokeetui_core/rokeetui_core.dart';
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

    testWidgets("Builder should build a Button with Data", (tester) async {
      var button = RButtonWidget.fromJson(loadJson('widgets/button'));
      var buttonWidget = builder!.build(rokeet!, button);
      var materialApp = MaterialApp(
        home: buttonWidget,
      );
      await tester.pumpWidget(materialApp);

      expect(find.text("Click Me!"), findsOneWidget);
    });
  });
}
