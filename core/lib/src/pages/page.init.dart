import 'package:flutter/material.dart';

import '../errors.dart';
import '../model.dart';
import '../rokeet.dart';
import 'page.dart';

class RokeetInitPage extends AbstractRokeetPage {
  RokeetInitPage({Key? key, this.config}) : super(key: key);

  final RokeetConfig? config;

  @override
  _RokeetInitPageState createState() => _RokeetInitPageState();
}

class _RokeetInitPageState extends RState<RokeetInitPage, RInit> {
  @override
  void initState() async {
    super.initState();
    if (widget.config == null) {
      throw IllegalStateError("config must not be null");
    }
    rokeet = await Rokeet.init(widget.config!, this);
  }

  @override
  Widget build(BuildContext context) {
    rokeet.currentContext = context;
    return loadingWidget();
  }

  @override
  void onDataLoaded(RInit data) {
    if (data.action != null) {
      rokeet.performAction(data.action!);
    }
  }
}
