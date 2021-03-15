import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  void setTheme(ThemeData condo) async {
    final box = GetStorage();
    box.write('condo', condo);
  }
}
