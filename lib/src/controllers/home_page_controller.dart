import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

class HomePageController extends GetxController {
  late Future<void> launched;
  LoginController loginController = Get.put(LoginController());

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

  static Future<List<Map<String, String>>> getBannersHome() async {
    try {
      LoginController loginController = Get.put(LoginController());
      final response = await http.post(
        Uri.https('www.condosocio.com.br', '/flutter/banners_home_buscar.php'),
        body: {
          'idcond': loginController.idcond.value,
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List<dynamic>;

        final bannersHome = data.map((obj) {
          final imgUrl =
              "http://www.condosocio.com.br/images/bannereventos/${obj['imgbanner'] as String}";
          final url = obj['url'] as String;
          print('Image URL: $imgUrl');
          print('Link URL: $url');
          return {
            'imgUrl': imgUrl,
            'url': url,
          };
        }).toList();

        return bannersHome;
      } else {
        throw Exception('Failed to load banners');
      }
    } catch (e) {
      throw Exception('Failed to load banners: $e');
    }
  }
}
