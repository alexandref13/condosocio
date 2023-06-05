import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../controllers/veiculos/veiculos_controller.dart';

class ApiVeiculos {
  static Future<dynamic> sendVeiculos() async {
    LoginController loginController = Get.put(LoginController());
    VeiculosController veiculosController = Get.put(VeiculosController());

    return await http.post(
      Uri.https("www.alvocomtec.com.br", "/flutter/veiculos_incluir.php"),
      body: {
        'idusu': loginController.id.value,
        'idmarca': veiculosController.idmarca.value,
        'idmodelo': veiculosController.idmodelo.value,
        'cor': veiculosController.corSelecionada.value,
        'ano': veiculosController.ano.value.text,
        'placa': veiculosController.placa.value.text,
      },
    );
  }

  static Future getVeiculos() async {
    LoginController loginController = Get.put(LoginController());

    return await http.post(
      Uri.https('www.alvocomtec.com.br', '/flutter/veiculos_buscar.php'),
      body: {
        'idusu': loginController.id.value,
      },
    );
  }

  static Future getMar() async {
    return await http.get(
      Uri.https(
        'www.alvocomtec.com.br',
        '/flutter/marcas_buscar.php',
      ),
    );
  }

  static Future getMod() async {
    VeiculosController veiculosController = Get.put(VeiculosController());
    print('IDMARCA = ${veiculosController.idmarca.value}');
    return await http.get(
      Uri.https('www.alvocomtec.com.br', '/flutter/modelos_buscar.php',
          {'idmarca': veiculosController.idmarca.value}),
    );
  }

  static Future deleteVeiculo() async {
    VeiculosController veiculosController = Get.put(VeiculosController());
    LoginController loginController = Get.put(LoginController());

    print('${veiculosController.idvei.value}');
    return await http.get(
      Uri.https('www.alvocomtec.com.br', '/flutter/veiculo_excluir.php', {
        'idvei': veiculosController.idvei.value,
        'idusu': loginController.id.value,
      }),
    );
  }
}
