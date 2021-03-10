import 'dart:convert';

import 'package:condosocio/src/services/alvo_tv/api_alvo_tv.dart';
import 'package:condosocio/src/services/alvo_tv/mapa_alvo_tv.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class AlvoTvController extends GetxController {
  List<MapaAlvoTv> videos = [];
  var isLoading = true.obs;

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

  getVideos() {
    ApiAlvoTv.getVideos().then((response) {
      Iterable lista = json.decode(response.body);
      videos = lista.map((model) => MapaAlvoTv.fromJson(model)).toList();
      isLoading(false);
    });
  }

  @override
  void onInit() {
    super.onInit();
    getVideos();
  }
}
