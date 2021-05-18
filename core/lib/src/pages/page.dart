import 'package:flutter/material.dart';

import '../rokeet.dart';

abstract class AbstractRokeetPage extends StatefulWidget {
  AbstractRokeetPage({Key? key}) : super(key: key);
}

abstract class RState<T extends AbstractRokeetPage, D> extends State<T> {
  D? data;
  final Rokeet rokeet = Rokeet();

  bool get isLoading => rokeet.isLoading;

  Widget getLoadingWidget() {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }

  @deprecated
  void onDataLoaded(D data);
}
