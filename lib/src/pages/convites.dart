import 'package:condosocio/src/components/convites/convite_widget.dart';
import 'package:condosocio/src/components/convites/visualizar_convite_widget.dart';
import 'package:condosocio/src/components/convites/convites_convidados_widget.dart';
import 'package:condosocio/src/controllers/acessos/acessos_controller.dart';
import 'package:condosocio/src/controllers/convites/convites_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Convite extends StatelessWidget {
  final AcessosController acessosController = Get.put(AcessosController());
  final ConvitesController convitesController = Get.put(ConvitesController());
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                if (convitesController.page.value == 2) {
                  convitesController.handleMinusPage();
                } else if (convitesController.page.value == 1) {
                  Get.offNamed('/home');
                }
              },
              icon: Icon(Icons.arrow_back),
            ),
            title: Text(
              'Convites',
              style: GoogleFonts.montserrat(
                fontSize: 16,
                color: Theme.of(context).textSelectionTheme.selectionColor,
              ),
            ),
            bottom: TabBar(
              indicatorColor:
                  Theme.of(context).textSelectionTheme.selectionColor,
              tabs: <Widget>[
                Text(
                  'Adicionar',
                  style: GoogleFonts.montserrat(
                      fontSize: 14,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor),
                ),
                Text(
                  'Visualizar',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: Theme.of(context).textSelectionTheme.selectionColor,
                  ),
                ),
              ],
            ),
          ),
          body: Obx(() {
            return TabBarView(
              children: [
                convitesController.page.value == 1
                    ? ConviteWidget()
                    : ConvitesConvidadosWidget(),
                VisualizarConviteWidget()
              ],
            );
          })),
    );
  }
}
