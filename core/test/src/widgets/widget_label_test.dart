import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:rokeetui_core/core.dart';
import 'package:rokeetui_core/src/widgets/widget.label.dart';

import '../utils.dart';

@GenerateMocks([RState, BuildContext])
void main() {
  RLabelWidgetBuilder? builder;
  Rokeet? rokeet;
  group('Widget Label Test', () {
    setUp(() {
      builder = RLabelWidgetBuilder();
      rokeet = Rokeet();
    });

    testWidgets('Builder should build a Label with Data', (tester) async {
      var label = RLabelWidget.fromJson(loadJson('widgets/label_builder/label'));
      var labelWidget =  builder!.build(rokeet!, label) as Text;
      expect(label.data!.text, labelWidget.data!);
    });
  });
}