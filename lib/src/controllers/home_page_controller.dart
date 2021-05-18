import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePageController extends GetxController {
  LoginController loginController = Get.put(LoginController());

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

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

  void onRefresh(context) async {
    loginController.newLogin(context, loginController.newId.value);
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    print('loading');
    refreshController.loadComplete();
  }
}
