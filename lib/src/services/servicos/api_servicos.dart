// import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class API_SERV {
  static Future getServicos() async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // final String idProf = prefs.getString('idusu');
    // var url = url_serv + idProf;
    return await http.get(Uri.https(
        "https://focuseg.com.br", "/flutter/servicos_json.php?idProf=180"));
  }
}
