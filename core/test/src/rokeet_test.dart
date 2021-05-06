import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rokeetui_core/core.dart';
import 'package:rokeetui_core/src/model.dart';
import 'package:rokeetui_core/src/network/rokeet_api.dart';
import 'package:rokeetui_core/src/pages/page.dart';
import 'package:test/test.dart';

import 'rokeet_test.mocks.dart';
import 'utils.dart';

@GenerateMocks([RState, RokeetApi, RActionPerformer])
void main() {
  MockRokeetApi? mockApi;

  void configureRInit() {
    RInit init = RInit.fromJson(loadJson('rokeet.test/rinit'));
    final future = Future.value(init);

    when(mockApi?.initRokeet(any)).thenAnswer((_) => future);
  }

  setUp(() {
    mockApi = MockRokeetApi();
    Rokeet().api = mockApi;
    configureRInit();
  });
  tearDown(() {
    clearInteractions(mockApi);
    Rokeet().api = null;
  });

  group('Rokeet', () {
    test('should init with config', () async {
      var config = RokeetConfig(
          clientId: "client_id",
          clientSecret: "client_secret",
          widgetBuilders: Map(),
          actionPerformers: Map());

      var mockState = MockRState();
      configureRInit();
      var rokeet = await Rokeet.init(config, mockState);
      expect(rokeet, isNotNull);
      verify(mockState.onDataLoaded(any));
    });

    test('should init and register builders', () async {
      var expectedBuilder = RVerticalContainerWidgetBuilder();
      var builders = Map<String, RWidgetBuilder>();
      builders[RVerticalContainerWidget.TYPE] = expectedBuilder;

      var config = RokeetConfig(
          clientId: "client_id",
          clientSecret: "client_secret",
          widgetBuilders: builders,
          actionPerformers: Map());
      var mockState = MockRState();

      await Rokeet.init(config, mockState);
      expect(Rokeet().widgetBuilderRegistry.get(RVerticalContainerWidget.TYPE),
          equals(expectedBuilder));
    });

    test('should init and register performers', () async {
      var expectPerformer = RNavigateActionPerformer();
      var performers = Map<String, RActionPerformer>();
      performers[RNavigateAction.TYPE] = expectPerformer;

      var config = RokeetConfig(
          clientId: "client_id",
          clientSecret: "client_secret",
          widgetBuilders: Map(),
          actionPerformers: performers);
      var mockState = MockRState();
      await Rokeet.init(config, mockState);
      expect(Rokeet().actionPerformerRegistry.get(RNavigateAction.TYPE),
          equals(expectPerformer));
    });

    test('should build widget', () async {
      var expectedBuilder = RVerticalContainerWidgetBuilder();
      var builders = Map<String, RWidgetBuilder>();
      builders[RVerticalContainerWidget.TYPE] = expectedBuilder;

      var config = RokeetConfig(
          clientId: "client_id",
          clientSecret: "client_secret",
          widgetBuilders: builders,
          actionPerformers: Map());
      var mockState = MockRState();

      var rokeet = await Rokeet.init(config, mockState);
      var widgetDefinition =
          RWidgetParser.parse(loadJson('rokeet.test/widget'))!;
      var widget = rokeet.buildWidget(widgetDefinition);
      expect(widget, isNotNull);
      expect(widget, isA<Column>());
    });

    test('should perform action', () async {
      var expectPerformer = MockRActionPerformer();
      var performers = Map<String, RActionPerformer>();
      performers[RNavigateAction.TYPE] = expectPerformer;

      var config = RokeetConfig(
          clientId: "client_id",
          clientSecret: "client_secret",
          widgetBuilders: Map(),
          actionPerformers: performers);
      var mockState = MockRState();
      var rokeet = await Rokeet.init(config, mockState);
      var action = RActionParser.parse(loadJson('rokeet.test/action'))!;
      rokeet.performAction(action);
      verify(expectPerformer.performAction(rokeet, action)).called(1);
    });
  });
}
