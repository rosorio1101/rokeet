import 'package:flutter/material.dart';
import 'errors.dart';
import 'model.dart';
import 'pages/pages.dart';
import 'rokeet.dart';

class App extends AbstractRokeetPage {
  App({
    Key? key,
    this.title = '',
    this.config,
  }) : super(key: key);

  final String title;
  final RokeetConfig? config;

  @override
  _RokeetAppState createState() => _RokeetAppState();
}

class _RokeetAppState extends RState<App, RokeetApp> {
  @override
  void initState() {
    rokeet = Rokeet();

    if (widget.config == null) {
      throw IllegalStateError("Config must not be null");
    }

    Rokeet.init(widget.config!, this);
    super.initState();
  }

  Widget _getHome() {
    if (rokeet.isLoading() || data == null) {
        return MaterialApp(
          home: getLoadingWidget(),
        );
    } else {
      if(data!.initStep == null) {
        throw InitStepError();
      }
      return RokeetStepPage(stepId: data!.initStep!,);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: widget.title,
      home: _getHome(),
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

  @override
  void onDataLoaded(RokeetApp data) {
    setState(() {
      data = data;
    });
  }
}