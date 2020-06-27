import 'package:http/http.dart' as http;

class Toggle {
  final String url;

  Toggle(this.url);

  Future<http.Response> toggleOnOff(bool value) {
    var onOff = value ? "On" : "Off";
    return http.post('$url/toggle$onOff').timeout(
          Duration(seconds: 5),
        );
  }

  Future<bool> getToggle() {
    return http.get('$url/toggle').timeout(Duration(seconds: 5)).then(
      (response) {
        return response.body == "true";
      },
    );
  }
}
