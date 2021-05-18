import 'dart:io';

import 'package:package_info/package_info.dart';

class UserAgent {

  static Future<String> buildUserAgent() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      return  'Rokeet_UI-${_platform()}-${packageInfo.version}-(${Platform.localeName})';
    } catch(ex) {
      return 'Rokeet_UI-${_platform()}-(${Platform.localeName})';
    }

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
}