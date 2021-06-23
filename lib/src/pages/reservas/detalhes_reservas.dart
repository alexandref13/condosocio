import 'package:condosocio/src/components/utils/alert_button_pressed.dart';
import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/components/utils/confirmed_button_pressed.dart';
import 'package:condosocio/src/controllers/reservas/add_reservas_controller.dart';
import 'package:condosocio/src/controllers/reservas/detalhes_reservas_controller.dart';
import 'package:condosocio/src/controllers/reservas/reservas_controller.dart';
import 'package:condosocio/src/controllers/reservas/visualizar_reservas_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
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
                        height: MediaQuery.of(context).size.height * .35,
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
                                            'Motivo da Recusa: ',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        : Container(),
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
                        ),
                      ),
                    ),
                    reservasController.termo.value != '' &&
                            !same &&
                            isBefore &&
                            detalhesReservasController.validaUsu.value != null
                        ? Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 7, horizontal: 15),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(
                                  value: addReservasController.isChecked.value,
                                  onChanged: (bool value) {
                                    addReservasController.isChecked.value =
                                        value;
                                  },
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: Text.rich(TextSpan(
                                      text: '\nLi e concordo com os ',
                                      children: [
                                        TextSpan(
                                          text: '\nTERMOS DE USO DA ÁREA COMUM',
                                          style: GoogleFonts.montserrat(
                                            color: Colors.amberAccent,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Get.toNamed('/termos');
                                            },
                                        ),
                                      ])),
                                )
                              ],
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
                                  if (addReservasController.isChecked.value ==
                                      true) {
                                    detalhesReservasController
                                        .deleteReserva()
                                        .then(
                                      (value) {
                                        if (value == 1) {
                                          confirmedButtonPressed(
                                            context,
                                            'Sua reserva foi deletada com sucesso',
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
                                  }
                                },
                                child: Text(
                                  "Deletar",
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
