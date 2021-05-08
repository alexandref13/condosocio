import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PerfilController extends GetxController {
  LoginController loginController = Get.put(LoginController());

  var name = TextEditingController().obs;
  var secondName = TextEditingController().obs;
  var gender = TextEditingController().obs;
  var birthdate = TextEditingController().obs;
  var phone = TextEditingController().obs;
  var fullName = '';

  var maskFormatter = new MaskTextInputFormatter(
    mask: '+55 (##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  init() {
    fullName = loginController.nome.value;

    var nome = fullName.split(' ');
    var sobrenome = nome[1];

    name.value.text = nome[0];
    secondName.value.text = sobrenome;
  }

  @override
  void onInit() {
    init();
    super.onInit();
  }
}
