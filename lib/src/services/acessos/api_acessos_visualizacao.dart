import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ApiAcessosVisualizacao {
  static Future getAcessos() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String id = prefs.getString('idusu');
    print(id);
    return await http.get(
      Uri.https(
          "www.condosocio.com.br", "/flutter/acessovis.php", {"idUsu": "$id"}),
    );
  }
}
