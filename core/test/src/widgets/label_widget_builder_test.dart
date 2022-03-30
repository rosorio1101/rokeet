import 'package:flutter_test/flutter_test.dart';
import 'package:rokeet/rokeet.dart';

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
      var label = RLabelWidget.jsonParser(loadJson('widgets/label'))!;
      var labelWidget = builder!.build(rokeet!, label);
      await tester.pumpWidget(labelWidget);
      expect(find.text("Hello World!"), findsOneWidget);
    });
  });
}
