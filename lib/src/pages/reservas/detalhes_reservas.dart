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
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:table_calendar/table_calendar.dart';

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
      Alert(
        image: Icon(
          Icons.highlight_off,
          color: Colors.yellowAccent,
          size: 60,
        ),
        style: AlertStyle(
          backgroundColor: Theme.of(context).textSelectionTheme.selectionColor,
          animationType: AnimationType.fromTop,
          isCloseButton: false,
          isOverlayTapDismiss: false,
          //descStyle: GoogleFonts.poppins(color: Colors.red,),
          animationDuration: Duration(milliseconds: 300),
          titleStyle: GoogleFonts.poppins(
            color: Theme.of(context).errorColor,
            fontSize: 18,
          ),
        ),
        context: context,
        title: text,
        buttons: [
          DialogButton(
            child: Text(
              "Cancelar",
              style: GoogleFonts.montserrat(
                color: Theme.of(context).textSelectionTheme.selectionColor,
                fontSize: 16,
              ),
            ),
            onPressed: () {
              Get.back();
            },
            width: 80,
            color: Theme.of(context).errorColor,
          ),
          DialogButton(
            child: Text(
              "OK",
              style: GoogleFonts.montserrat(
                color: Theme.of(context).textSelectionTheme.selectionColor,
                fontSize: 16,
              ),
            ),
            onPressed: function,
            width: 80,
            color: Theme.of(context).primaryColor,
          )
        ],
      ).show();
    }

    var day = DateTime.parse(detalhesReservasController.data.value);
    var newDate = DateFormat.yMMMMd('pt').format(day);

    var same = isSameDay(visualizarReservasController.dataDetalhes, day);
    var isBefore = visualizarReservasController.dataDetalhes.isBefore(day);

    return Scaffold(
      backgroundColor: Color(0xff100329),
      appBar: AppBar(
        backgroundColor: Color(0xff100329),
        title: Text(
          'Reservas',
          style: GoogleFonts.montserrat(
            fontSize: 16,
            color: Theme.of(context).textSelectionTheme.selectionColor,
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
                        height: MediaQuery.of(context).size.height * .45,
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
                                      'Evento: ',
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
                                      'Área Comum: ',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      detalhesReservasController.area.value,
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
                                      detalhesReservasController.status.value,
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
                                    detalhesReservasController.status.value ==
                                            "Recusado"
                                        ? Text(
                                            'Motivo: ',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
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
                                    ),
                                  ],
                                ),
                              )
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
                            detalhesReservasController.validaUsu.value != null
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
                                      return Theme.of(context).errorColor;
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
                                  confirmDelete(
                                    'Deseja cancelar a reserva ${detalhesReservasController.titulo.value}?',
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
                                            );
                                          }
                                        },
                                      );
                                    },
                                  );
                                },
                                child: Text(
                                  "Cancelar Evento",
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
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
