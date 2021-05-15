import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rokeet_ui/rokeet_ui.dart';
import 'package:rokeet_ui/src/widgets/widget_label.dart';

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
      var labelWidget = builder!.build(rokeet!, label);
      await tester.pumpWidget(labelWidget);
      expect(find.text("Hello World!"), findsOneWidget);
    });
  });
}
