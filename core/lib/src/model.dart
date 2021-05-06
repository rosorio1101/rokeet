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

class AppConfig {
  AppConfig(this.initStep);
  String? initStep;

  factory AppConfig.fromJson(Map<String, dynamic> json){
    return AppConfig(
      json['init_step']
    );
  }
}

class RInit {
  RAction? action;

  RInit.fromJson(Map<String, dynamic> json) {
    action = RActionParser.parse(json['action']);
  }
}
