import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PerfilController extends GetxController {
  LoginController loginController = Get.put(LoginController());

  var name = TextEditingController().obs;
  var secondName = TextEditingController().obs;
  var gender = TextEditingController().obs;
  var birthdate = TextEditingController().obs;
  var phone = TextEditingController().obs;
  var fullName = '';

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
