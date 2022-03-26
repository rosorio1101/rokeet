import 'package:flutter/material.dart';
import 'package:rokeet/rokeet.dart';

void main() {
  runApp(MyApp());
}

Map<String, RWidgetBuilder> _createBuilders() {
  Map<String, RWidgetBuilder> builders = Map();
  builders[RLabelWidget.TYPE] = RLabelWidgetBuilder();
  builders[RVerticalContainerWidget.TYPE] = RVerticalContainerWidgetBuilder();
  builders[RButtonWidget.TYPE] = RButtonWidgetBuilder();
  return builders;
}

Map<String, RActionPerformer> _createPerformers() {
  Map<String, RActionPerformer> performers = Map();
  performers[RNavigateAction.TYPE] = RNavigateActionPerformer();
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
