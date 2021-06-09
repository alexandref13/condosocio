import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiBoleto {
  static Future sendBoleto() async {
    return await http.post(
        Uri.https('www.condosocio.com.br', 'boletos_auth_super.php'),
        body: {''});
  }
}
