import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PerfilController extends GetxController {
  var name = TextEditingController().obs;
  var secondName = TextEditingController().obs;
  var gender = TextEditingController().obs;
  var birthdate = TextEditingController().obs;
  var phone = TextEditingController().obs;
}
