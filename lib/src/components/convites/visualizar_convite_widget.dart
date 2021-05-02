import 'package:condosocio/src/controllers/convites_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VisualizarConviteWidget extends StatelessWidget {
  const VisualizarConviteWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ConvitesController convitesController = Get.put(ConvitesController());
    return Container(
      child: Center(
          child: ListView.builder(
              itemCount: convitesController.convites.length,
              itemBuilder: (_, i) {
                var convites = convitesController.convites[i];
                return Container(
                  child: Card(
                    child: ListTile(
                      title: Text(convites.titulo),
                      subtitle: Text('Convidados: ${convites.dateCreate}'),
                    ),
                  ),
                );
              })),
    );
  }
}
