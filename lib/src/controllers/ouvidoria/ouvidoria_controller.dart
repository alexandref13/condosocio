import 'package:condosocio/src/services/ouvidoria/api_ouvidoria.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OuvidoriaController extends GetxController {
  var message = TextEditingController().obs;
  var isLoading = false.obs;
  var assuntos = [
    'Selecione',
    'Reclamação',
    'Solicitação',
    'Sugestão',
    'Elogio',
    'Boleto 2ª via',
    'Acordo para pagamento',
    'Alteração de titularidade',
    'Alteração de usuário',
    'Outro'
  ];
  var itemSelecionado = 'Selecione';

  void sendOuvidoria() async {
    isLoading(true);
    ApiOuvidoria.sendOuvidoria().then((value) {
      Get.toNamed('/visualizarOuvidoria');
    });
  }
}
