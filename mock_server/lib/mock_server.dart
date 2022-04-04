import 'dart:convert';
import 'dart:io';

import 'package:mock_server/utils.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart' as shelf_router;

void server() async {
  final cascade = Cascade().add(_router);

  var server = await shelf_io.serve(
      logRequests().addHandler(cascade.handler), InternetAddress.anyIPv4, 3000);

  // Enable content compression
  server.autoCompress = true;

  print('Serving at http://${server.address.host}:${server.port}');
}

final _headers = {
  'content-type': 'application/json',
  'Cache-Control': 'public, max-age=604800',
};

final _router = shelf_router.Router()
  ..get('/apps', _appsHandler)
  ..get('/steps', _stepsHandler);

Response _appsHandler(Request request) =>
    Response.ok(const JsonEncoder.withIndent(' ').convert(loadJson("apps")),
        headers: _headers);

Response _stepsHandler(Request request) {
  var step = request.url.queryParameters["id"] as String;
  return Response.ok(const JsonEncoder.withIndent(' ').convert(loadJson(step)),
      headers: _headers);
}
