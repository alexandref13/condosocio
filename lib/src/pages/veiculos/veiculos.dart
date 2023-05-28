import 'package:condosocio/src/pages/veiculos/adiciona_veiculos.dart';
import 'package:condosocio/src/pages/veiculos/visualizar_veiculos.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/veiculos/veiculos_controller.dart';

class Veiculos extends StatefulWidget {
  @override
  _VeiculosState createState() => _VeiculosState();
}

class _VeiculosState extends State<Veiculos> {
  VeiculosController veiculosController = Get.put(VeiculosController());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Coloque aqui o código que precisa ser executado ao sair do widget
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Veículos',
              style: GoogleFonts.montserrat(
                fontSize: 16,
                color: Theme.of(context).textSelectionTheme.selectionColor!,
              ),
            ),
            centerTitle: true,
            /*actions: [
              IconButton(
                icon: Icon(
                  AntDesign.infocirlce,
                  color: Theme.of(context).textSelectionTheme.selectionColor!,
                ),
                onPressed: () {
                  onAlertButtonPressed(context,
                      'Moradores receberão automaticamente um e-mail para definicão de senha e terão assim acesso ao CondoSócio e poderão cadastrar a face (para condomínios com essa tecnologia), além de utilizar todos os serviços da plataforma. Lembramos que você deverá cadastrar apenas pessoas que residem com você no condomínio, se houver descumprimento desta norma, estará sujeito às penalidades dispostas no regulamento interno e ou Convenção.\n\n Prestadores de serviço após o cadastro deste, você deverá clicar no ícone do whatsapp para o envio do link de cadastramento dos documentos e face (para condomínios com essa tecnologia).');
                },
              )
            ],*/
            bottom: TabBar(
              indicatorColor:
                  Theme.of(context).textSelectionTheme.selectionColor!,
              indicatorPadding: EdgeInsets.all(-8),
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
          body:
              TabBarView(children: [VisualizarVeiculos(), AdicionaVeiculos()]),
        ),
      ),
    );
  }
}
