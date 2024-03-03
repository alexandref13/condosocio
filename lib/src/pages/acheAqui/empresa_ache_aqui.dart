import 'package:condosocio/src/controllers/acheAqui/ache_aqui_controller.dart';
import 'package:condosocio/src/controllers/acheAqui/detalhes_ache_aqui_controller.dart';
import 'package:condosocio/src/pages/acheAqui/avaliacao_ache_aqui.dart';
import 'package:condosocio/src/pages/acheAqui/detalhes_ache_aqui.dart';
import 'package:flutter/material.dart';

//import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../../components/utils/edge_alert_error_widget.dart';
import '../../controllers/home_page_controller.dart';
import '../../controllers/login_controller.dart';

class EmpresaAcheAqui extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AcheAquiController acheAquiController = Get.put(AcheAquiController());
    DetalhesAcheAquiController detalhesAcheAquiController =
        Get.put(DetalhesAcheAquiController());
    final HomePageController homePageController = Get.put(HomePageController());
    final LoginController loginController = Get.put(LoginController());

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Empresa',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: Theme.of(context).textSelectionTheme.selectionColor!,
            ),
          ),
          bottom: TabBar(
            indicatorColor:
                Theme.of(context).textSelectionTheme.selectionColor!,
            indicatorPadding: EdgeInsets.all(-4),
            indicatorSize: TabBarIndicatorSize.tab,
            dividerColor: Theme.of(context)
                .textSelectionTheme
                .selectionColor!
                .withOpacity(0),
            tabs: <Widget>[
              Text(
                'Descrição',
                style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color:
                        Theme.of(context).textSelectionTheme.selectionColor!),
              ),
              Text(
                'Avaliações',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  color: Theme.of(context).textSelectionTheme.selectionColor!,
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
          backgroundColor: Theme.of(context).textSelectionTheme.selectionColor!,
          curve: Curves.elasticInOut,
          overlayColor: Colors.black,
          overlayOpacity: 0.5,
          shape: CircleBorder(),
          elevation: 5,
          children: [
            SpeedDialChild(
              child: Icon(Icons.phone_iphone_outlined,
                  color: Theme.of(context).textSelectionTheme.selectionColor),
              backgroundColor: Colors.red,
              label: 'Ligar',
              labelStyle: GoogleFonts.montserrat(
                fontSize: 14,
                color: Theme.of(context).primaryColor,
              ),
              onTap: () {
                var celular = acheAquiController.cel.value
                    .replaceAll("+", "")
                    .replaceAll("(", "")
                    .replaceAll(")", "")
                    .replaceAll("-", "")
                    .replaceAll(" ", "");

                acheAquiController.cel.value == ''
                    ? showToastError(
                        context,
                        'Parabéns!',
                      )
                    : detalhesAcheAquiController.launched =
                        detalhesAcheAquiController
                            .launchInBrowser('tel:$celular');
              },
            ),
            SpeedDialChild(
              child: Image.asset(
                'images/whatsapp.png',
                width: 38, // Defina a largura desejada da imagem
                height: 38, // Defina a altura desejada da imagem
              ),
              backgroundColor: Colors.green,
              label: 'Whatsapp',
              labelStyle: GoogleFonts.montserrat(
                fontSize: 14,
                color: Theme.of(context).primaryColor,
              ),
              onTap: () {
                var celular = acheAquiController.cel
                    .replaceAll("+", "")
                    .replaceAll("(", "")
                    .replaceAll(")", "")
                    .replaceAll("-", "")
                    .replaceAll(" ", "");

                var message = 'Sou ' +
                    loginController.nome.value +
                    ', encontrei a sua empresa através do *Ache Aqui* no aplicativo *CondoSócio*. Gostaria de obter mais informações, por favor.';

                // Remova qualquer caractere especial da mensagem
                message = Uri.encodeComponent(message);

                // Substitua os espaços por "%20" para URL
                message = message.replaceAll(' ', '%20');

                homePageController.launched =
                    homePageController.launchInBrowser(
                  'https://api.whatsapp.com/send?phone=55' +
                      celular +
                      '&text=' +
                      message,
                );
              },
            ),
            SpeedDialChild(
              child: Icon(
                Icons.mail_outline,
              ),
              backgroundColor: Colors.blue,
              label: 'E-Mail',
              labelStyle: GoogleFonts.montserrat(
                fontSize: 14,
                color: Theme.of(context).primaryColor,
              ),
              onTap: () {
                detalhesAcheAquiController.launched = detalhesAcheAquiController
                    .sendEmail(acheAquiController.email.value);
              },
            ),
            SpeedDialChild(
              child: Icon(
                Icons.where_to_vote_outlined,
                size: 24,
              ),
              backgroundColor: Colors.amber,
              label: 'Localização',
              labelStyle: GoogleFonts.montserrat(
                fontSize: 14,
                color: Theme.of(context).primaryColor,
              ),
              onTap: () {
                detalhesAcheAquiController.launched =
                    detalhesAcheAquiController.launchInBrowser(
                        "https://www.google.com/maps/search/?api=1&query=${Uri.encodeFull(acheAquiController.endereco.value)}");
              },
            ),
            SpeedDialChild(
              child: Icon(
                Icons.language_outlined,
                color: Theme.of(context).primaryColorLight,
              ),
              backgroundColor: Theme.of(context).colorScheme.secondary,
              label: 'Site',
              labelStyle: GoogleFonts.montserrat(
                fontSize: 14,
                color: Theme.of(context).primaryColor,
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
