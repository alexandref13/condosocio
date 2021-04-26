import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConvitesController extends GetxController {
  var date = DateTime.now().obs;
  var dataController = TextEditingController().obs;
  var inviteName = TextEditingController().obs;
  var count = 0.obs;

  handleCount() {
    count.value++;
  }
}
