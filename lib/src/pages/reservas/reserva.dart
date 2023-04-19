import 'package:condosocio/src/controllers/reservas/reservas_controller.dart';
import 'package:condosocio/src/pages/reservas/areas_comuns.dart';
import 'package:condosocio/src/pages/reservas/visualizar_reservas.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Reserva extends StatelessWidget {
  final ReservasController reservasController = Get.put(ReservasController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Reservas',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: Theme.of(context).textSelectionTheme.selectionColor,
            ),
          ),
          bottom: TabBar(
            indicatorColor: Theme.of(context).textSelectionTheme.selectionColor,
            indicatorPadding: EdgeInsets.all(-8),
            tabs: <Widget>[
              Text(
                'Adicionar',
                style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: Theme.of(context).textSelectionTheme.selectionColor),
              ),
              Text(
                'Visualizar',
                style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: Theme.of(context).textSelectionTheme.selectionColor),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [AreasComuns(), VisualizarReservas()],
        ),
      ),
    );
  }
}
