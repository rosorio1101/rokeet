import 'package:flutter/material.dart';
import 'package:rokeet/rokeet.dart';
import 'package:test_app/main_page.dart';

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

Map<String, RPageCreator> _createPageCreators() => {"main": MainPage.CREATOR};

class MyApp extends StatelessWidget {
  final config = RokeetConfig(
      clientId: "rokeet",
      clientSecret: "rokeet_secret",
      widgetBuilders: _createBuilders(),
      actionPerformers: _createPerformers(),
      pageCreators: _createPageCreators());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var rokeet = RokeetBuilder()
        .withBaseUrl('http://10.0.2.2:3000')
        .withConfig(config)
        .build();
    return RokeetApp(
      rokeet,
    );
  }
}
