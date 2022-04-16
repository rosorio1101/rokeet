import 'package:dio/dio.dart';
import 'package:rokeet/rokeet.dart';
import 'package:rokeet/src/network/user_agent.dart';
import 'package:rokeet/src/utils.dart';

class RokeetInterceptor extends Interceptor {
  static const clientIdHeader = "x-client-id";
  static const clientSecretHeader = "x-client-secret";
  static const userAgentHeader = "x-rokeet-user-agent";
  late RokeetConfig _config;

  RokeetInterceptor(this._config);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers = await _buildRokeetHeaders();
    handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  Future<Map<String, dynamic>> _buildRokeetHeaders() async {
    final map = caseInsensitiveKeyMap<String>();
    map[clientIdHeader] = _config.clientId ?? "";
    map[clientSecretHeader] = _config.clientSecret ?? "";
    map[userAgentHeader] = await UserAgent.buildUserAgent();
    return map;
  }
}
