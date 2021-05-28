import 'dart:convert';

import 'package:condosocio/src/services/acheaqui/api_ache_aqui.dart';
import 'package:condosocio/src/services/acheaqui/mapa_ache_aqui.dart';
import 'package:condosocio/src/services/acheaqui/mapa_ache_aqui_detalhes.dart';
import 'package:condosocio/src/services/acheaqui/mapa_ache_aqui_form.dart';
import 'package:get/get.dart';

class AcheAquiController extends GetxController {
  var isLoading = false.obs;
  var isSearch = false.obs;

  var tema = ''.obs;
  var id = ''.obs;

  var idForm = ''.obs;

  var empresa = ''.obs;
  var cel = ''.obs;
  var email = ''.obs;
  var site = ''.obs;
  var endereco = ''.obs;

  var acheAqui = <MapaAcheAqui>[].obs;
  var acheAquiForm = <MapaAcheAquiForm>[].obs;
  var acheAquiDetalhes = <MapaAcheAquiDetalhes>[].obs;

  getAcheAqui() async {
    isLoading(true);

    var response = await ApiAcheAqui.getAcheAqui();

    Get.toNamed('/listaAcheAqui');

    Iterable dados = json.decode(response.body);

    acheAqui
        .assignAll(dados.map((model) => MapaAcheAqui.fromJson(model)).toList());

    isLoading(false);
  }

  getAcheAquiForm() async {
    isLoading(true);

    var response = await ApiAcheAqui.getAcheAquiForm();

    Get.toNamed('/acheAquiForm');

    var lista = json.decode(response.body);

    print(lista);

    Iterable dados = json.decode(response.body);

    acheAquiForm.assignAll(
        dados.map((model) => MapaAcheAquiForm.fromJson(model)).toList());

    isLoading(false);
  }

  getAcheAquiDetalhes() async {
    isLoading(true);

    var response = await ApiAcheAqui.getAcheAquidetalhes();

    Get.toNamed('/detalhesAcheAqui');

    var lista = json.decode(response.body);

    print(lista);

    Iterable dados = json.decode(response.body);

    acheAquiDetalhes.assignAll(
        dados.map((model) => MapaAcheAquiDetalhes.fromJson(model)).toList());

    isLoading(false);
  }
}
