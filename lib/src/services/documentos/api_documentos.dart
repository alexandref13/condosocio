import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiDocumentos {
  static Future getDocumentosAtas() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String id = prefs.getString('idusu');
    return await http.get(
      Uri.https("www.condosocio.com.br", "/flutter/documentos.php",
          {"idUsu": "$id", "pasta": "1"}),
    );
  }

  static Future getDocumentosContratos() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String id = prefs.getString('idusu');
    return await http.get(
      Uri.https("www.condosocio.com.br", "/flutter/documentos.php",
          {"idUsu": "$id", "pasta": "2"}),
    );
  }

  static Future getDocumentosConvencao() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String id = prefs.getString('idusu');
    return await http.get(
      Uri.https("www.condosocio.com.br", "/flutter/documentos.php",
          {"idUsu": "$id", "pasta": "3"}),
    );
  }

  static Future getDocumentosPrestacao() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String id = prefs.getString('idusu');
    return await http.get(Uri.https("www.condosocio.com.br",
        "/flutter/documentos.php", {"idUsu": "$id", "pasta": "4"}));
  }

  static Future getDocumentosRegulamento() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String id = prefs.getString('idusu');
    return await http.get(Uri.https("www.condosocio.com.br",
        "/flutter/documentos.php", {"idUsu": "$id", "pasta": "5"}));
  }

  static Future getDocumentosEdital() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String id = prefs.getString('idusu');
    return await http.get(Uri.https("www.condosocio.com.br",
        "/flutter/documentos.php", {"idUsu": "$id", "pasta": "6"}));
  }

  static Future getDocumentosOutros() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String id = prefs.getString('idusu');
    return await http.get(Uri.https("www.condosocio.com.br",
        "/flutter/documentos.php", {"idUsu": "$id", "pasta": "7"}));
  }
}
