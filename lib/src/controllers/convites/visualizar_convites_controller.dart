import 'dart:convert';
import 'package:condosocio/src/services/convites/api_convites.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class VisualizarConvitesController extends GetxController {
  var invite = [];
  var convidados = [].obs;
  var titulo = ''.obs;
  var startDate = ''.obs;
  var endDate = ''.obs;
  var idConv = ''.obs;
  var nameGuest = ''.obs;
  var tel = ''.obs;
  var whatsappNumber = TextEditingController().obs;
  var qtdconv = 0.obs;
  var acesso = ''.obs;
  var fav = false.obs;
  var isEdited = false.obs;
  var isLoading = false.obs;
  var isBefore = false.obs;
  var dia = ''.obs;
  var mes = ''.obs;

  var platformStringVersion = 'Unknown'.obs;

  late Future<void> launched;

  Future<void> launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  getAConvite(String id) async {
    isLoading(true);
    var response = await ApiConvites.getAConvites(id);
    var data = json.decode(response.body);
    invite = data;
    print('DADOS DO CONVITE: $invite');
    Get.toNamed('/detalhesConvite');

    isLoading(false);
  }

  deleteAConvite() async {
    isLoading(true);
    var response = await ApiConvites.deleleAConvite(idConv.value);
    var data = json.decode(response.body);
    isLoading(false);
    return data;
  }

  sendWhatsApp() async {
    isLoading(true);
    try {
      var response = await ApiConvites.sendWhatsApp();
      print('sendWhatsApp status: ${response.statusCode}');
      print('sendWhatsApp body: ${response.body}');
      final data = json.decode(response.body);
      print('sendWhatsApp decoded: $data');
      return data;
    } catch (e) {
      print('sendWhatsApp ERRO: $e');
      return null;
    } finally {
      isLoading(false);
    }
  }

  verificaWhatsApp() async {
    isLoading(true);
    try {
      var response = await ApiConvites.verificaWhatsApp();
      print('verificaWhatsApp status: ${response.statusCode}');
      print('verificaWhatsApp body: ${response.body}');
      final data = json.decode(response.body);
      print('verificaWhatsApp decoded: $data');
      return data;
    } catch (e) {
      print('verificaWhatsApp ERRO: $e');
      return {'numero': '', 'valido': false};
    } finally {
      isLoading(false);
    }
  }

  Future<void> initPlatformState() async {
    String? platformVersion;
    try {
      // platformVersion = await FlutterOpenWhatsapp.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    platformStringVersion.value = platformVersion!;
  }

  @override
  void onInit() {
    initPlatformState();
    super.onInit();
  }
}
