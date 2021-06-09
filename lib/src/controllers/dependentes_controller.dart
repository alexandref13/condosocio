import 'dart:convert';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:condosocio/src/services/dependentes/api_dependentes.dart';
import 'package:condosocio/src/services/dependentes/mapa_dependentes.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class DependentesController extends GetxController {
  LoginController loginController = Get.put(LoginController());
  var isLoading = false.obs;

  var nome = TextEditingController().obs;
  var sobrenome = TextEditingController().obs;
  var email = TextEditingController().obs;
  var celular = TextEditingController().obs;
  var idep = ''.obs;
  var status = ''.obs;

  var dependentes = [].obs;

  var search = TextEditingController().obs;
  var searchResult = [].obs;

  var firstId = '0'.obs;
  var tipos = [
    'Selecione o gênero',
    'Masculino',
    'Feminino',
  ];
  var itemSelecionado = 'Selecione o gênero'.obs;

  onSearchTextChanged(String text) {
    searchResult.clear();
    if (text.isEmpty) {
      return;
    }

    dependentes.forEach((details) {
      if (details.nome.toLowerCase().contains(text.toLowerCase()) ||
          details.sobrenome.toLowerCase().contains(text.toLowerCase()))
        searchResult.add(details);
    });
  }

  var cellMaskFormatter = new MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  Future<dynamic> sendDependentes() async {
    if (!EmailValidator.validate(email.value.text)) {
      return 'invalid';
    } else if (nome.value.text == '' ||
        sobrenome.value.text == '' ||
        email.value.text == '' ||
        celular.value.text == '' ||
        itemSelecionado.value == 'Selecione o gênero') {
      return "vazio";
    } else {
      isLoading(true);

      var response = await ApiDependentes.sendDependentes();

      var dados = json.decode(response.body);

      isLoading(false);

      return dados;
    }
  }

  getDependentes() async {
    isLoading(true);

    var response = await ApiDependentes.getDependentes();

    var dados = json.decode(response.body);

    dependentes.value =
        dados.map((model) => DependentesMapa.fromJson(model)).toList();

    isLoading(false);

    return dados;
  }

  changeStatus(String status) async {
    var response = await ApiDependentes.changeStatus(status);

    var dados = response.body;

    return dados;
  }

  deleteDependente() async {
    var response = await ApiDependentes.deleteDependente();

    var dados = json.decode(response.body);

    return dados;
  }

  @override
  void onInit() {
    getDependentes();
    super.onInit();
  }
}
