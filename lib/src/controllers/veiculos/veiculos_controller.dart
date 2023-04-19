import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../services/veiculos/api_veiculos.dart';
import '../../services/veiculos/mapa_veiculos.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class VeiculosController extends GetxController {
  var isLoading = false.obs;
  var marca = TextEditingController().obs;
  var modelo = TextEditingController().obs;
  var cor = TextEditingController().obs;
  var ano = TextEditingController().obs;
  var placa = TextEditingController().obs;
  var qtdVagas = TextEditingController().obs;
  var contagem = TextEditingController().obs;
  var idvei = ''.obs;
  var search = TextEditingController().obs;
  var searchResult = [].obs;
  var isChecked = true.obs;
  var veiculos = [].obs;
  var marcas = [].obs;
  var idmarca = '0'.obs;
  var firstId = '0'.obs;
  var isMarca = false.obs;
  var modelos = [].obs;
  var idmodelo = '0'.obs;
  var newDate = ''.obs;
  var qtdVag = 0.obs;
  var cont = 0.obs;

  var cores = [
    'SELECIONE A COR',
    'Amarela',
    'Azul',
    'Bege',
    'Branca',
    'Cinza',
    'Dourada',
    'Grena',
    'Laranja',
    'Marrom',
    'Prata',
    'Preta',
    'Rosa',
    'Roxa',
    'Verde',
    'Vermelha',
    'Fantasia',
    'Outra',
  ];
  var corSelecionada = 'SELECIONE A COR'.obs;

  var birthDateMaskFormatter = new MaskTextInputFormatter(
    mask: '####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  var placaMask = new MaskTextInputFormatter(
    mask: '#######',
    filter: {"#": RegExp(r'[0-9A-Za-z]')},
  );

  cleanController() {
    idmodelo.value = '0';
  }

  onSearchTextChanged(String text) {
    searchResult.clear();
    if (text.isEmpty) {
      return;
    }
    veiculos.forEach((details) {
      if (details.marca.toLowerCase().contains(text.toLowerCase()) ||
          details.modelo.toLowerCase().contains(text.toLowerCase()) ||
          details.placa.toLowerCase().contains(text.toLowerCase()))
        searchResult.add(details);
    });
  }

  Future<dynamic> sendVeiculos() async {
    if (marca.value.text == '' ||
        modelo.value.text == '' ||
        ano.value.text == '' ||
        cor.value.text == '' ||
        placa.value == '') {
      return "vazio";
    } else {
      isLoading(true);

      var response = await ApiVeiculos.sendVeiculos();

      var dados = json.decode(response.body);

      isLoading(false);

      return dados;
    }
  }

  getVeiculos() async {
    isLoading(true);

    var response = await ApiVeiculos.getVeiculos();
    var dados = json.decode(response.body);

    veiculos.value =
        dados.map((model) => VeiculosMapa.fromJson(model)).toList();
    isLoading(false);
    isLoading(false);
    return dados;
  }

  void getMarcas() async {
    isMarca(false);
    isLoading(true);
    cleanController();
    final response = await ApiVeiculos.getMar();
    var dados = json.decode(response.body);

    marcas.assignAll(dados);
    isLoading(false);
    isMarca(true);
    return dados;
  }

  void getModelos() async {
    isLoading(true);
    final response = await ApiVeiculos.getMod();
    var dados = json.decode(response.body);
    print('MODELOS: $dados');
    modelos.assignAll(dados);
    isLoading(false);

    return dados;
  }

  deleteVeiculo() async {
    var response = await ApiVeiculos.deleteVeiculo();
    var dados = json.decode(response.body);

    return dados;
  }

  @override
  void onInit() {
    getMarcas();

    super.onInit();
  }
}
