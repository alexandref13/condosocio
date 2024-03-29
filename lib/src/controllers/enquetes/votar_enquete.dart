import 'dart:convert';
import 'package:condosocio/src/services/enquetes/api_enquetes.dart';
import 'package:condosocio/src/services/enquetes/mapa_votar_enquetes.dart';
import 'package:get/get.dart';

class VotarEnqueteController extends GetxController {
  var enquete = <MapaVotarEnquetes>[].obs;

  var index = 0.obs;
  var i = 0.obs;

  var isLoading = true.obs;
  var isChecked = false.obs;

  votacaoEnquete() async {
    isLoading(true);

    var response = await ApiEnquetes.votacaoEnquete();

    Iterable dados = json.decode(response.body);

    enquete.assignAll(
        dados.map((model) => MapaVotarEnquetes.fromJson(model)).toList());

    isLoading(false);
  }

  votarEnquete() async {
    isLoading(true);

    var response = await ApiEnquetes.votarEnquete();

    votacaoEnquete();

    Get.toNamed('/enquetes');

    var dados = json.decode(response.body);
      
    isLoading(false);

    return dados;
  }

  @override
  void onInit() {
    votacaoEnquete();
    super.onInit();
  }
}
