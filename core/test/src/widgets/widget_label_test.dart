import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:rokeetui_core/core.dart';
import 'package:rokeetui_core/src/widgets/widget.label.dart';

import '../utils.dart';

@GenerateMocks([RState, BuildContext])
void main() {
  RLabelWidgetBuilder? builder;
  BuildContext? context;
  group('Widget Label Test', () {
    setUp(() {
      builder = RLabelWidgetBuilder();
    });

    testWidgets('Builder should build a Label with Data', (tester) async {
      var rokeet = Rokeet();
      var label = RLabelWidget.fromJson(loadJson('widgets/label_builder/label'));
      var labelWidget =  builder!.build(rokeet, label) as Text;
      expect("Hello World!", labelWidget.data!);
    });
  });
}