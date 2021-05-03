import 'package:condosocio/src/controllers/convites/visualizar_convites_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetalheConviteWidget extends StatelessWidget {
  const DetalheConviteWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VisualizarConvitesController visualizar_convites_controller =
        Get.put(VisualizarConvitesController());

    return Scaffold();
  }
}
