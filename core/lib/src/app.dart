import 'package:flutter/material.dart';
import 'model.dart';
import 'pages/pages.dart';
import 'rokeet.dart';

class RokeetApp extends AbstractRokeetPage {
  RokeetApp({
    Key? key,
    this.title = '',
    this.config,
  }) : super(key: key);

  final String title;
  final RokeetConfig? config;

  @override
  _AppState createState() => _AppState();
}

class _AppState extends RState<RokeetApp, AppConfig> {

  Widget _getHome(BuildContext context) => FutureBuilder<AppConfig?>(
      future: Rokeet.init(widget.config!, this, context),
      builder: (context, snapshot) {
        if(snapshot.connectionState != ConnectionState.done) {
          return getLoadingWidget();
        }

        var data = snapshot.data;
        if(data == null) {
          return Center(
            child: Text('Config not found'),
          );
        }
        return RokeetStepPage(stepId: data.initStep!);
      });

  @override
  Widget buildPage(BuildContext context) {
    return  MaterialApp(
      title: widget.title,
      home: _getHome(context),
      onGenerateRoute: (settings) {
        var uri = Uri.parse(settings.name!);
        if (uri.pathSegments.first == 'steps' &&
            uri.queryParameters['id'] != null) {
          var stepId = uri.queryParameters['id']!;
          return MaterialPageRoute(
              builder: (context) => RokeetStepPage(
                stepId: stepId,
              ));
        }
        return MaterialPageRoute(builder: (context) => RokeetUnknownPage());
      },
    );
  }
}
