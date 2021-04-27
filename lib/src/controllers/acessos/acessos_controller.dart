import 'dart:convert';
import 'package:condosocio/src/services/acessos/api_acessos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AcessosController extends GetxController {
  var name = TextEditingController().obs;
  var phone = TextEditingController().obs;
  var tel = ''.obs;
  var favoriteName = ''.obs;
  var favoritePhone = ''.obs;
  var idAce = ''.obs;
  var idfav = ''.obs;
  var isLoading = true.obs;
  var fav = [].obs;
  var favorito;
  var firstId = '0'.obs;

  var tipos = [
    'Selecione o tipo de visitante',
    'Convidado',
    'Prestador',
    'App Mobilidade',
  ];
  var itemSelecionado = 'Selecione o tipo de visitante'.obs;

  cleanController() {
    name.value.text = '';
    phone.value.text = '';
  }

  sendAcessos() async {
    isLoading(true);

    if (name.value.text == '' ||
        phone.value.text == '' ||
        itemSelecionado.value == 'Selecione o tipo de visitante') {
      return 'vazio';
    } else {
      tel(phone.value.text);
      final response = await ApiAcessos.sendAcesso();
      var dados = json.decode(response.body);
      itemSelecionado.value = 'Selecione o tipo de visitante';
      if (dados == 0) {
        return 0;
      } else {
        return 1;
      }
    }
  }

  deleteAcesso() async {
    final response = await ApiAcessos.deleteAcesso();
    var dados = json.decode(response.body);
    return dados;
  }

  sendFavorite() async {
    final response = await ApiAcessos.addFav();

    var dados = json.decode(response.body);
    idfav('');
    return dados;
  }

  void getFavoritos() async {
    isLoading(true);
    final response = await ApiAcessos.getFav();
    var dados = json.decode(response.body);
    fav.assignAll(dados);
    isLoading(false);
    return dados;
  }

  deleteFav() async {
    isLoading(true);
    final response = await ApiAcessos.deleteFav();
    var dados = json.decode(response.body);
    isLoading(false);
    return dados;
  }

  @override
  void onInit() {
    getFavoritos();
    super.onInit();
  }
}
