import 'package:condosocio/src/components/utils/alert_button_pressed.dart';
import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/components/utils/confirmed_button_pressed.dart';
import 'package:condosocio/src/controllers/reservas/add_reservas_controller.dart';
import 'package:condosocio/src/controllers/reservas/detalhes_reservas_controller.dart';
import 'package:condosocio/src/controllers/reservas/reservas_controller.dart';
import 'package:condosocio/src/controllers/reservas/visualizar_reservas_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../components/utils/delete_alert.dart';

class DetalhesReservas extends StatelessWidget {
  final VisualizarReservasController visualizarReservasController =
      Get.put(VisualizarReservasController());
  final DetalhesReservasController detalhesReservasController =
      Get.put(DetalhesReservasController());
  final ReservasController reservasController = Get.put(ReservasController());
  final AddReservasController addReservasController =
      Get.put(AddReservasController());

  @override
  Widget build(BuildContext context) {
    confirmDelete(String text, VoidCallback function) {
      showAnimatedDialog(
        context: context,
        barrierDismissible: false,
        animationType: DialogTransitionType.fadeScale,
        curve: Curves.fastOutSlowIn,
        duration: Duration(milliseconds: 500),
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            backgroundColor:
                Theme.of(context).textSelectionTheme.selectionColor,
            content: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.warning,
                    color: Colors.orange,
                    size: 54,
                  ),
                  SizedBox(height: 10),
                  Text(
                    text,
                    style: GoogleFonts.poppins(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text(
                  "Cancelar",
                  style: GoogleFonts.montserrat(
                      color: Theme.of(context).colorScheme.error,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text(
                  "OK",
                  style: GoogleFonts.montserrat(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                onPressed: function,
              ),
            ],
          );
        },
      );
    }

    var day = DateTime.parse(detalhesReservasController.data.value);
    var newDate = DateFormat.yMMMMd('pt').format(day);

    var same = isSameDay(visualizarReservasController.dataDetalhes, day);
    var isBefore = visualizarReservasController.dataDetalhes.isBefore(day);

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        //backgroundColor: Color(0xff100329),
        title: Text(
          'Reservas',
          style: GoogleFonts.montserrat(
            fontSize: 16,
            color: Theme.of(context).textSelectionTheme.selectionColor!,
          ),
        ),
      ),
      body: Obx(() {
        return detalhesReservasController.isLoading.value
            ? CircularProgressIndicatorWidget()
            : Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height * .33,
                        width: MediaQuery.of(context).size.width * .9,
                        child: Card(
                          color: detalhesReservasController.status.value ==
                                  'Aprovado'
                              ? Colors.green[400]
                              : detalhesReservasController.status.value ==
                                      'Recusado'
                                  ? Colors.red[300]
                                  : Colors.amber,
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
                                        detalhesReservasController.nome.value,
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
                                        detalhesReservasController
                                            .unidade.value,
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
                                      'EVENTO: ',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      detalhesReservasController.titulo.value,
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
                                      'DATA: ',
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
                                        ' às ${detalhesReservasController.hora.value}',
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
                                      'ÁREA COMUM: ',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      detalhesReservasController.areacom.value,
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
                                      'STATUS: ',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      detalhesReservasController.status.value,
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              detalhesReservasController.status.value ==
                                      "Recusado"
                                  ? Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 14,
                                        horizontal: 10,
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            'MOTIVO: ',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            detalhesReservasController
                                                .respevent.value,
                                            style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    reservasController.termo.value != ''
                        ? Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 25),
                            child: ButtonTheme(
                              height: 50.0,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                      return Colors.white;
                                    },
                                  ),
                                  shape: MaterialStateProperty.resolveWith<
                                      OutlinedBorder>(
                                    (Set<MaterialState> states) {
                                      return RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      );
                                    },
                                  ),
                                ),
                                onPressed: () {
                                  Get.toNamed('/termos');
                                },
                                child: Text(
                                  "Leia o Termo de Uso ${reservasController.nome.value}",
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(),
                    !same &&
                            isBefore &&
                            detalhesReservasController.validaUsu.value != 0
                        ? Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 25),
                            child: ButtonTheme(
                              height: 50.0,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                      return Theme.of(context)
                                          .colorScheme
                                          .error;
                                    },
                                  ),
                                  shape: MaterialStateProperty.resolveWith<
                                      OutlinedBorder>(
                                    (Set<MaterialState> states) {
                                      return RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      );
                                    },
                                  ),
                                ),
                                onPressed: () {
                                  deleteAlert(
                                    context,
                                    'Deseja excluir a reserva\n ${detalhesReservasController.titulo.value}?',
                                    () {
                                      detalhesReservasController
                                          .deleteReserva()
                                          .then(
                                        (value) {
                                          if (value == 1) {
                                            confirmedButtonPressed(
                                              context,
                                              'Sua reserva foi cancelada com sucesso',
                                              '/home',
                                            );
                                          } else {
                                            onAlertButtonPressed(
                                                context,
                                                'Algo deu errado \n Tente novamente mais tarde',
                                                '/home',
                                                'images/error.png');
                                          }
                                        },
                                      );
                                    },
                                  );
                                },
                                child: Text(
                                  "Cancelar",
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor!,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              );
      }),
    );
  }
}
