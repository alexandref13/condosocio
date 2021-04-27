import 'dart:convert';

import 'package:condosocio/src/controllers/acessos/acessos_controller.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:condosocio/src/services/acessos/api_acessos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ConvitesController extends GetxController {
  AcessosController acessosController = Get.put(AcessosController());
  LoginController loginController = Get.put(LoginController());

  var date = DateTime.now().obs;
  var dataController = TextEditingController().obs;
  var inviteName = TextEditingController().obs;

  var count = false.obs;
  var guestList = [].obs;

  final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  final DateFormat timeFormat = DateFormat('HH:mm');

  handleAddCount() {
    count(true);
  }

  handleRemoveCount() {
    count(false);
  }

  handleAddGuestList() {
    guestList.addAll({
      {
        'nome': acessosController.name.value.text,
        'tel': acessosController.phone.value.text,
        'tipo': acessosController.itemSelecionado.value,
      }
    });
    print(guestList);
    acessosController.name.value.text = '';
    acessosController.phone.value.text = '';
    count(false);
  }

  getAFavorite() async {
    acessosController.isLoading.value = true;
    final response = await ApiAcessos.getAFavorite();
    var dados = json.decode(response.body);
    acessosController.favorito = await dados.map((item) => item).toList();
    print(dados);

    guestList.addAll({
      {
        'nome': acessosController.favorito[0]['pessoa'].toString(),
        'tel': acessosController.favorito[0]['cel'].toString(),
        'tipo': 'Convidado',
      }
    });

    acessosController.isLoading.value = false;
  }

  @override
  void onInit() {
    inviteName.value.text = 'Convite de ${loginController.nome.value}';
    super.onInit();
  }
}
