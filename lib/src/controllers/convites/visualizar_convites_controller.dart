import 'dart:convert';

import 'package:condosocio/src/services/convites/api_convites.dart';
import 'package:get/get.dart';

class VisualizarConvitesController extends GetxController {
  var convite = [];
  var titulo = ''.obs;
  var endDate = ''.obs;
  var qtdconv = 0.obs;

  var isLoading = false.obs;

  getAConvite(String id) async {
    isLoading(true);
    var response = await ApiConvites.getAConvites(id);
    var data = json.decode(response.body);

    convite = data;

    Get.toNamed('/detalhesConvite');

    isLoading(false);
  }
}
