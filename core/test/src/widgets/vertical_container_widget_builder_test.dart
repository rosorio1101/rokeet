import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rokeet/rokeet.dart';

import '../utils.dart';

void main() {
  RVerticalContainerWidgetBuilder? builder;
  Rokeet? rokeet;

  Map<String, Map<RWidgetBuilder, RWidgetParserFunction>> baseWidgets = {
    RLabelWidget.TYPE: {RLabelWidgetBuilder(): RLabelWidget.jsonParser},
    RButtonWidget.TYPE: {RButtonWidgetBuilder(): RButtonWidget.jsonParser},
    RVerticalContainerWidget.TYPE: {
      RVerticalContainerWidgetBuilder(): (json) =>
          RVerticalContainerWidget.jsonParser(json)
    }
  };

  Map<String, Map<RActionPerformer, RActionParserFunction>> baseActions = {
    RNavigateAction.TYPE: {
      RNavigateActionPerformer(): (json) => RNavigateAction.jsonParser(json)
    }
  };

  group("Vertical Container Widget Builder", () {
    setUp(() async {
      var config = RokeetConfig(
          clientId: 'client_id',
          clientSecret: "client_secret",
          widgetBuilders: baseWidgets,
          actionPerformers: baseActions);
      rokeet = Rokeet.builder()
          .withConfig(config)
          .withBaseUrl("http://test.com")
          .build();
      builder = RVerticalContainerWidgetBuilder();
      rokeet?.widgetBuilderRegistry.register("label", RLabelWidgetBuilder());
      rokeet?.widgetBuilderRegistry
          .register(RVerticalContainerWidget.TYPE, builder!);
    });

    testWidgets("should create vertical container with children",
        (tester) async {
      RWidgetParser.parsers[RVerticalContainerWidget.TYPE] =
          RVerticalContainerWidget.jsonParser;
      var verticalContainer = RVerticalContainerWidget.jsonParser(
          loadJson('widgets/vertical_container'))!;
      var widget = builder!.build(rokeet!, verticalContainer);
      var app = MaterialApp(
        home: widget,
      );
      await tester.pumpWidget(app);
      expect(find.text("Hello World!"), findsNWidgets(2));
    });
  });
}
