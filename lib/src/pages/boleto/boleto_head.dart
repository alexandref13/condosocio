import 'package:condosocio/src/controllers/boleto_controller.dart';
import 'package:condosocio/src/pages/boleto/visualizar_boletos.dart';
import 'package:condosocio/src/pages/ouvidoria/adiciona_ouvidoria.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Boletos extends StatefulWidget {
  @override
  _BoletosState createState() => _BoletosState();
}

class _BoletosState extends State<Boletos> {
  BoletoController ouvidoriaController = Get.put(BoletoController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Get.offNamed('/home');
              },
              icon: Icon(Icons.arrow_back_ios),
            ),
            title: Text(
              'Boletos',
              style: GoogleFonts.montserrat(
                fontSize: 16,
                color: Theme.of(context).textSelectionTheme.selectionColor!,
              ),
            ),
            centerTitle: true,
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
                  'Em Aberto',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: Theme.of(context).textSelectionTheme.selectionColor!,
                  ),
                ),
                /*Text(
                  'Pagos',
                  style: GoogleFonts.montserrat(
                      fontSize: 14,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor!),
                ),*/
              ],
            ),
          ),
          body: TabBarView(
            // children: [VisualizarBoletos(), AdicionaOuvidoria()],
            children: [VisualizarBoletos()],
          ),
        ),
      ),
    );
  }
}
