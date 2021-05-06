import 'dart:io';

import 'package:flutter/cupertino.dart';

class UserAgent {
  static String buildUserAgent(BuildContext  context) {
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