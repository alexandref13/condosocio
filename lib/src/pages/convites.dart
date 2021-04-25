import 'package:condosocio/src/components/convite_widget.dart';
import 'package:condosocio/src/controllers/acessos/acessos_controller.dart';
import 'package:condosocio/src/controllers/convites_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Convite extends StatelessWidget {
  final AcessosController acessosController = Get.put(AcessosController());
  final ConvitesController convitesController = Get.put(ConvitesController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Convites'),
      ),
      body: ConviteWidget(),
    );
  }
}
