import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:rokeet_ui/src/network/network.dart';
import 'package:rokeet_ui/src/network/query_params.dart';

import '../utils.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  group("Rokeet Api", () {
    late DioAdapter dioAdapter;
    late RokeetApi api;
    setUp(() {
      dioAdapter = DioAdapter();
      api = RokeetApiBuilder("https://localhost")
          .clientAdapter(dioAdapter)
          .build();
    });

    test("get app should return status 200", () async {
      var clientId = "clientId";
      var clientSecret = "clientSecret";
      MethodChannel('plugins.flutter.io/package_info')
          .setMockMethodCallHandler((call) => Future.value());
      dioAdapter.onGet(
          "/apps",
          (request) => request.reply(
                200,
                loadJson("app/appconfig"),
              ),
          queryParameters: {
            QueryParams.clientId: clientId,
            QueryParams.clientSecret: clientSecret
          },
          headers: {
            HttpHeaders.userAgentHeader: "Rokeet_UI-Unknown-(en_US)"
          });
      var appConfig = await api.getApp(clientId, clientSecret);
      expect(appConfig, isNotNull);
      expect(appConfig.initStep, equals("login"));
    });

    test("get step should return status 200", () async {
      MethodChannel('plugins.flutter.io/package_info')
          .setMockMethodCallHandler((call) => Future.value());
      dioAdapter.onGet(
          "/steps",
              (request) => request.reply(
            200,
            loadJson("app/login_step"),
          ),
          queryParameters: {
            QueryParams.id: 'login'
          },
          headers: {
            HttpHeaders.userAgentHeader: "Rokeet_UI-Unknown-(en_US)"
          });
      var step = await api.getStep('login');
      expect(step, isNotNull);
      expect(step.body!.children!.length, equals(4));
    });
  });
}
