import 'dart:io';

var baseUrl = _getBaseUrl();

enum Environment { PRODUCTION, DEBUG }

String _getBaseUrl({Environment env = Environment.PRODUCTION}) {
  switch (env) {
    case Environment.PRODUCTION:
      return _getProductionUrl();
    default:
      return _getDebugUrl();
  }
}

String _getProductionUrl() {
  try {
    if (Platform.isAndroid) {
      return 'https://10.0.2.2:3000';
    }
    if (Platform.isIOS) {
      return 'http://localhost:3000';
    } else {
      return 'https://dev.rokeet.io:3000';
    }
  } catch (e) {
    return 'https://dev.rokeet.io:3000';
  }
}

String _getDebugUrl() {
  try {
    if (Platform.isAndroid) {
      return 'https://10.0.2.2:3000';
    }
    if (Platform.isIOS) {
      return 'http://localhost:3000';
    } else {
      return 'https://dev.rokeet.io:3000';
    }
  } catch (e) {
    return 'https://dev.rokeet.io:3000';
  }
}