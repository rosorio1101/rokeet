import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:rokeet/src/network/network.dart';
import 'package:rokeet/src/rokeet.dart';

void main() {
  group("Dio HttpClient", () {
    late HttpClient _httpClient;
    late DioAdapter _dioAdapter;
    late Rokeet _rokeet;
    setUp(() {
      _rokeet = Rokeet();
      _rokeet.baseUrl = "http://localhost";
      _dioAdapter = DioAdapter();
      _httpClient = RokeetHttpClient.builder(_rokeet)
          .withClientAdapter(_dioAdapter)
          .build();
    });

    test("GET should return a HTTP STATUS 200", () async {
      _dioAdapter.onGet("/", (request) => request.reply(200, ""));
      Response<dynamic> response = await _httpClient.get("/");
      expect(response.isSuccess, true);
      expect(response.statusCode, HttpStatus.ok);
    });

    test("GET should return a HTTP STATUS 400", () async {
      _dioAdapter.onGet("/", (request) => request.reply(400, ""));
      Response<dynamic> response = await _httpClient.get("/");
      expect(response.isSuccess, false);
      expect(response.statusCode, HttpStatus.badRequest);
    });

    test("POST should return a HTTP STATUS 200", () async {
      _dioAdapter.onPost("/", (request) => request.reply(200, ""));
      Response<dynamic> response = await _httpClient.post("/");
      expect(response.isSuccess, true);
      expect(response.statusCode, HttpStatus.ok);
    });
    test("POST should return a HTTP STATUS 400", () async {
      _dioAdapter.onPost("/", (request) => request.reply(400, ""));
      Response<dynamic> response = await _httpClient.post("/");
      expect(response.isSuccess, false);
      expect(response.statusCode, HttpStatus.badRequest);
    });

    test("PUT should return a HTTP STATUS 200", () async {
      _dioAdapter.onPut("/", (request) => request.reply(200, ""));
      Response<dynamic> response = await _httpClient.put("/");
      expect(response.isSuccess, true);
      expect(response.statusCode, HttpStatus.ok);
    });
    test("PUT should return a HTTP STATUS 400", () async {
      _dioAdapter.onPut("/", (request) => request.reply(400, ""));
      Response<dynamic> response = await _httpClient.put("/");
      expect(response.isSuccess, false);
      expect(response.statusCode, HttpStatus.badRequest);
    });

    test("PATCH should return a HTTP STATUS 200", () async {
      _dioAdapter.onPatch("/", (request) => request.reply(200, ""));
      Response<dynamic> response = await _httpClient.patch("/");
      expect(response.isSuccess, true);
      expect(response.statusCode, HttpStatus.ok);
    });
    test("PATCH should return a HTTP STATUS 400", () async {
      _dioAdapter.onPatch("/", (request) => request.reply(400, ""));
      Response<dynamic> response = await _httpClient.patch("/");
      expect(response.isSuccess, false);
      expect(response.statusCode, HttpStatus.badRequest);
    });

    test("DELETE should return a HTTP STATUS 200", () async {
      _dioAdapter.onDelete("/", (request) => request.reply(200, ""));
      Response<dynamic> response = await _httpClient.delete("/");
      expect(response.isSuccess, true);
      expect(response.statusCode, HttpStatus.ok);
    });
    test("DELETE should return a HTTP STATUS 400", () async {
      _dioAdapter.onDelete("/", (request) => request.reply(400, ""));
      Response<dynamic> response = await _httpClient.delete("/");
      expect(response.isSuccess, false);
      expect(response.statusCode, HttpStatus.badRequest);
    });
  });
}
