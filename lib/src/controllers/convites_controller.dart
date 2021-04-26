import 'package:condosocio/src/controllers/acessos/acessos_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ConvitesController extends GetxController {
  AcessosController acessosController = Get.put(AcessosController());

  var date = DateTime.now().obs;
  var dataController = TextEditingController().obs;
  var inviteName = TextEditingController().obs;
  var count = 0.obs;
  var guestList = [].obs;
  var startSelectedDate = DateTime.now().obs;
  var startSelectedTime = TimeOfDay.now().obs;
  var endSelectedDate = DateTime.now().obs;
  var endSelectedTime = TimeOfDay.now().obs;
  final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  final DateFormat timeFormat = DateFormat('HH:mm');

  handleAddCount() {
    count.value++;
  }

  handleRemoveCount() {
    count.value--;
  }

  handleAddGuestList() {
    guestList.addAll({
      {
        'nome': acessosController.name.value.text,
        'tel': acessosController.phone.value.text,
        'tipo': acessosController.itemSelecionado.value,
      }
    });
    print(guestList);
    acessosController.name.value.text = '';
    acessosController.phone.value.text = '';
    count.value--;
  }

  Future<TimeOfDay> selectTime(BuildContext context) {
    final now = DateTime.now();

    return showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: now.hour, minute: now.minute),
    );
  }

  Future<DateTime> selectDateTime(BuildContext context) => showDatePicker(
        context: context,
        initialDate: DateTime.now().add(Duration(seconds: 1)),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100),
      );
}
