import '../errors.dart';
import '../rokeet.dart';
import 'action.dart';
import 'actions.performer.dart';

class _NavigateActionData {
  late String target;
  late bool force;
  _NavigateActionData.empty() {
    target = "";
    force = false;
  }
  _NavigateActionData._fromJson(Map<String, dynamic> json) {
    target = json['target'] ?? "";
    force = json['force'] ?? false;
  }
}

class RNavigateAction extends RAction<_NavigateActionData> {
  static const String TYPE = "navigate";

  static final RActionParserFunction<RNavigateAction> jsonParser =
      (json) => RNavigateAction._fromJson(json);

  RNavigateAction._fromJson(Map<String, dynamic> json) : super.fromJson(json);

  @override
  _NavigateActionData parseData(Map<String, dynamic> json) =>
      _NavigateActionData._fromJson(json);
}

class RNavigateActionPerformer implements RActionPerformer<RNavigateAction> {
  @override
  void performAction(Rokeet rokeet, RNavigateAction action) {
    if (action.data == null) {
      throw IllegalStateError("Action data must not be null");
    }
    final data = action.data ?? _NavigateActionData.empty();
    rokeet.navigateToStep(data.target, force: data.force);
  }
}
