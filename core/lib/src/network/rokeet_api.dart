import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

import '../model.dart';
import 'query_params.dart';
import 'user_agent.dart';

class RokeetApi {
  RokeetApi(this._dio);

  final Dio _dio;

  bool isLoading = false;

  Future<AppConfig> getApp(String clientId, String clientSecret) async {
    isLoading = true;
    var headers = await _getHeaders();
    Response response = await _dio.get("/apps", queryParameters: {
      QueryParams.clientId: clientId,
      QueryParams.clientSecret: clientSecret
    }, options: Options(headers: headers));
    isLoading = false;
    return AppConfig.fromJson(response.data!);
  }

  Future<RStep> getStep(String stepId) async {
    isLoading = true;
    Response response =
        await _dio.get('/steps', queryParameters: {QueryParams.id: stepId});
    isLoading = false;
    return RStep.fromJson(response.data!);
  }

  Future<Map<String, dynamic>> _getHeaders() async {
    var userAgent = await UserAgent.buildUserAgent();
    return {
      HttpHeaders.userAgentHeader: userAgent
    };
  }
}

class RokeetApiBuilder {
  RokeetApiBuilder(String baseUrl)
      : _dio = Dio(BaseOptions(
          baseUrl: baseUrl,
        ));

  final Dio _dio;

  RokeetApiBuilder addInterceptor(Interceptor interceptor) {
    _dio.interceptors.add(interceptor);
    return this;
  }

  RokeetApiBuilder clientAdapter(HttpClientAdapter clientAdapter) {
    _dio.httpClientAdapter = clientAdapter;
    return this;
  }

  RokeetApi build() {
    if(_dio.httpClientAdapter is DefaultHttpClientAdapter) {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }
    return RokeetApi(_dio);
  }
}
