import 'package:flutter/widgets.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rokeet/core.dart';
import 'package:rokeet/src/model.dart';
import 'package:rokeet/src/network/rokeet_api.dart';
import 'package:rokeet/src/pages/page.dart';
import 'package:test/test.dart';

import 'rokeet_test.mocks.dart';
import 'utils.dart';

@GenerateMocks([RState, RokeetApi, RActionPerformer, BuildContext])
void main() {
  late RokeetApi mockApi;
  BuildContext? context;
  late Rokeet rokeet;
  void configureRInit() {
    AppConfig init = AppConfig.fromJson(loadJson('rokeet/appconfig'));
    final future = Future.value(init);
    when(mockApi.getApp('client_id', 'client_secret'))
        .thenAnswer((_) => future);
  }

  setUp(() {
    mockApi = MockRokeetApi();
    context = MockBuildContext();
    configureRInit();
  });
  tearDown(() {
    clearInteractions(mockApi);
  });

  Rokeet _buildRokeet(RokeetConfig config) {
    return RokeetBuilder()
        .withBaseUrl("http://localhost:3000")
        .withConfig(config)
        .build();
  }

  group('Rokeet', () {
    test('should init with config', () {
      var config = RokeetConfig(
          clientId: 'client_id',
          clientSecret: "client_secret",
          widgetBuilders: Map(),
          actionPerformers: Map());

      var mockState = MockRState();
      configureRInit();
      rokeet = _buildRokeet(config);
      rokeet.api = mockApi;
      return rokeet
          .init(mockState, context!)
          .then((rokeet) => expect(rokeet, isNotNull));
    });

    test('should init and register builders', () {
      var expectedBuilder = RVerticalContainerWidgetBuilder();
      var builders = Map<String, RWidgetBuilder>();
      builders[RVerticalContainerWidget.TYPE] = expectedBuilder;

      var config = RokeetConfig(
          clientId: "client_id",
          clientSecret: "client_secret",
          widgetBuilders: builders,
          actionPerformers: Map());
      var mockState = MockRState();
      rokeet = _buildRokeet(config);
      rokeet.api = mockApi;
      return rokeet.init(mockState, context!).then((appConfig) => expect(
          rokeet.widgetBuilderRegistry.get(RVerticalContainerWidget.TYPE),
          equals(expectedBuilder)));
    });

    test('should init and register performers', () {
      var expectPerformer = RNavigateActionPerformer();
      var performers = Map<String, RActionPerformer>();
      performers[RNavigateAction.TYPE] = expectPerformer;

      var config = RokeetConfig(
          clientId: "client_id",
          clientSecret: "client_secret",
          widgetBuilders: Map(),
          actionPerformers: performers);
      var mockState = MockRState();
      rokeet = _buildRokeet(config);
      rokeet.api = mockApi;
      return rokeet.init(mockState, context!).then((appConfig) => expect(
          rokeet.actionPerformerRegistry.get(RNavigateAction.TYPE),
          equals(expectPerformer)));
    });

    test('should build widget', () {
      var expectedBuilder = RVerticalContainerWidgetBuilder();
      var builders = Map<String, RWidgetBuilder>();
      builders[RVerticalContainerWidget.TYPE] = expectedBuilder;

      var config = RokeetConfig(
          clientId: "client_id",
          clientSecret: "client_secret",
          widgetBuilders: builders,
          actionPerformers: Map());
      var mockState = MockRState();
      rokeet = _buildRokeet(config);
      rokeet.api = mockApi;
      return rokeet.init(mockState, context!).then((appConfig) {
        var widgetDefinition = RWidgetParser.parse(loadJson('rokeet/widget'))!;
        var widget = rokeet.buildWidget(widgetDefinition);
        expect(widget, isNotNull);
        expect(widget, isA<Column>());
      });
    });

    test('should perform action', () {
      var expectPerformer = MockRActionPerformer();
      var performers = Map<String, RActionPerformer>();
      performers[RNavigateAction.TYPE] = expectPerformer;

      var config = RokeetConfig(
          clientId: "client_id",
          clientSecret: "client_secret",
          widgetBuilders: Map(),
          actionPerformers: performers);
      var mockState = MockRState();
      rokeet = _buildRokeet(config);
      rokeet.api = mockApi;
      return rokeet.init(mockState, context!).then((appConfig) {
        var action = RActionParser.parse(loadJson('rokeet/action'))!;
        rokeet.performAction(action);
        verify(expectPerformer.performAction(rokeet, action)).called(1);
      });
    });
  });
}
