import 'dart:convert';

import 'package:condosocio/src/services/senha/api_senha.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SenhaController extends GetxController {
  var email = TextEditingController().obs;

  final form = GlobalKey<FormState>();

  var isLoading = false.obs;

  senha() async {
    var response = await ApiSenha.senha();

    var dados = json.decode(response.body);

    return dados;
  }
}
