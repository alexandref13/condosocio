import 'dart:convert';
import 'package:condosocio/src/controllers/acessos/acessos_controller.dart';
import 'package:condosocio/src/controllers/convites/visualizar_convites_controller.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:condosocio/src/services/acessos/api_acessos.dart';
import 'package:condosocio/src/services/convites/api_convites.dart';
import 'package:condosocio/src/services/convites/mapa_convites.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ConvitesController extends GetxController {
  AcessosController acessosController = Get.put(AcessosController());
  LoginController loginController = Get.put(LoginController());
  //VisualizarConvitesController visualizarConvitesController = Get.put(VisualizarConvitesController());

  VisualizarConvitesController get visualizarConvitesController =>
      Get.find<VisualizarConvitesController>();

  var inviteName = TextEditingController().obs;
  var carBoard = TextEditingController().obs;

  var startDate = ''.obs;
  var endDate = ''.obs;

  var page = 1.obs;
  var selectedTabIndex = 0.obs;

  var count = false.obs;
  var countApp = false.obs;
  var guestList = [].obs;

  var convites = <ConvitesMapa>[].obs;
  var search = TextEditingController().obs;
  var searchResult = <ConvitesMapa>[].obs;

  var isEdited = false.obs;
  var isLoading = false.obs;
  var hasLoadedConvites = false.obs;

  var isChecked = false.obs;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void onRefresh() async {
    getConvites();
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    refreshController.loadComplete();
  }

  var maskFormatter = new MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  var carFormatter = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  handleAddCount() {
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

  String _normalizePhone(String? phone) {
    return (phone ?? '').replaceAll(RegExp(r'[^0-9]'), '');
  }

  bool hasGuestWithPhone(String? phone) {
    final normalizedPhone = _normalizePhone(phone);
    if (normalizedPhone.isEmpty) {
      return false;
    }

    return guestList.any((guest) {
      if (guest is! Map) {
        return false;
      }

      final guestPhone = _normalizePhone(guest['tel']?.toString());
      return guestPhone.isNotEmpty && guestPhone == normalizedPhone;
    });
  }

  String handleAddGuestList() {
    final phone = acessosController.phone.value.text;
    if (hasGuestWithPhone(phone)) {
      return 'duplicate_phone';
    }

    final guest = <String, dynamic>{
      'nome': acessosController.name.value.text,
      'tipo': acessosController.itemSelecionado.value,
    };

    if (phone.isNotEmpty) {
      guest['tel'] = phone;
    }

    guestList.add(guest);
    acessosController.name.value.text = '';
    acessosController.phone.value.text = '';
    count(false);
    return 'success';
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

  Future<String> getAFavorite() async {
    acessosController.isLoading.value = true;
    final response = await ApiAcessos.getAFavorite();
    var dados = json.decode(response.body);
    print(dados);
    acessosController.favorito = await dados.map((item) => item).toList();

    final favoritePhone = acessosController.favorito[0]['cel'].toString();
    if (hasGuestWithPhone(favoritePhone)) {
      acessosController.isLoading.value = false;
      return 'duplicate_phone';
    }

    guestList.add({
      'idfav': acessosController.favorito[0]['idfav'].toString(),
      'nome': acessosController.favorito[0]['pessoa'].toString(),
      'tel': favoritePhone,
      'tipo': 'Convidado',
    });

    acessosController.isLoading.value = false;
    return 'success';
  }

  String addContactGuest(String name, String phone) {
    if (hasGuestWithPhone(phone)) {
      return 'duplicate_phone';
    }

    guestList.add({
      'nome': name,
      'tel': phone,
      'tipo': 'Convidado',
    });

    return 'success';
  }

  sendConvites(String startDate, String endDate, bool acesso) async {
    print('acesso: $acesso');
    isLoading(true);

    var response = await ApiConvites.sendAcesso(startDate, endDate, acesso);

    var data = json.decode(response.body);

    isLoading(false);

    return data;
  }

  getConvites() async {
    visualizarConvitesController.isLoading(true);
    isLoading(true);
    try {
      var response = await ApiConvites.getConvites();
      Iterable lista = json.decode(response.body);
      convites.assignAll(
          lista.map((model) => ConvitesMapa.fromJson(model)).toList());
    } catch (_) {
    } finally {
      hasLoadedConvites(true);
      isLoading(false);
      visualizarConvitesController.isLoading(false);
    }
  }

  getBannerTelaInicial() async {
    isLoading(true);
    var response = await ApiConvites.getBannerTelaInicial();
    var data = json.decode(response.body);
    isLoading(false);
    return data;
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
    selectedTabIndex.value = 0;
  }

  handleMinusPage() {
    page.value = 1;
    selectedTabIndex.value = 0;
  }

  openVisualizarTab() {
    page.value = 1;
    selectedTabIndex.value = 1;
    getConvites();
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
    ever(loginController.idcond, (_) => getConvites());
    super.onInit();
  }
}
