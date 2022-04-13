import 'dart:io' as IO;

import 'package:dio/dio.dart';
import 'package:rokeet/src/network/client/http_client.dart';

import '../model.dart';
import 'query_params.dart';
import 'user_agent.dart';

class RokeetApi {
  RokeetApi(this._client);

  final HttpClient _client;

  bool isLoading = false;

  Future<AppConfig> getApp(String clientId, String clientSecret) async {
    isLoading = true;
    var headers = await _getHeaders();
    var response = await _client.get("/apps",
        queryParams: {
          QueryParams.clientId: clientId,
          QueryParams.clientSecret: clientSecret
        },
        headers: headers);
    isLoading = false;
    return AppConfig.fromJson(response.data!);
  }

  Future<RStep> getStep(String stepId) async {
    isLoading = true;
    Response response =
        await _client.get('/steps', queryParams: {QueryParams.id: stepId});
    isLoading = false;
    return RStep.fromJson(response.data!);
  }

  Future<Map<String, dynamic>> _getHeaders() async {
    var userAgent = await UserAgent.buildUserAgent();
    return {IO.HttpHeaders.userAgentHeader: userAgent};
  }
}
