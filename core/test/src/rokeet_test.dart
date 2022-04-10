import 'package:flutter/widgets.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rokeet/rokeet.dart';
import 'package:rokeet/src/model.dart';
import 'package:rokeet/src/network/rokeet_api.dart';
import 'package:test/test.dart';

import 'rokeet_test.mocks.dart';
import 'utils.dart';

@GenerateMocks([
  RokeetApi,
  RActionPerformer,
  BuildContext
], customMocks: [
  MockSpec<RState>(as: #MockRState, unsupportedMembers: {#property, #widget}),
  MockSpec<State>(unsupportedMembers: {#widget})
])
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
    when(mockApi.getApp("client_id", "client_secret"))
        .thenAnswer((_) => Future.value(AppConfig("login")));
  });
  tearDown(() {
    clearInteractions(mockApi);
  });

  Rokeet _buildRokeet(RokeetConfig config) {
    return Rokeet.builder()
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
      var expectedBuilder = {
        RVerticalContainerWidgetBuilder(): RVerticalContainerWidget.jsonParser
      };
      var builders = Map<String, Map<RWidgetBuilder, RWidgetParserFunction>>();
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
          equals(expectedBuilder.keys.first)));
    });

    test('should init and register performers', () {
      var expectPerformer = {
        RNavigateActionPerformer(): RNavigateAction.jsonParser
      };
      var performers =
          Map<String, Map<RActionPerformer, RActionParserFunction>>();
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
          equals(expectPerformer.keys.first)));
    });

    test('should build widget', () {
      var expectedBuilder = {
        RVerticalContainerWidgetBuilder(): RVerticalContainerWidget.jsonParser
      };
      var builders = Map<String, Map<RWidgetBuilder, RWidgetParserFunction>>();
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
      RActionPerformer expectedPerformer = MockRActionPerformer();
      var mapPerformers = {expectedPerformer: RNavigateAction.jsonParser};
      var performers =
          Map<String, Map<RActionPerformer, RActionParserFunction>>();
      performers[RNavigateAction.TYPE] = mapPerformers;

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
        verify(expectedPerformer.performAction(rokeet, action)).called(1);
      });
    });
  });
}
