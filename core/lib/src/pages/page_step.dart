import 'package:flutter/material.dart';

import '../model.dart';
import 'page.dart';

class RokeetStepPage extends AbstractRokeetPage {
  static RPageCreator CREATOR =
      (rokeet, data) => RokeetStepPage(rokeet, stepId: data);

  RokeetStepPage(rokeet, {Key? key, this.stepId = ''})
      : super(rokeet, key: key);

  final String stepId;

  @override
  _RokeetStepPageState createState() => _RokeetStepPageState();
}

class _RokeetStepPageState extends RState<RokeetStepPage, RStep> {
  @override
  Widget buildPage(BuildContext context) => FutureBuilder<RStep?>(
      future: rokeet.getStep(widget.stepId),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return getLoadingWidget();
        }

        var data = snapshot.data;
        var body = rokeet.buildWidget(data!.body!)!;
        Key key = Key(data.id!);
        return Scaffold(
          body: SafeArea(
            child: body,
          ),
          key: key,
        );
      });
}
