import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rokeet/core.dart';
import 'package:rokeet/src/widgets/widget_vertical_container.dart';
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

    testWidgets("should create vertical container with children",
        (tester) async {
      var verticalContainer = RVerticalContainerWidget.fromJson(
          loadJson('widgets/vertical_container'));
      var widget = builder!.build(rokeet!, verticalContainer);
      var app = MaterialApp(
        home: widget,
      );
      await tester.pumpWidget(app);
      expect(find.text("Hello World!"), findsNWidgets(2));
    });
  });
}
