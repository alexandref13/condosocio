import 'package:condosocio/src/services/ouvidoria/api_ouvidoria.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RespondaController extends GetxController {
  var controller = TextEditingController().obs;
  var isLoading = false.obs;

  sendRespondaOuvidoria() async {
    await ApiOuvidoria.sendRespondaOuvidoria()
        .then((value) => print(value.body));
  }
}
