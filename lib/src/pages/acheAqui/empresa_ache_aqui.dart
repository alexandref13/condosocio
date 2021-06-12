import 'package:condosocio/src/controllers/acheAqui/ache_aqui_controller.dart';
import 'package:condosocio/src/controllers/acheAqui/detalhes_ache_aqui_controller.dart';
import 'package:condosocio/src/pages/acheAqui/avaliacao_ache_aqui.dart';
import 'package:condosocio/src/pages/acheAqui/detalhes_ache_aqui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class EmpresaAcheAqui extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AcheAquiController acheAquiController = Get.put(AcheAquiController());
    DetalhesAcheAquiController detalhesAcheAquiController =
        Get.put(DetalhesAcheAquiController());

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Empresa',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: Theme.of(context).textSelectionTheme.selectionColor,
            ),
          ),
          bottom: TabBar(
            indicatorColor: Theme.of(context).textSelectionTheme.selectionColor,
            tabs: <Widget>[
              Text(
                'Descrição',
                style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: Theme.of(context).textSelectionTheme.selectionColor),
              ),
              Text(
                'Avaliação',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  color: Theme.of(context).textSelectionTheme.selectionColor,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [DetalhesAcheAqui(), AvaliacaoAcheAqui()],
        ),
        floatingActionButton: SpeedDial(
          icon: Icons.question_answer_outlined,
          iconTheme: IconThemeData(color: Colors.black),
          activeIcon: Icons.close,
          visible: true,
          closeManually: false,
          renderOverlay: false,
          backgroundColor: Theme.of(context).textSelectionTheme.selectionColor,
          curve: Curves.elasticInOut,
          overlayColor: Colors.black,
          overlayOpacity: 0.5,
          shape: CircleBorder(),
          elevation: 5,
          children: [
            SpeedDialChild(
              child: Icon(Icons.phone_iphone_outlined),
              backgroundColor: Colors.red,
              label: 'Ligar para a empresa',
              labelStyle: GoogleFonts.montserrat(
                fontSize: 14,
                color: Theme.of(context).textSelectionTheme.selectionColor,
              ),
              onTap: () {
                detalhesAcheAquiController.launched = detalhesAcheAquiController
                    .launchInBrowser('tel: ${acheAquiController.cel}');
              },
            ),
            SpeedDialChild(
              child: Icon(FontAwesome.whatsapp),
              backgroundColor: Colors.green,
              label: 'Whatsapp',
              labelStyle: GoogleFonts.montserrat(
                fontSize: 14,
                color: Theme.of(context).textSelectionTheme.selectionColor,
              ),
              onTap: () {
                var celular = acheAquiController.cel
                    .replaceAll("+", "")
                    .replaceAll("(", "")
                    .replaceAll(")", "")
                    .replaceAll("-", "")
                    .replaceAll(" ", "");
                detalhesAcheAquiController.launched =
                    detalhesAcheAquiController.launchInBrowser(
                        "whatsapp://send?phone=55$celular&text=Encontrei a sua empresa pelo aplicativo *CondoSócio*");
              },
            ),
            SpeedDialChild(
              child: Icon(Icons.mail_outline),
              backgroundColor: Colors.blue,
              label: 'E-Mail',
              labelStyle: GoogleFonts.montserrat(
                fontSize: 14,
                color: Theme.of(context).textSelectionTheme.selectionColor,
              ),
              onTap: () {
                detalhesAcheAquiController.launched = detalhesAcheAquiController
                    .sendEmail(acheAquiController.email.value);
              },
            ),
            SpeedDialChild(
              child: Icon(Icons.where_to_vote_outlined),
              backgroundColor: Colors.amber,
              label: 'Localização',
              labelStyle: GoogleFonts.montserrat(
                fontSize: 14,
                color: Theme.of(context).textSelectionTheme.selectionColor,
              ),
              onTap: () {
                detalhesAcheAquiController.launched =
                    detalhesAcheAquiController.launchInBrowser(
                        "https://www.google.com/maps/search/?api=1&query=${acheAquiController.endereco}");
              },
            ),
            SpeedDialChild(
              child: Icon(Icons.language_outlined),
              backgroundColor: Theme.of(context).accentColor,
              label: 'Site',
              labelStyle: GoogleFonts.montserrat(
                fontSize: 14,
                color: Theme.of(context).textSelectionTheme.selectionColor,
              ),
              onTap: () {
                if (acheAquiController.site.value != '') {
                  detalhesAcheAquiController.launched =
                      detalhesAcheAquiController
                          .launchInBrowser(acheAquiController.site.value);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
