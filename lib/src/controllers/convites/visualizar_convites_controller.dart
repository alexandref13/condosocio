import 'dart:convert';

import 'package:condosocio/src/services/convites/api_convites.dart';
import 'package:get/get.dart';

class VisualizarConvitesController extends GetxController {
  var invite = [];
  var convidados = [].obs;
  var titulo = ''.obs;
  var startDate = ''.obs;
  var endDate = ''.obs;
  var qtdconv = 0.obs;

  var isEdited = false.obs;
  var isLoading = false.obs;

  getAConvite(String id) async {
    isLoading(true);
    var response = await ApiConvites.getAConvites(id);
    var data = json.decode(response.body);

    invite = data;

    Get.toNamed('/detalhesConvite');

    isLoading(false);
  }
}
