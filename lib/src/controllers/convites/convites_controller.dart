import 'dart:convert';
import 'package:condosocio/src/controllers/acessos/acessos_controller.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:condosocio/src/services/acessos/api_acessos.dart';
import 'package:condosocio/src/services/convites/api_convites.dart';
import 'package:condosocio/src/services/convites/mapa_convites.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

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
  var guestList = [].obs;

  var convites = <ConvitesMapa>[].obs;
  var search = TextEditingController().obs;
  var searchResult = <ConvitesMapa>[].obs;

  var isEdited = false.obs;
  var isLoading = false.obs;

  var maskFormatter = new MaskTextInputFormatter(
    mask: '+55 (##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  handleAddCount() {
    countApp(false);
    count.value = !count.value;
  }

  handleAddCountApp() {
    count(false);
    countApp.value = !countApp.value;
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
    print(dados);
    acessosController.favorito = await dados.map((item) => item).toList();

    guestList.addAll({
      {
        'idfav': acessosController.favorito[0]['idfav'].toString(),
        'nome': acessosController.favorito[0]['pessoa'].toString(),
        'tel': acessosController.favorito[0]['cel'].toString(),
        'tipo': 'Convidado',
      }
    });

    acessosController.isLoading.value = false;
  }

  sendConvites(String startDate, String endDate) async {
    isLoading(true);
    var response = await ApiConvites.sendAcesso(startDate, endDate);

    var data = json.decode(response.body);

    isLoading(false);

    return data;
  }

  getConvites() async {
    isLoading(true);

    var response = await ApiConvites.getConvites();

    Iterable lista = json.decode(response.body);
    convites
        .assignAll(lista.map((model) => ConvitesMapa.fromJson(model)).toList());

    isLoading(false);
  }

  onSearchTextChanged(String text) {
    searchResult.clear();
    if (text.isEmpty) {
      return;
    }

    convites.forEach((details) {
      if (details.titulo.toLowerCase().contains(text.toLowerCase()))
        searchResult.add(details);
    });
  }

  handleAddPage() {
    page.value = 2;
  }

  handleMinusPage() {
    page.value = 1;
  }

  editAInvite() async {
    isLoading(true);

    var response = await ApiConvites.deleleAGuest();
    var data = json.decode(response.body);

    isLoading(false);

    return data;
  }

  @override
  void onInit() {
    getConvites();
    super.onInit();
  }
}
