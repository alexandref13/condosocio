import 'package:contacts_service/contacts_service.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import 'acessos_controller.dart';

class AgendaContatosController extends GetxController {
  AcessosController acessosController = Get.put(AcessosController());
  Contact contacts;
  var phone;

  Future<void> pickContact() async {
    try {
      final Contact contact = await ContactsService.openDeviceContactPicker();
      contacts = contact;
      acessosController.name.value.text = contacts.displayName;
      var phones = (contacts.phones).map((e) => e.value);
      acessosController.phone.value.text = phones.first;
    } catch (e) {
      print(e.toString());
    }
  }

  getPermission() async {
    final status = await Permission.contacts.status;
    if (!status.isGranted) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.contacts,
      ].request();
      return statuses;
    }
  }

  @override
  void onInit() {
    getPermission();
    super.onInit();
  }
}
