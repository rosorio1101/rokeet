import 'package:flutter/material.dart';
import 'package:rokeetui_core/src/pages/page.step.dart';
import 'action.dart';
import '../errors.dart';
import '../rokeet.dart';
import 'actions.performer.dart';

class NavigateActionData {
  String? target;
  bool? force;
}

class RNavigateAction extends RAction<NavigateActionData> {
  static const String TYPE = "navigate";

  RNavigateAction.fromJson(Map<String, dynamic> json) : super.fromJson(json);

  @override
  NavigateActionData parseData(Map<String, dynamic> json) {
    var data = NavigateActionData();
    data.target = json['target'];
    data.force = json['force'];
    return data;
  }
}

class RNavigateActionPerformer implements RActionPerformer<RNavigateAction> {
  @override
  void performAction(Rokeet rokeet, RNavigateAction action) {
    if (rokeet.currentContext == null) {
      throw IllegalStateError("Current context must not be null");
    }

    if (action.data == null) {
      throw IllegalStateError("Action data must not be null");
    }
    var context = rokeet.currentContext!;
    var data = action.data!;
    if (data.force == true) {
      var uri = Uri.parse(data.target!);
      var id = uri.queryParameters['id'];
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => RokeetStepPage(
            stepId: id!,
          ),
          transitionDuration: Duration(seconds: 0),
        ),
      );
    } else {
      Navigator.pushNamed(rokeet.currentContext!, data.target!);
    }
  }
}
