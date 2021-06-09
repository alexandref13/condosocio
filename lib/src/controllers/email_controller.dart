import 'dart:convert';
import 'package:condosocio/src/services/esqueci_email/api_email.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailController extends GetxController {
  var emailesqueci = TextEditingController().obs;
  final form = GlobalKey<FormState>();

  var isLoading = false.obs;

  email(context) async {
    isLoading(true);
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      currentFocus.focusedChild.unfocus();
    }
    var response = await ApiEmail.email();

    var dados = json.decode(response.body);

    isLoading(false);

    return dados;
  }
}
