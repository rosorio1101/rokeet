import 'package:flutter/material.dart';
import 'package:rokeetui_core/src/model.dart';

import '../rokeet.dart';
import 'page.dart';

class RokeetStepPage extends AbstractRokeetPage {
  RokeetStepPage({Key? key, this.stepId = ''}) : super(key: key);

  final String stepId;

  @override
  _RokeetStepPageState createState() => _RokeetStepPageState();
}

class _RokeetStepPageState extends RState<RokeetStepPage, RStep> {
  @override
  void initState() {
    super.initState();
    rokeet.currentState = this;
    rokeet.currentContext = context;
    rokeet.getStep(widget.stepId);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading || data == null) {
      return getLoadingWidget();
    }
    return Scaffold(body: SafeArea(
      child: rokeet.buildWidget(data!.body!)!,
    ));
  }

  @override
  void onDataLoaded(RStep data) {
    setState(() {
      this.data = data;
    });
  }
}
