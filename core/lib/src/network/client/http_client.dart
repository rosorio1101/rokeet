import 'dart:io';

import 'package:dio/dio.dart' as Dio;

import '../../../rokeet.dart';

abstract class HttpClient {
  Future<Response<T>> get<T>(String path,
      {Map<String, dynamic>? queryParams, Map<String, dynamic>? headers});

  Future<Response<T>> post<T>(String path,
      {dynamic body,
      Map<String, dynamic>? queryParams,
      Map<String, dynamic>? headers});

  Future<Response<T>> put<T>(String path,
      {dynamic body,
      Map<String, dynamic>? queryParams,
      Map<String, dynamic>? headers});

  Future<Response<T>> patch<T>(String path,
      {dynamic body,
      Map<String, dynamic>? queryParams,
      Map<String, dynamic>? headers});

  Future<Response<T>> delete<T>(String path,
      {Map<String, dynamic>? queryParams, Map<String, dynamic>? headers});
}

typedef HttpClientBuilder HttpClientBuilderProvider(Rokeet rokeet);

abstract class HttpClientBuilder {
  HttpClientBuilder(this.rokeet);
  final Rokeet rokeet;

  HttpClient build();
}

class Response<T> extends Dio.Response<T> {
  Response._({required Dio.RequestOptions requestOptions})
      : super(requestOptions: requestOptions);

  Response.from(Dio.Response from)
      : super(
            data: from.data,
            headers: from.headers,
            requestOptions: from.requestOptions,
            isRedirect: from.isRedirect,
            statusCode: from.statusCode,
            statusMessage: from.statusMessage,
            redirects: from.redirects,
            extra: from.extra);
}

extension ResponseExt<T> on Response<T> {
  bool get isSuccess {
    if (statusCode == null) return false;
    if (statusCode! >= HttpStatus.ok && statusCode! < HttpStatus.badRequest)
      return true;
    return false;
  }

  T? get body => data;
}
