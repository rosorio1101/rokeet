import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rokeetui_core/rokeetui_core.dart';
import 'package:rokeetui_core/src/widgets/widget.label.dart';

import '../utils.dart';

void main() {
  RLabelWidgetBuilder? builder;
  Rokeet? rokeet;
  group('Label Widget Builder Test', () {
    setUp(() {
      builder = RLabelWidgetBuilder();
      rokeet = Rokeet();
    });

    testWidgets('Builder should build a Label with Data', (tester) async {
      var label = RLabelWidget.fromJson(loadJson('widgets/label'));
      var labelWidget =  builder!.build(rokeet!, label) as Text;
      expect(label.data!.text, labelWidget.data!);
    });
  });
}