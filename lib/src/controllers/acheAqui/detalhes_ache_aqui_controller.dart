import 'dart:convert';
import 'package:condosocio/src/controllers/acheAqui/ache_aqui_controller.dart';
import 'package:condosocio/src/services/acheaqui/api_ache_aqui.dart';
import 'package:condosocio/src/services/acheaqui/mapa_ache_aqui_avaliacao.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class DetalhesAcheAquiController extends GetxController {
  AcheAquiController acheAquiController = Get.put(AcheAquiController());

  var isLoading = false.obs;

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
    isLoading(true);
    var response = await ApiAcheAqui.getAcheAquiAvaliacao();

    Iterable dados = json.decode(response.body);

    avaliacao.assignAll(
        dados.map((model) => MapaAcheAquiAvaliacao.fromJson(model)).toList());

    isLoading(false);
  }

  sendAcheAquiAvaliacao() async {
    acheAquiController.isLoading(true);

    if (star1.value) {
      star.value = 1;
    }
    if (star2.value) {
      star.value = 2;
    }
    if (star3.value) {
      star.value = 3;
    }
    if (star4.value) {
      star.value = 4;
    }
    if (star5.value) {
      star.value = 5;
    }

    var response = await ApiAcheAqui.sendAcheAquiAvaliacao();

    getAcheAquiAvaliacao();

    var dados = json.decode(response.body);

    acheAquiController.isLoading(false);

    return dados;
  }

  @override
  void onInit() {
    getAcheAquiAvaliacao();
    super.onInit();
  }
}
