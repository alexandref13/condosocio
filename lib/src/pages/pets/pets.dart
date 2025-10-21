import 'package:condosocio/src/controllers/pets_controller.dart';
import 'package:condosocio/src/pages/pets/visualizar_pets.dart';
import 'package:condosocio/src/pages/pets/adiciona_pets.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../components/utils/alert_button_pressed.dart';

class Pets extends StatefulWidget {
  @override
  _PetsState createState() => _PetsState();
}

class _PetsState extends State<Pets> {
  PetsController petsController = Get.put(PetsController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Meu(s) Pet(s)',
              style: GoogleFonts.montserrat(
                fontSize: 16,
                color: Theme.of(context).textSelectionTheme.selectionColor!,
              ),
            ),
            centerTitle: true,
            /*actions: [
              IconButton(
                icon: Icon(
                  Icons.info_outline,
                  color: Theme.of(context).textSelectionTheme.selectionColor!,
                ),
                onPressed: () {
                  onAlertButtonPressed(
                    context,
                    'Os moradores receberão automaticamente um e-mail para definir sua senha e obter acesso ao CondoSócio. Assim, poderão aproveitar todos os serviços oferecidos pela plataforma, incluindo a possibilidade de cadastrar sua face (para condomínios que possuem essa tecnologia). É importante lembrar que você só deve cadastrar pessoas que residem com você no condomínio. O descumprimento dessa norma sujeitará você a penalidades conforme o regulamento interno e/ou a Convenção.\n\nNo caso de prestadores de serviço, após o cadastro, você precisará clicar no ícone do WhatsApp para enviar o link de cadastramento de documentos e da face (para condomínios com essa tecnologia).',
                    '',
                    '',
                  );
                },
              )
            ],*/
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
                  'Visualizar',
                  style: GoogleFonts.montserrat(
                      fontSize: 14,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor!),
                ),
                Text(
                  'Adicionar',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: Theme.of(context).textSelectionTheme.selectionColor!,
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(children: [VisualizarPets(), AdicionaPets()]),
        ),
      ),
    );
  }
}
