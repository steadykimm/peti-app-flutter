import 'dart:io' show Platform;

class NetworkUtils {
  static const int _port = 5500;
  static const String _androidHost = 'http://10.0.2.2';
  static const String _iosHost = 'http://localhost';

  static String getHost() {
    return Platform.isIOS ? '$_iosHost:$_port' : '$_androidHost:$_port';
  }
}
