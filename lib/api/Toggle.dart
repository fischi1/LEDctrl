import 'package:http/http.dart' as http;

String baseUrl = 'http://192.168.0.53:3000';

class Toggle {
  static void toggleOnOff(bool value) {
    var onOff = value ? "On" : "Off";
    http.post('$baseUrl/toggle$onOff');
  }
}
