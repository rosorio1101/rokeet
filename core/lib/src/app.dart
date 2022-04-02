import 'package:flutter/material.dart';

import 'model.dart';
import 'pages/pages.dart';
import 'rokeet.dart';

class RokeetApp extends AbstractRokeetPage {
  RokeetApp(
    this.rokeet, {
    Key? key,
    this.title = '',
  }) : super(rokeet, key: key);

  final String title;
  final Rokeet rokeet;

  @override
  _AppState createState() => _AppState();
}

class _AppState extends RState<RokeetApp, AppConfig> {
  Widget _getHome(BuildContext context) => FutureBuilder<AppConfig?>(
      future: rokeet.init(this, context),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return getLoadingWidget();
        }

        var data = snapshot.data;
        if (data == null) {
          return Center(
            child: Text('Config not found'),
          );
        }
        var key = data.initStep!;
        RPageCreator creator = rokeet.getPageCreator(key);
        return creator.call(rokeet, key) as Widget;
      });

  @override
  Widget buildPage(BuildContext context) {
    return MaterialApp(
      title: widget.title,
      home: _getHome(context),
      onGenerateRoute: (settings) {
        var uri = Uri.parse(settings.name!);
        if (uri.pathSegments.first == 'steps' &&
            uri.queryParameters['id'] != null) {
          var stepId = uri.queryParameters['id']!;
          return MaterialPageRoute(
              builder: (context) => RokeetStepPage(
                    rokeet,
                    stepId: stepId,
                  ));
        }
        return MaterialPageRoute(builder: (context) => RokeetUnknownPage());
      },
    );
  }
}
