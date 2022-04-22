import 'dart:io' as IO;

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:rokeet/src/network/client/dio/interceptors.dart';
import 'package:rokeet/src/network/client/http_client.dart';

import '../../../../rokeet.dart';

class RokeetHttpClient extends HttpClient {
  static _RokeetHttpClientBuilder builder(Rokeet rokeet) =>
      _RokeetHttpClientBuilder._(rokeet);
  late Dio.Dio _dio;

  RokeetHttpClient._fromBuilder(_RokeetHttpClientBuilder builder) {
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
    final interceptos =
        builder._interceptors.map((element) => element(builder.rokeet));
    _dio.interceptors.addAll(interceptos);
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

class _RokeetHttpClientBuilder extends HttpClientBuilder {
  _RokeetHttpClientBuilder._(Rokeet rokeet) : super(rokeet) {
    this._interceptors = RokeetInterceptorsFactory();
    this._baseUrl = rokeet.baseUrl;
  }

  late String _baseUrl;
  Dio.HttpClientAdapter _adapter = DefaultHttpClientAdapter();

  late RokeetInterceptorsFactory _interceptors;

  _RokeetHttpClientBuilder addInterceptorFactory(
      RokeetInterceptorFactory factory) {
    this._interceptors.add(factory);
    return this;
  }

  _RokeetHttpClientBuilder withClientAdapter(Dio.HttpClientAdapter adapter) {
    this._adapter = adapter;
    return this;
  }

  RokeetHttpClient build() {
    return RokeetHttpClient._fromBuilder(this);
  }
}
