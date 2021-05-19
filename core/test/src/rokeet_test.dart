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
  RokeetApi? mockApi;
  BuildContext? context;

  void configureRInit() {
    AppConfig init = AppConfig.fromJson(loadJson('rokeet/appconfig'));
    final future = Future.value(init);
    when(mockApi?.getApp('client_id', 'client_secret'))
        .thenAnswer((_) => future);
  }

  setUp(() {
    mockApi = MockRokeetApi();
    context = MockBuildContext();
    Rokeet().api = mockApi;
    configureRInit();
  });
  tearDown(() {
    clearInteractions(mockApi);
    Rokeet().api = null;
  });

  group('Rokeet', () {
    test('should init with config', () {
      var config = RokeetConfig(
          clientId: 'client_id',
          clientSecret: "client_secret",
          widgetBuilders: Map(),
          actionPerformers: Map());

      var mockState = MockRState();
      configureRInit();
      return Rokeet.init(config, mockState, context!)
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

      return Rokeet.init(config, mockState, context!).then((appConfig) => expect(
          Rokeet().widgetBuilderRegistry.get(RVerticalContainerWidget.TYPE),
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

      return Rokeet.init(config, mockState, context!).then((appConfig) => expect(
          Rokeet().actionPerformerRegistry.get(RNavigateAction.TYPE),
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

      return Rokeet.init(config, mockState, context!).then((appConfig) {
        var rokeet = Rokeet();
        var widgetDefinition =
            RWidgetParser.parse(loadJson('rokeet/widget'))!;
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
      return Rokeet.init(config, mockState, context!).then((appConfig) {
        var rokeet = Rokeet();
        var action = RActionParser.parse(loadJson('rokeet/action'))!;
        rokeet.performAction(action);
        verify(expectPerformer.performAction(rokeet, action)).called(1);
      });
    });
  });
}
