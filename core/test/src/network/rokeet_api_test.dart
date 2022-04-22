import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:rokeet/rokeet.dart';
import 'package:rokeet/src/network/query_params.dart';

import '../utils.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  group("Rokeet Api", () {
    late DioAdapter dioAdapter;
    late HttpClient httpClient;
    late RokeetApi api;
    late Rokeet _rokeet;
    setUp(() {
      _rokeet = Rokeet();
      _rokeet.baseUrl = "http://localhost";
      dioAdapter = DioAdapter();
      httpClient = RokeetHttpClient.builder(_rokeet)
          .withClientAdapter(dioAdapter)
          .build();
      api = RokeetApi(httpClient);
      RWidgetParser.parsers[RLabelWidget.TYPE] =
          (json) => RLabelWidget.jsonParser(json);
      RWidgetParser.parsers[RButtonWidget.TYPE] =
          (json) => RButtonWidget.jsonParser(json);
      RWidgetParser.parsers[RVerticalContainerWidget.TYPE] =
          RVerticalContainerWidget.jsonParser;
    });

    test("get step should return status 200", () async {
      dioAdapter.onGet(
          "/steps",
          (request) => request.reply(
                200,
                loadJson("app/login_step"),
              ),
          queryParameters: {QueryParams.id: 'login'},
          headers: {HttpHeaders.userAgentHeader: "rokeet-Unknown-(en_US)"});
      var step = await api.getStep('login');
      expect(step, isNotNull);
      expect(step.body!.children!.length, equals(4));
    });
  });
}
