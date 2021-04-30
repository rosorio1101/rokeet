import 'dart:io';

var baseUrl = _getBaseUrl();

String _getBaseUrl() {
  if(Platform.isAndroid) {
    return "http://10.0.2.2:3000";
  } else {
    return "http://dev.rokeet.io:3000";
  }
}