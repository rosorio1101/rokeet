import 'package:flutter/material.dart';

import '../rokeet.dart';

typedef T RPageCreator<T extends AbstractRokeetPage, D>(Rokeet rokeet, D data);

abstract class AbstractRokeetPage extends StatefulWidget {
  final Rokeet rokeet;
  AbstractRokeetPage(this.rokeet, {Key? key}) : super(key: key);
}

abstract class RState<T extends AbstractRokeetPage, D> extends State<T> {
  D? data;
  Rokeet get rokeet => widget.rokeet;

  bool get isLoading => rokeet.isLoading;

  @override
  void dispose() {
    super.dispose();
    rokeet.popContext();
    rokeet.popState();
  }

  @override
  void initState() {
    super.initState();
    rokeet.pushState(this);
  }

  Widget getLoadingWidget() {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }

  @override
  Widget build(BuildContext context) {
    rokeet.pushContext(context);
    return buildPage(context);
  }

  @protected
  Widget buildPage(BuildContext context);
}
