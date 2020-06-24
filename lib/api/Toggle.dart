import 'package:http/http.dart' as http;

String baseUrl = 'http://192.168.0.53:3000';

class Toggle {
  static Future<http.Response> toggleOnOff(bool value) {
    var onOff = value ? "On" : "Off";
    return http.post('$baseUrl/toggle$onOff').timeout(
          Duration(seconds: 5),
        );
  }
}
