import 'dart:convert';
import 'package:condosocio/src/services/convites/api_convites.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
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

  var isEdited = false.obs;
  var isLoading = false.obs;
  var isBefore = false.obs;

  var platformStringVersion = 'Unknown'.obs;

  Future<void> launched;

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
    print(data);
    invite = data;

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
    var response = await ApiConvites.sendWhatsApp();
    var data = json.decode(response.body);
    isLoading(false);
    return data;
  }

  verificaWhatsApp() async {
    isLoading(true);
    var response = await ApiConvites.verificaWhatsApp();
    var data = json.decode(response.body);
    isLoading(false);

    return data;
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion = await FlutterOpenWhatsapp.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    platformStringVersion.value = platformVersion;
  }

  @override
  void onInit() {
    initPlatformState();
    super.onInit();
  }
}
