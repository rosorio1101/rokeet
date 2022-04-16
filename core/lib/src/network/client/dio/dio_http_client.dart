import 'dart:io' as IO;

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:rokeet/src/network/client/http_client.dart';

class DioHttpClient extends HttpClient {
  static _DioHttpClientBuilder builder() => _DioHttpClientBuilder._();
  late Dio.Dio _dio;
  DioHttpClient._fromBuilder(_DioHttpClientBuilder builder) {
    _dio = Dio.Dio(Dio.BaseOptions(baseUrl: builder._baseUrl));
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
          queryParameters: queryParams, options: Dio.Options(headers: headers));
      return Response.from(response);
    } on Dio.DioError catch (e) {
      return Response.from(e.response!);
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
          options: Dio.Options(headers: headers));
      return Response.from(response);
    } on Dio.DioError catch (e) {
      return Response.from(e.response!);
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
          options: Dio.Options(headers: headers));
      return Response.from(response);
    } on Dio.DioError catch (e) {
      return Response.from(e.response!);
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
          options: Dio.Options(headers: headers));
      return Response.from(response);
    } on Dio.DioError catch (e) {
      return Response.from(e.response!);
    }
  }

  Future<Response> delete(String path,
      {Map<String, dynamic>? queryParams,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.delete(path,
          queryParameters: queryParams, options: Dio.Options(headers: headers));
      return Response.from(response);
    } on Dio.DioError catch (e) {
      return Response.from(e.response!);
    }
  }
}

class _DioHttpClientBuilder {
  _DioHttpClientBuilder._() {
    this._interceptors = Dio.Interceptors();
  }
  late String _baseUrl;
  Dio.HttpClientAdapter _adapter = DefaultHttpClientAdapter();

  late Dio.Interceptors _interceptors;

  _DioHttpClientBuilder withBaseUrl(String url) {
    this._baseUrl = url;
    return this;
  }

  _DioHttpClientBuilder addInterceptor(Dio.Interceptor interceptor) {
    this._interceptors.add(interceptor);
    return this;
  }

  _DioHttpClientBuilder withClientAdapter(Dio.HttpClientAdapter adapter) {
    this._adapter = adapter;
    return this;
  }

  DioHttpClient build() {
    return DioHttpClient._fromBuilder(this);
  }
}
