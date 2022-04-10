import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rokeet/rokeet.dart';
import 'package:rokeet/src/model.dart';
import 'package:rokeet/src/network/network.dart';

import 'rokeet_test.mocks.dart';
import 'utils.dart';

void main() {
  group("App", () {
    RokeetApi? mockApi;

    void _configureMockApi() {
      mockApi = MockRokeetApi();
      AppConfig init = AppConfig.fromJson(loadJson('app/appconfig'));
      RStep loginStep = RStep.fromJson(loadJson('app/login_step'));
      RStep homeStep = RStep.fromJson(loadJson('app/home_step'));

      when(mockApi?.getApp('client_id', 'client_secret'))
          .thenAnswer((_) => Future.value(init));

      when(mockApi?.getStep('login'))
          .thenAnswer((_) => Future.value(loginStep));

      when(mockApi?.getStep('home')).thenAnswer((_) => Future.value(homeStep));
    }

    Rokeet _buildRokeet(RokeetConfig config) {
      return Rokeet.builder()
          .withBaseUrl("http://localhost:3000")
          .withConfig(config)
          .build();
    }

    Map<String, Map<RWidgetBuilder, RWidgetParserFunction>> baseWidgets = {
      RLabelWidget.TYPE: {RLabelWidgetBuilder(): RLabelWidget.jsonParser},
      RButtonWidget.TYPE: {RButtonWidgetBuilder(): RButtonWidget.jsonParser},
      RVerticalContainerWidget.TYPE: {
        RVerticalContainerWidgetBuilder(): (json) =>
            RVerticalContainerWidget.jsonParser(json)
      }
    };

    Map<String, Map<RActionPerformer, RActionParserFunction>> baseActions = {
      RNavigateAction.TYPE: {
        RNavigateActionPerformer(): (json) => RNavigateAction.jsonParser(json)
      }
    };

    testWidgets("App should show loading", (tester) async {
      var config = RokeetConfig(
          clientId: 'client_id',
          clientSecret: "client_secret",
          widgetBuilders: baseWidgets,
          actionPerformers: Map());
      var rokeet = _buildRokeet(config);
      _configureMockApi();
      rokeet.api = mockApi!;
      await tester.pumpWidget(RokeetApp(rokeet));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets("App should initialize successful", (tester) async {
      var config = RokeetConfig(
          clientId: 'client_id',
          clientSecret: "client_secret",
          widgetBuilders: baseWidgets,
          actionPerformers: Map());

      var rokeet = _buildRokeet(config);
      _configureMockApi();
      rokeet.api = mockApi!;
      await tester.pumpWidget(RokeetApp(rokeet));
      await tester.pumpAndSettle(
          Duration(seconds: 10), EnginePhase.build, Duration(minutes: 1));

      expect(find.byType(Text), findsNWidgets(4));
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets("App should show no config message", (tester) async {
      var config = RokeetConfig(
          clientId: 'client_id',
          clientSecret: "client_secret",
          widgetBuilders: baseWidgets,
          actionPerformers: Map());

      var rokeet = _buildRokeet(config);
      rokeet.api = mockApi!;
      when(mockApi?.getApp('client_id', 'client_secret'))
          .thenAnswer((_) => Future.value(null));
      await tester.pumpWidget(RokeetApp(rokeet));
      await tester.pumpAndSettle(
          Duration(seconds: 10), EnginePhase.build, Duration(minutes: 1));

      expect(find.byType(Text), findsNWidgets(1));
      expect(find.text('Config not found'), findsOneWidget);
    });

    testWidgets("App should navigate between steps", (tester) async {
      var config = RokeetConfig(
          clientId: 'client_id',
          clientSecret: "client_secret",
          widgetBuilders: baseWidgets,
          actionPerformers: baseActions);

      var rokeet = _buildRokeet(config);
      _configureMockApi();
      rokeet.api = mockApi!;
      await tester.pumpWidget(RokeetApp(rokeet));
      await tester.pumpAndSettle(
          Duration(seconds: 10), EnginePhase.build, Duration(minutes: 1));
      var findLoginButton = find.widgetWithText(ElevatedButton, 'Login');
      expect(findLoginButton, findsOneWidget);

      ElevatedButton loginButton = tester.widget(findLoginButton);
      loginButton.onPressed!();

      await tester.pumpAndSettle(
          Duration(seconds: 10), EnginePhase.build, Duration(minutes: 1));
      expect(find.text('Welcome to Rokeet!'), findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, 'Click me!'), findsOneWidget);
    });
  });
}
