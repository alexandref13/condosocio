import 'dart:convert';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:condosocio/src/services/perfil/api_perfil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PerfilController extends GetxController {
  LoginController loginController = Get.put(LoginController());

  var isLoading = false.obs;

  var name = TextEditingController().obs;
  var secondName = TextEditingController().obs;
  var gender = TextEditingController().obs;
  var birthdate = TextEditingController().obs;
  var newDate = ''.obs;
  var phone = TextEditingController().obs;
  var tipo = TextEditingController().obs;
  var fullName = '';

  var firstId = '0'.obs;

  List<String> tipos = [
    'Selecione o gênero',
    'Masculino',
    'Feminino',
  ];

  var itemSelecionado = 'Selecione o gênero'.obs;

  var cellMaskFormatter = new MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  var birthDateMaskFormatter = new MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  var emailMaskFormatter = new MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  editPerfil() async {
    if (name.value.text == '' ||
        secondName.value.text == '' ||
        itemSelecionado.value == 'Selecione o gênero') {
      return 'vazio';
    } else {
      isLoading(true);

      loginController.phone.value = phone.value.text;
      loginController.birthdate.value = birthdate.value.text;
      loginController.nome.value = name.value.text;
      loginController.sobrenome.value = secondName.value.text;
      loginController.genero.value = itemSelecionado.value;

      /*phone.value.text = cellMaskFormatter.getUnmaskedText();
      var date = birthdate.value.text.split('/');*/

      var date = birthdate.value.text.split('/');
      newDate.value = '${date[2]}-${date[1]}-${date[0]}';

      var response = await ApiPerfil.editPerfil();
      var dados = json.decode(response.body);

      isLoading(false);

      loginController.birthdate.value = '${date[2]}/${date[1]}/${date[0]}';
      return dados;
    }
  }

  init() {
    name.value.text = loginController.nome.value;
    phone.value.text = loginController.phone.value;
    secondName.value.text = loginController.sobrenome.value;
    var date = loginController.birthdate.value.replaceAll('-', '/').split('/');
    birthdate.value.text = '${date[2]}/${date[1]}/${date[0]}';
    itemSelecionado.value = loginController.genero.value;
  }

  @override
  void onInit() {
    init();
    super.onInit();
  }
}
