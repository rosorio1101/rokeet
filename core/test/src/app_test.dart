import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rokeet_ui/rokeet_ui.dart';
import 'package:rokeet_ui/src/model.dart';
import 'package:rokeet_ui/src/network/network.dart';

import 'rokeet_test.mocks.dart';
import 'utils.dart';

void main() {
  group("App", () {
    RokeetApi? mockApi;

    void configureMockApi() {
      mockApi = MockRokeetApi();
      AppConfig init = AppConfig.fromJson(loadJson('app/appconfig'));
      RStep loginStep = RStep.fromJson(loadJson('app/login_step'));

      when(mockApi?.getApp('client_id', 'client_secret'))
          .thenAnswer((_) => Future.value(init));

      when(mockApi?.getStep('login'))
          .thenAnswer((_) => Future.value(loginStep));
    }

    setUp((){
      configureMockApi();
    });
    testWidgets("App should show loading", (tester) async {
      var config = RokeetConfig(
          clientId: 'client_id',
          clientSecret: "client_secret",
          widgetBuilders: {
            "label": RLabelWidgetBuilder(),
            "button": RButtonWidgetBuilder(),
            "vertical_container": RVerticalContainerWidgetBuilder()
          },
          actionPerformers: Map());

      Rokeet().api = mockApi;
      await tester.pumpWidget(RokeetApp(
          config: config
      ));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets("App should initialize successful", (tester) async {
      var config = RokeetConfig(
          clientId: 'client_id',
          clientSecret: "client_secret",
          widgetBuilders: {
            "label": RLabelWidgetBuilder(),
            "button": RButtonWidgetBuilder(),
            "vertical_container": RVerticalContainerWidgetBuilder()
          },
          actionPerformers: Map());

      Rokeet().api = mockApi;
      await tester.pumpWidget(RokeetApp(
        config: config
      ));
      await tester.pumpAndSettle(
        Duration(seconds: 10), EnginePhase.build, Duration(minutes: 1)
      );

      expect(find.byType(Text), findsNWidgets(4));
      expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });
}