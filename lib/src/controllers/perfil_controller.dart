import 'dart:convert';

import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:condosocio/src/services/perfil/api_perfil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PerfilController extends GetxController {
  LoginController loginController = Get.put(LoginController());

  var isLoading = false.obs;

  var name = TextEditingController().obs;
  var secondName = TextEditingController().obs;
  var gender = TextEditingController().obs;
  var birthdate = TextEditingController().obs;
  var newDate = ''.obs;
  var phone = TextEditingController().obs;
  var fullName = '';

  var cellMaskFormatter = new MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  var birthDateMaskFormatter = new MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  editPerfil() async {
    if (name.value.text == '' || secondName.value.text == '') {
      return 'vazio';
    } else {
      isLoading(true);

      phone.value.text = cellMaskFormatter.getUnmaskedText();

      loginController.phone.value = phone.value.text;
      loginController.birthdate.value = birthdate.value.text;
      loginController.nome.value =
          '${name.value.text} ${secondName.value.text}';

      var date = birthdate.value.text.split('/');
      newDate.value = '${date[2]}-${date[1]}-${date[0]}';

      var response = await ApiPerfil.editPerfil();

      var dados = json.decode(response.body);

      isLoading(false);

      return dados;
    }
  }

  init() {
    fullName = loginController.nome.value;

    var nome = fullName.split(' ');

    for (var i = 1; i < nome.length; i++) {
      secondName.value.text = secondName.value.text + nome[i] + ' ';
    }

    name.value.text = nome[0];
    phone.value.text = loginController.phone.value;

    var date = loginController.birthdate.value.replaceAll('-', '/').split('/');

    birthdate.value.text = '${date[2]}/${date[1]}/${date[0]}';
  }

  @override
  void onInit() {
    init();
    super.onInit();
  }
}
