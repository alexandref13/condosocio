import 'package:get/get.dart';

class DetalhesReservasController extends GetxController {
  var nome = ''.obs;
  var unidade = ''.obs;
  var data = ''.obs;
  var titulo = ''.obs;
  var area = ''.obs;
  var status = ''.obs;
  var hora = ''.obs;
  var respevent = ''.obs;
  var idarea = ''.obs;

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
}
