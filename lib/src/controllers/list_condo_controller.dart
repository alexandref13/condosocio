import 'dart:async';

import 'package:get/get.dart';

class ListCondoController extends GetxController {
  var isLoading = true.obs;

  handleIsLoading() {
    Timer(Duration(seconds: 3), () {
      isLoading(false);
    });
  }

  @override
  void onInit() {
    handleIsLoading();
    super.onInit();
  }
}
