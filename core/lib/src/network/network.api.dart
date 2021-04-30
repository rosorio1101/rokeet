import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import '../model.dart';
import 'network.code.dart';
import 'network.error.dart';

class RokeetApi {
  RokeetApi(this._baseUrl);

  String _baseUrl;
  bool isLoading = false;

  Future<RInit> initRokeet(Map<String, String> params) async {
    final String url = '$_baseUrl/apps';
    final String requestUrl = _buildUrl(url, params);

    return await _get(requestUrl, (json) => RInit.fromJson(json));
  }

  Future<RStep> getStep(String id, Map<String, String> params) async {
    params['id'] = id;
    final String url = '$_baseUrl/steps';
    final String requestUrl = _buildUrl(url, params);

    return await _get(requestUrl, (json) => RStep.fromJson(json));
  }

  String _buildUrl(String url, Map<String, String> params) {
    if (params.isNotEmpty) {
      final queryParams = params.entries
          .map((e) => '${e.key}=${e.value}')
          .reduce((value, element) => '$value&$element');
      return '$url?$queryParams';
    } else {
      return url;
    }
  }

  Future<T> _get<T>(String url, T parser(dynamic)) async {
    log("GET: $url");
    isLoading = true;
    try {
      final http.Response response = await http.get(Uri.parse(url));
      isLoading = false;
      switch (response.statusCode) {
        case HTTP_STATUS_CODE_OK:
          return Future.value(parser(jsonDecode(response.body)));
        case HTTP_STATUS_CODE_NOT_FOUND:
          return Future.error(NotFoundError(url));
        case HTTP_STATUS_CODE_BAD_REQUEST:
          return Future.error(BadRequestError(url));
        case HTTP_STATUS_CODE_SERVER_ERROR:
          return Future.error(ServerError(url));
        case HTTP_STATUS_CODE_UNAUTHORIZED:
          return Future.error(UnauthorizedError(url));
        default:
          return Future.error(NetworkError("Ah ocurrido un error", url));
      }
    } catch(error) {
      log(error.toString());
      return Future.error(NetworkError(error.toString(), url));
    }
  }
}
