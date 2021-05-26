import 'dart:convert';

import 'package:condosocio/src/services/enquetes/api_enquetes.dart';
import 'package:get/get.dart';

class VotarEnqueteController extends GetxController {
  var enquete = [].obs;

  var index = 0.obs;

  var isLoading = true.obs;
  var isChecked = false.obs;

  votacaoEnquete() async {
    isLoading(true);

    var response = await ApiEnquetes.votacaoEnquete();

    print(json.decode(response.body));
    enquete.assignAll(json.decode(response.body));

    isLoading(false);
  }

  votarEnquete() async {
    isLoading(true);

    var response = await ApiEnquetes.votarEnquete();

    votacaoEnquete();

    Get.toNamed('/infoEnquete');

    isLoading(true);

    var dados = json.decode(response.body);

    print(dados);

    isLoading(false);
  }

  @override
  void onInit() {
    votacaoEnquete();
    super.onInit();
  }
}