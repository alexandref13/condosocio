import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OcorrenciasController extends GetxController {
  var title = TextEditingController().obs;
  var date = TextEditingController().obs;
  var hour = TextEditingController().obs;
  var description = TextEditingController().obs;
  var isLoading = false.obs;

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
}
