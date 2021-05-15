import 'dart:io';

class UserAgent {
  static String buildUserAgent() {
    return  '${_platform()}-${_version()}';
  }

  static String _platform() {
    try {
      if(Platform.isAndroid) {
        return 'Android';
      }
      if(Platform.isIOS) {
        return 'iOS';
      }
      return 'Unknown';
    } catch(e) {
      return 'Web';
    }
  }

  static String _version() {
    return Platform.version;
  }
}