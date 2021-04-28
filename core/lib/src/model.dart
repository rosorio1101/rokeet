import 'actions/action.dart';
import 'widgets/widget.dart';

class RStep {
  RWidget? header;
  RWidget? body;

  RStep.fromJson(Map<String, dynamic> json) {
    if (json['head'] != null) {
      header = RWidgetParser.parse(json['head']);
    }

    if (json['body'] != null) {
      body = RWidgetParser.parse(json['body']);
    }
  }
}

class RInit {
  RAction? action;

  RInit.fromJson(Map<String, dynamic> json) {
    action = RActionParser.parse(json['action']);
  }
}
