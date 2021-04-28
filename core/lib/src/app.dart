import 'package:flutter/material.dart';
import 'pages/page.init.dart';
import 'pages/page.step.dart';
import 'pages/pages.dart';
import 'rokeet.dart';

class RokeetApp extends StatelessWidget {
  RokeetApp({
    Key? key,
    this.title = '',
    this.config,
  }) : super(key: key);

  final String title;
  final RokeetConfig? config;

  @override
  Widget build(BuildContext context) {
    if (config == null) {}
    return MaterialApp(
      title: title,
      home: RokeetInitPage(
        config: config,
      ),
      onGenerateRoute: (settings) {
        var uri = Uri.parse(settings.name!);
        if (uri.pathSegments.first == 'steps' && uri.queryParameters['id'] != null) {
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
