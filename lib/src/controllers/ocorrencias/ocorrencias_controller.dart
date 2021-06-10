import 'package:condosocio/src/controllers/ocorrencias/visualizar_ocorrencias_controller.dart';
import 'package:condosocio/src/services/ocorrencias/api_ocorrencia.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OcorrenciasController extends GetxController {
  VisualizarOcorrenciasController visualizarOcorrenciasController =
      Get.put(VisualizarOcorrenciasController());

  var title = TextEditingController().obs;
  var date = TextEditingController().obs;
  var hour = TextEditingController().obs;
  var description = TextEditingController().obs;
  var isLoading = false.obs;

  DateTime data = DateTime.now();

  var tipos = [
    'Selecione o tipo de ocorrência',
    'Ocorrência',
    'Reclamação',
    'Solicitação',
    'Sugestão',
    'Elogio',
    'Outro'
  ];

  var itemSelecionado = 'Selecione o tipo de ocorrência'.obs;

  sendOcorrencia(String path) async {
    if (title.value.text == '' ||
        description.value.text == '' ||
        date.value.text == '' ||
        hour.value.text == '' || 
        itemSelecionado.value == 'Selecione o tipo de ocorrência') {
      return 'vazio';
    } else {
      isLoading(true);

      var response = await ApiOcorrencias.sendOcorrencia(path);

      title.value.text = '';
      description.value.text = '';
      itemSelecionado.value = 'Selecione o tipo de ocorrência';
      visualizarOcorrenciasController.getOcorrencias();

      init();

      isLoading(false);

      return response;
    }
  }

  init() {
    var newData = DateFormat('dd/MM/yyyy').format(data);
    var newHour = DateFormat('HH:mm').format(data);

    date.value.text = newData;
    hour.value.text = newHour;
  }

  @override
  void onInit() {
    init();
    super.onInit();
  }
}
