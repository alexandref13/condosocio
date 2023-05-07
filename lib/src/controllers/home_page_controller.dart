import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

class HomePageController extends GetxController {
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

  static Future<List<String>> getBannersHome() async {
    LoginController loginController = Get.put(LoginController());
    final response = await http.post(
      Uri.https('www.alvocomtec.com.br', '/flutter/banners_home_buscar.php'),
      body: {
        'idcond': loginController.idcond.value,
      },
    );

    final data = jsonDecode(response.body) as List<dynamic>;

    final bannersHome = data
        .map((obj) =>
            "http://www.alvocomtec.com.br/images/bannereventos/${obj['imgbanner'] as String}")
        .toList();

    return bannersHome;
  }
}
