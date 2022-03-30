import 'package:flutter/material.dart';
import 'package:rokeet/rokeet.dart';

void main() {
  runApp(MyApp());
}

Map<String, Map<RWidgetBuilder, RWidgetParserFunction>> _createBuilders() {
  Map<String, Map<RWidgetBuilder, RWidgetParserFunction>> builders = Map();
  builders[RLabelWidget.TYPE] = {
    RLabelWidgetBuilder(): RLabelWidget.jsonParser
  };
  builders[RVerticalContainerWidget.TYPE] = {
    RVerticalContainerWidgetBuilder(): RVerticalContainerWidget.jsonParser
  };
  builders[RButtonWidget.TYPE] = {
    RButtonWidgetBuilder(): RButtonWidget.jsonParser
  };
  return builders;
}

Map<String, Map<RActionPerformer, RActionParserFunction>> _createPerformers() {
  Map<String, Map<RActionPerformer, RActionParserFunction>> performers = Map();
  performers[RNavigateAction.TYPE] = {
    RNavigateActionPerformer(): RNavigateAction.jsonParser
  };
  return performers;
}

class MyApp extends StatelessWidget {
  final config = RokeetConfig(
      clientId: "rokeet",
      clientSecret: "rokeet_secret",
      widgetBuilders: _createBuilders(),
      actionPerformers: _createPerformers());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var rokeet = RokeetBuilder()
        .withBaseUrl('http://localhost:3000')
        .withConfig(config)
        .build();
    return RokeetApp(
      rokeet,
    );
  }
}
