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

  var date = DateTime.now().obs;
  var dataController = TextEditingController().obs;
  var inviteName = TextEditingController().obs;
  var carBoard = TextEditingController().obs;

  var count = false.obs;
  var countApp = false.obs;
  var guestList = [].obs;

  final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  final DateFormat timeFormat = DateFormat('HH:mm');

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

  @override
  void onInit() {
    inviteName.value.text = 'Convite de ${loginController.nome.value}';
    super.onInit();
  }
}
