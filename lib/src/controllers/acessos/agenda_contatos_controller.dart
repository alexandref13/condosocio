import 'package:condosocio/src/controllers/convites/convites_controller.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'acessos_controller.dart';

class AgendaContatosController extends GetxController {
  AcessosController acessosController = Get.put(AcessosController());
  ConvitesController convitesController = Get.put(ConvitesController());
  Contact? contacts;
  var phone;

  Future<void> pickContact() async {
    try {
      final contact = await FlutterContacts.openExternalPick();

      if (contact != null) {
        contacts = contact;
        final phones = contact.phones.map((e) => e.number);

        if (phones.isNotEmpty) {
          convitesController.guestList.add({
            'nome': contact.displayName,
            'tel': phones.first,
            'tipo': 'Convidado',
          });
        }
      }
    } catch (e) {
      print('Erro ao selecionar contato: $e');
    }
  }

  Future<bool> getPermission() async {
    final status = await Permission.contacts.status;
    if (!status.isGranted) {
      final result = await Permission.contacts.request();
      return result.isGranted;
    }
    return true;
  }

  @override
  void onInit() {
    getPermission();
    super.onInit();
  }
}
