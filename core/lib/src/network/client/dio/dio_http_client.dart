import 'dart:io' as IO;

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:rokeet/src/network/client/http_client.dart';

class DioHttpClient extends HttpClient<Response<dynamic>> {
  static _DioHttpClientBuilder builder() => _DioHttpClientBuilder._();
  late Dio _dio;
  DioHttpClient._fromBuilder(_DioHttpClientBuilder builder) {
    _dio = Dio(BaseOptions(baseUrl: builder._baseUrl));
    _dio.httpClientAdapter = builder._adapter;
    if (_dio.httpClientAdapter is DefaultHttpClientAdapter) {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (IO.HttpClient client) {
        client.badCertificateCallback =
            (IO.X509Certificate cert, String host, int port) => true;
        return client;
      };
    }
    _dio.interceptors.addAll(builder._interceptors);
  }

  Future<Response> get(String path,
      {Map<String, dynamic>? queryParams,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.get(path,
          queryParameters: queryParams, options: Options(headers: headers));
      return response;
    } on DioError catch (e) {
      return e.response!;
    }
  }

  Future<Response> post(String path,
      {dynamic body,
      Map<String, dynamic>? queryParams,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.post(path,
          data: body,
          queryParameters: queryParams,
          options: Options(headers: headers));
      return response;
    } on DioError catch (e) {
      return e.response!;
    }
  }

  Future<Response> put(String path,
      {dynamic body,
      Map<String, dynamic>? queryParams,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.put(path,
          data: body,
          queryParameters: queryParams,
          options: Options(headers: headers));
      return response;
    } on DioError catch (e) {
      return e.response!;
    }
  }

  Future<Response> patch(String path,
      {dynamic body,
      Map<String, dynamic>? queryParams,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.patch(path,
          data: body,
          queryParameters: queryParams,
          options: Options(headers: headers));
      return response;
    } on DioError catch (e) {
      return e.response!;
    }
  }

  Future<Response> delete(String path,
      {Map<String, dynamic>? queryParams,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.delete(path,
          queryParameters: queryParams, options: Options(headers: headers));
      return response;
    } on DioError catch (e) {
      return e.response!;
    }
  }
}

class _DioHttpClientBuilder {
  _DioHttpClientBuilder._();
  late String _baseUrl;
  HttpClientAdapter _adapter = DefaultHttpClientAdapter();

  Interceptors get _interceptors => Interceptors();

  _DioHttpClientBuilder withBaseUrl(String url) {
    this._baseUrl = url;
    return this;
  }

  _DioHttpClientBuilder addInterceptor(Interceptor interceptor) {
    this._interceptors.add(interceptor);
    return this;
  }

  _DioHttpClientBuilder withClientAdapter(HttpClientAdapter adapter) {
    this._adapter = adapter;
    return this;
  }

  DioHttpClient build() {
    return DioHttpClient._fromBuilder(this);
  }
}
