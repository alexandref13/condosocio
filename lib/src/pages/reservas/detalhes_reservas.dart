import 'package:condosocio/src/controllers/reservas/calendario_reservas_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DetalhesReservas extends StatelessWidget {
  final CalendarioReservasController calendarioReservasController =
      Get.put(CalendarioReservasController());

  @override
  Widget build(BuildContext context) {
    var day = DateTime.parse(calendarioReservasController.data.value);
    var newDate = DateFormat.yMMMMd('pt').format(day);
    var newHour = DateFormat('HH:mm', 'pt').format(day);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reservas',
          style: GoogleFonts.montserrat(
            fontSize: 16,
            color: Theme.of(context).textSelectionTheme.selectionColor,
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Container(
              height: MediaQuery.of(context).size.height * .35,
              width: MediaQuery.of(context).size.width * .9,
              child: Card(
                color: calendarioReservasController.status.value == 'Aprovado'
                    ? Colors.green
                    : calendarioReservasController.status.value == 'Recusado'
                        ? Colors.red
                        : Colors.amber[700],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              calendarioReservasController.nome.value,
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 3),
                            child: Text(
                              calendarioReservasController.unidade.value,
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 10,
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Evento: ',
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            calendarioReservasController.titulo.value,
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 10,
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Data: ',
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            newDate,
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                          Container(
                            child: Text(
                              ' às $newHour',
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 10,
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Área Comum: ',
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            calendarioReservasController.area.value,
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 10,
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Status: ',
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            calendarioReservasController.status.value,
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
