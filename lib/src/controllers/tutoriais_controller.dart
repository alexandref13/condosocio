import 'dart:convert';
import 'package:condosocio/src/services/tutoriais/api_tutoriais.dart';
import 'package:condosocio/src/services/tutoriais/mapa_tutoriais.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

class TutoriaisController extends GetxController {
  List<MapaTutoriais> videos = [];
  var isLoading = true.obs;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void onRefresh() async {
    getVideosTutoriais();
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    refreshController.loadComplete();
  }

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

  getVideosTutoriais() async {
    isLoading(true);

    var response = await ApiTutoriais.getVideosTutoriais();

    Iterable lista = json.decode(response.body);

    videos = lista.map((model) => MapaTutoriais.fromJson(model)).toList();

    isLoading(false);
  }

  @override
  void onInit() {
    super.onInit();
    getVideosTutoriais();
  }
}
