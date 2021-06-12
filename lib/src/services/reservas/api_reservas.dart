import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:condosocio/src/controllers/reservas/add_reservas_controller.dart';
import 'package:condosocio/src/controllers/reservas/reservas_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiReservas {
  static Future getAreas() async {
    LoginController loginController = Get.put(LoginController());

    return await http.post(
      Uri.https("www.condosocio.com.br", "/flutter/areas_buscar.php"),
      body: {
        'idcond': loginController.idcond.value,
      },
    );
  }

  static Future agendaReservas() async {
    LoginController loginController = Get.put(LoginController());
    ReservasController reservasController = Get.put(ReservasController());

    print("idarea: ${reservasController.idarea.value}");

    return await http.post(
      Uri.https("www.condosocio.com.br", "/flutter/reservas_agenda.php"),
      body: {
        'idcond': loginController.idcond.value,
        'idusu': loginController.id.value,
        'nome_area': reservasController.nome.value,
        'idarea': reservasController.idarea.value,
      },
    );
  }

  static Future incluirReserva() async {
    LoginController loginController = Get.put(LoginController());
    ReservasController reservasController = Get.put(ReservasController());
    AddReservasController addReservasController =
        Get.put(AddReservasController());

    print({
      ' aprova: ${reservasController.aprova.value}',
      'hora: ${addReservasController.hora.value}',
      'data: ${addReservasController.date.value}'
    });

    return await http.post(
      Uri.https("www.condosocio.com.br", "/flutter/reservas_inc.php"),
      body: {
        'idcond': loginController.idcond.value,
        'idusu': loginController.id.value,
        'idarea': reservasController.idarea.value,
        'titulo': addReservasController.titulo.value.text,
        'data_evento': addReservasController.date.value,
        'hora_evento': addReservasController.hora.value,
        'aprova': reservasController.aprova.value,
      },
    );
  }
}
