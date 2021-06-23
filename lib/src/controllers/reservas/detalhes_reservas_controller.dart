import 'dart:convert';

import 'package:condosocio/src/services/reservas/api_reservas.dart';
import 'package:get/get.dart';

class DetalhesReservasController extends GetxController {
  var idEve = ''.obs;
  var validaUsu = 0.obs;

  var nome = ''.obs;
  var unidade = ''.obs;
  var data = ''.obs;
  var titulo = ''.obs;
  var area = ''.obs;
  var status = ''.obs;
  var hora = ''.obs;
  var respevent = ''.obs;
  var idarea = ''.obs;

  var isLoading = false.obs;

  goToDetails(
    String newNome,
    String newUnidade,
    String newTitulo,
    String newData,
    String newArea,
    String newStatus,
    String newHora,
    String newResp,
  ) {
    nome(newNome);
    unidade(newUnidade);
    data(newData);
    titulo(newTitulo);
    area(newArea);
    status(newStatus);
    hora(newHora);
    respevent(newResp);

    Get.toNamed('/detalheReservas');
  }

  deleteReserva() async {
    isLoading(true);

    var response = await ApiReservas.deleteReserva();

    var dados = json.decode(response.body);

    isLoading(false);

    return dados;
  }
}
