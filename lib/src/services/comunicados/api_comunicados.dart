import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class API_COMUN {
  static Future getComunicados() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String id = prefs.getString('idusu');
    return await http.get(Uri.https(
        "www.condosocio.com.br", "/flutter/comunicados.php", {"idUsu": "$id"}));
  }
}
