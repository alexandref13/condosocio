import 'dart:convert';

import 'package:condosocio/src/controllers/acessos/acessos_controller.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:condosocio/src/services/acessos/api_acessos.dart';
import 'package:condosocio/src/services/convites/api_convites.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ConvitesController extends GetxController {
  AcessosController acessosController = Get.put(AcessosController());
  LoginController loginController = Get.put(LoginController());

  var inviteName = TextEditingController().obs;
  var carBoard = TextEditingController().obs;

  var startDate = ''.obs;
  var endDate = ''.obs;

  var page = 1.obs;

  var count = false.obs;
  var countApp = false.obs;
  var isDropdownSelected = false.obs;
  var guestList = [].obs;

  handleAddCount() {
    countApp(false);
    count(true);
  }

  handleAddCountApp() {
    count(false);
    countApp(true);
  }

  handleRemoveCount() {
    count(false);
  }

  handleRemoveCountApp() {
    countApp(false);
  }

  handleAddGuestList() {
    guestList.addAll({
      {
        'nome': acessosController.name.value.text,
        'tel': acessosController.phone.value.text,
        'tipo': acessosController.itemSelecionado.value,
      }
    });
    acessosController.name.value.text = '';
    acessosController.phone.value.text = '';
    count(false);
  }

  handleAddAppList() {
    guestList.addAll({
      {
        'nome': acessosController.name.value.text,
        'placa': carBoard.value.text,
        'tipo': 'App Mobilidade',
      }
    });
    acessosController.name.value.text = '';
    carBoard.value.text = '';
    countApp(false);
  }

  getAFavorite() async {
    acessosController.isLoading.value = true;
    final response = await ApiAcessos.getAFavorite();
    var dados = json.decode(response.body);
    acessosController.favorito = await dados.map((item) => item).toList();

    guestList.addAll({
      {
        'nome': acessosController.favorito[0]['pessoa'].toString(),
        'tel': acessosController.favorito[0]['cel'].toString(),
        'tipo': 'Convidado',
      }
    });

    acessosController.isLoading.value = false;
  }

  sendConvites(String startDate, String endDate) async {
    var response = await ApiConvites.sendAcesso(startDate, endDate);

    var data = json.decode(response.body);

    return data;
  }

  handleAddPage() {
    page.value = 2;
  }

  handleMinusPage() {
    page.value = 1;
  }

  @override
  void onInit() {
    inviteName.value.text = 'Convite de ${loginController.nome.value}';
    super.onInit();
  }
}
