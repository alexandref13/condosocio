import 'dart:convert';

import 'package:condosocio/src/services/acheaqui/api_ache_aqui.dart';
import 'package:condosocio/src/services/acheaqui/mapa_ache_aqui_avaliacao.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class DetalhesAcheAquiController extends GetxController {
  var comentario = TextEditingController().obs;

  var star1 = false.obs;
  var star2 = false.obs;
  var star3 = false.obs;
  var star4 = false.obs;
  var star5 = false.obs;

  var star = 0.obs;

  var avaliacao = <MapaAcheAquiAvaliacao>[].obs;

  Future<void> launched;

  Future<void> sendEmail(String email) async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: email,
    );

    String url = params.toString();
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

  getAcheAquiAvaliacao() async {
    var response = await ApiAcheAqui.getAcheAquiAvaliacao();

    Iterable dados = json.decode(response.body);

    avaliacao.assignAll(
        dados.map((model) => MapaAcheAquiAvaliacao.fromJson(model)).toList());
  }

  @override
  void onInit() {
    getAcheAquiAvaliacao();
    super.onInit();
  }
}
