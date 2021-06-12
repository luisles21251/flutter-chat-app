import 'dart:io';

class Enviroments {
  static String apiUrl = Platform.isAndroid ? 'http://10.0.2.2:3100/api' : 'http://localhost:3100/api';
  static String socketUrl = Platform.isAndroid ? 'http://10.0.2.2:3100' : 'http://localhost:3100';
}
