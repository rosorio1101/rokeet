import 'dart:io' as IO;

import '../model.dart';
import 'network.dart';
import 'query_params.dart';
import 'user_agent.dart';

class RokeetApi {
  RokeetApi(this._client);

  final HttpClient _client;

  bool isLoading = false;

  Future<RStep> getStep(String stepId) async {
    isLoading = true;
    Response response =
        await _client.get('/steps', queryParams: {QueryParams.id: stepId});
    isLoading = false;
    return RStep.fromJson(response.body);
  }

  Future<Map<String, dynamic>> _getHeaders() async {
    var userAgent = await UserAgent.buildUserAgent();
    return {IO.HttpHeaders.userAgentHeader: userAgent};
  }
}
