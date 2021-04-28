import 'package:flutter/material.dart';

import '../rokeet.dart';

abstract class AbstractRokeetPage extends StatefulWidget {
  AbstractRokeetPage({Key? key}) : super(key: key);
}

abstract class RState<T extends AbstractRokeetPage, D> extends State<T> {
  D? data;
  late Rokeet rokeet;

  bool isLoading() {
    return rokeet.isLoading();
  }

  Widget loadingWidget() {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }

  void onDataLoaded(D data);
}
