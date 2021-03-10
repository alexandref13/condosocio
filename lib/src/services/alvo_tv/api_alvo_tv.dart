import 'package:http/http.dart' as http;

class ApiAlvoTv {
  static Future getVideos() async {
    return await http
        .get(Uri.https("www.condosocio.com.br", "/xdk/videosvisual.php"));
  }
}
