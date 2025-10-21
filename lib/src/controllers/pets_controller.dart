import 'dart:convert';
import 'package:condosocio/src/services/pets/api_pets.dart';
import 'package:condosocio/src/services/pets/mapa_pets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PetsController extends GetxController {
  var isLoading = false.obs;
  var nome = TextEditingController().obs;
  //var status = ''.obs;
  var idpet = ''.obs;
  var pets = [].obs;
  var search = TextEditingController().obs;
  var searchResult = [].obs;
  var isChecked = true.obs;
  var startDate = ''.obs;
  var endDate = ''.obs;
//  var facial = ''.obs;
  var raca = TextEditingController().obs;
  var semRaca = false.obs;
  var birthdate = TextEditingController().obs;
  final RxBool noBirthdate = false.obs;

  var hourEnt = TextEditingController().obs;
  var hourSai = TextEditingController().obs;

  var birthDateMaskFormatter = new MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  var firstId = '0'.obs;

  var sex = [
    'Selecione o sexo',
    'Macho',
    'Fêmea',
  ];
  var sexo = 'Selecione o sexo'.obs;

  var tipo = [
    'Selecione o tipo',
    'Cachorro',
    'Gato',
    'Aquático',
    'Ave',
    'Réptil',
    'Outros',
  ];
  var tipos = 'Selecione o tipo'.obs;

  onSearchTextChanged(String text) {
    searchResult.clear();
    if (text.isEmpty) {
      return;
    }

    pets.forEach((details) {
      if (details.nome.toLowerCase().contains(text.toLowerCase()))
        searchResult.add(details);
    });
  }

  sendPets(String path) async {
    if (nome.value.text == '' ||
        raca.value.text == '' ||
        tipo == '' ||
        sexo.value == 'Selecione o sexo') {
      return "vazio";
    } else {
      isLoading(true);

      var response = await ApiPets.sendPets(path);

      nome.value.text = '';
      raca.value.text = '';
      tipos.value = 'Selecione o tipo';
      sexo.value = 'Selecione o sexo';

      isLoading(false);

      return response;
    }
  }

  getPets() async {
    isLoading(true);
    var response = await ApiPets.getPets();
    var dados = json.decode(response.body);
    pets.value = dados.map((model) => PetsMapa.fromJson(model)).toList();

    isLoading(false);
    return dados;
  }

  static Future<void> deletePets(String idpet, String idusu) async {
    try {
      final response = await ApiPets.deletePets(idpet, idusu);

      if (response.body.trim() == '1') {
        print('Pet excluído com sucesso.');
      } else {
        print('Erro ao excluir pet.');
      }
    } catch (e) {
      print('Erro na exclusão: $e');
    }
  }

  bool isValidForm() {
    // ajuste os campos que são realmente obrigatórios
    final nomeOk = nome.value.text.trim().isNotEmpty;
    final tipoOk = tipos.value.trim().isNotEmpty;
    final sexoOk = sexo.value.trim().isNotEmpty;

    // raca pode ser preenchida automaticamente se marcar "Sem raça definida"
    final racaOk = raca.value.text.trim().isNotEmpty;

    // birthdate pode ser opcional se marcar "sem data"
    final birthOk = noBirthdate.value || birthdate.value.text.trim().isNotEmpty;

    return nomeOk && tipoOk && sexoOk && racaOk && birthOk;
  }

  @override
  void onInit() {
    getPets();
    var birthdateValue = birthdate.value;
    if (birthdateValue.text.isNotEmpty) {
      var date = birthdate.value.text.replaceAll('-', '/').split('/');
      birthdate.value.text = '${date[2]}/${date[1]}/${date[0]}';
      print('DATA NIVER: $date');
    } else {
      // Tratar o caso em que a string de data está vazia
      print('A string de data está vazia.');
      birthdate.value.text = "00/00/0000";
    }
    super.onInit();
  }
}
