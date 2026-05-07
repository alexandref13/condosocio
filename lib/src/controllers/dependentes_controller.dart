import 'dart:convert';
import 'package:condosocio/src/services/dependentes/api_dependentes.dart';
import 'package:condosocio/src/services/dependentes/mapa_dependentes.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class DependentesController extends GetxController {
  var isLoading = false.obs;
  var isSubmitting = false.obs;
  var nome = TextEditingController().obs;
  var sobrenome = TextEditingController().obs;
  var email = TextEditingController().obs;
  var celular = TextEditingController().obs;
  var idep = ''.obs;
  var status = ''.obs;
  var dependentes = [].obs;
  var search = TextEditingController().obs;
  var searchQuery = ''.obs;
  var searchResult = [].obs;
  var isChecked = true.obs;
  var startDate = ''.obs;
  var endDate = ''.obs;
  var facial = ''.obs;

  var hourEnt = TextEditingController().obs;
  var hourSai = TextEditingController().obs;

  var horaMaskFormatter = new MaskTextInputFormatter(
    mask: '##:##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  var firstId = '0'.obs;

  var tipos = [
    'Selecione o gênero',
    'Masculino',
    'Feminino',
  ];
  var itemSelecionado = 'Selecione o gênero'.obs;

  var tiposUsuarios = [
    'Morador',
    'Prestador de Serviço',
  ];

  var tiposUsuarios2 = [
    'Morador',
  ];
  var tipoUsuario = 'Morador'.obs;
  var tipoUsuario2 = 'Morador'.obs;

  String _normalizeSearchText(String value) {
    const accents = {
      'a': 'áàãâä',
      'e': 'éèêë',
      'i': 'íìîï',
      'o': 'óòõôö',
      'u': 'úùûü',
      'c': 'ç',
      'n': 'ñ',
    };

    var normalized = value.toLowerCase().trim();
    accents.forEach((plain, variants) {
      for (final char in variants.split('')) {
        normalized = normalized.replaceAll(char, plain);
      }
    });
    return normalized;
  }

  void onSearchTextChanged(String text) {
    searchQuery(text.trim());
    searchResult.clear();

    if (searchQuery.value.isEmpty) {
      return;
    }

    final query = _normalizeSearchText(searchQuery.value);
    searchResult.assignAll(
      dependentes.where((details) {
        final nome = _normalizeSearchText(details.nome.toString());
        final sobrenome = _normalizeSearchText(details.sobrenome.toString());
        final nomeCompleto = '$nome $sobrenome';
        final tipoUsuario =
            _normalizeSearchText(details.tipousuario.toString());

        return nome.contains(query) ||
            sobrenome.contains(query) ||
            nomeCompleto.contains(query) ||
            tipoUsuario.contains(query);
      }).toList(),
    );
  }

  var cellMaskFormatter = new MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  Future<dynamic> sendDependentes() async {
    if (nome.value.text == '' ||
        sobrenome.value.text == '' ||
        (email.value.text == '' && tipoUsuario == "Morador") ||
        celular.value.text == '' ||
        itemSelecionado.value == 'Selecione o gênero') {
      return "vazio";
    } else if (!EmailValidator.validate(email.value.text) &&
        tipoUsuario == "Morador") {
      return 'invalido';
    } else {
      isSubmitting(true);
      try {
        var response = await ApiDependentes.sendDependentes();
        var dados = json.decode(response.body);
        return dados;
      } finally {
        isSubmitting(false);
      }
    }
  }

  getDependentes() async {
    isLoading(true);
    try {
      var response = await ApiDependentes.getDependentes();
      var dados = json.decode(response.body);
      dependentes.value =
          dados.map((model) => DependentesMapa.fromJson(model)).toList();

      if (searchQuery.value.isNotEmpty) {
        onSearchTextChanged(searchQuery.value);
      }

      return dados;
    } catch (_) {
      dependentes.clear();
      searchResult.clear();
      return [];
    } finally {
      isLoading(false);
    }
  }

  changeStatus(String status) async {
    var response = await ApiDependentes.changeStatus(status);
    var dados = response.body;
    return dados;
  }

  reenviarEmail(String email) async {
    var response = await ApiDependentes.reenviarEmail(email);
    var dados = response.body;
    return dados;
  }

  ativarNotificacoes(String idep, String ctl) async {
    var response = await ApiDependentes.ativarNotificacoes(idep, ctl);
    var dados = response.body;
    return dados;
  }

  deleteDependente() async {
    var response = await ApiDependentes.deleteDependente();
    var dados = json.decode(response.body);
    return dados;
  }

  delFace() async {
    var response = await ApiDependentes.delFace();
    var dados = json.decode(response.body);
    return dados;
  }

  sendWhatsApp(String celular) async {
    var response = await ApiDependentes.sendWhatsApp(celular);
    var data = json.decode(response.body);
    return data;
  }

  @override
  void onInit() {
    getDependentes();
    super.onInit();
  }

  @override
  void onClose() {
    nome.value.dispose();
    sobrenome.value.dispose();
    email.value.dispose();
    celular.value.dispose();
    search.value.dispose();
    hourEnt.value.dispose();
    hourSai.value.dispose();
    super.onClose();
  }
}
