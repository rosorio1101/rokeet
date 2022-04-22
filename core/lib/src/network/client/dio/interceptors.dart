import 'dart:collection';

import 'package:dio/dio.dart' as Dio;
import 'package:rokeet/rokeet.dart';
import 'package:rokeet/src/network/user_agent.dart';
import 'package:rokeet/src/utils.dart';

typedef T RokeetInterceptorFactory<T extends RokeetInterceptor>(Rokeet rokeet);

class RokeetInterceptorsFactory extends ListMixin<RokeetInterceptorFactory> {
  final _list = <RokeetInterceptorFactory>[];

  @override
  RokeetInterceptorFactory operator [](int index) {
    return _list[index];
  }

  @override
  int length = 0;

  @override
  void operator []=(int index, RokeetInterceptorFactory value) {
    if (_list.length == index) {
      _list.add(value);
    } else {
      _list[index] = value;
    }
  }
}

abstract class RokeetInterceptor extends Dio.Interceptor {
  final Rokeet _rokeet;
  RokeetInterceptor(this._rokeet);
}

class BaseRokeetInterceptor extends RokeetInterceptor {
  static const clientIdHeader = "x-client-id";
  static const clientSecretHeader = "x-client-secret";
  static const userAgentHeader = "x-rokeet-user-agent";

  BaseRokeetInterceptor(Rokeet rokeet) : super(rokeet);

  static RokeetInterceptorFactory<BaseRokeetInterceptor> factory =
      (rokeet) => BaseRokeetInterceptor(rokeet);

  @override
  void onRequest(
      Dio.RequestOptions options, Dio.RequestInterceptorHandler handler) async {
    options.headers = await _buildRokeetHeaders();
    handler.next(options);
  }

  @override
  void onError(Dio.DioError err, Dio.ErrorInterceptorHandler handler) {
    handler.next(err);
  }

  @override
  void onResponse(
      Dio.Response response, Dio.ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  Future<Map<String, dynamic>> _buildRokeetHeaders() async {
    final config = _rokeet.config;
    final map = caseInsensitiveKeyMap<String>();
    map[clientIdHeader] = config.clientId ?? "";
    map[clientSecretHeader] = config.clientSecret ?? "";
    map[userAgentHeader] = await UserAgent.buildUserAgent();
    return map;
  }
}

class RokeetLogInterceptor extends Dio.LogInterceptor
    implements RokeetInterceptor {
  RokeetLogInterceptor(this._rokeet)
      : super(responseBody: true, requestBody: true);
  static RokeetInterceptorFactory<RokeetLogInterceptor> factory =
      (rokeet) => RokeetLogInterceptor(rokeet);

  @override
  final Rokeet _rokeet;
}
