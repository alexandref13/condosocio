import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:condosocio/src/controllers/reservas/calendario_reservas_controller.dart';
import 'package:condosocio/src/controllers/reservas/visualizar_reservas_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class VisualizarReservas extends StatelessWidget {
  final VisualizarReservasController visualizarReservasController =
      Get.put(VisualizarReservasController());
  final CalendarioReservasController calendarioReservasController =
      Get.put(CalendarioReservasController());
  final LoginController loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return visualizarReservasController.isLoading.value
          ? CircularProgressIndicatorWidget()
          : visualizarReservasController.reservaslength.value == 0
              ? Stack(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset(
                        'images/semregistro.png',
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 100),
                            //child: Icon(Icons.block, size: 34, color: Colors.red[900]),
                          ),
                          Text(
                            'Sem registros',
                            style: GoogleFonts.montserrat(
                              fontSize: 14.0,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              : Container(
                  padding: EdgeInsets.only(top: 10),
                  child: ListView.builder(
                      itemCount: visualizarReservasController.reservas.length,
                      itemBuilder: (_, i) {
                        var reservas = visualizarReservasController.reservas[i];

                        var data = reservas.dataAgenda;
                        var newData = data.split('-');

                        var before = visualizarReservasController.data.isBefore(
                            DateTime.parse(
                                '${reservas.dataAgenda} ${reservas.horaAgenda}'));

                        return GestureDetector(
                          onTap: () {
                            calendarioReservasController.goToDetails(
                              '${loginController.nomeusu.value} ${loginController.sobrenome.value}',
                              loginController.unidade.value,
                              reservas.titulo,
                              reservas.dataAgenda,
                              reservas.areacom,
                              reservas.status,
                              reservas.horaAgenda,
                              reservas.resposta,
                            );
                          },
                          child: before
                              ? Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    color: reservas.status == 'Aprovado'
                                        ? Colors.green[400]
                                        : reservas.status == 'Recusado'
                                            ? Colors.red[300]
                                            : Colors.amber,
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 4.0),
                                  child: ListTile(
                                    trailing: Icon(
                                      Icons.arrow_right_outlined,
                                      color: Colors.black,
                                    ),
                                    title: Container(
                                      padding: EdgeInsets.only(
                                        top: 5,
                                      ),
                                      child: Text(
                                        reservas.titulo,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    subtitle: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Container(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 5),
                                          child: Text(
                                            reservas.areacom,
                                            style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                            bottom: 5,
                                          ),
                                          child: Text(
                                            '${newData[2]}/${newData[1]}/${newData[0]} ${reservas.horaAgenda}h',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    color: Theme.of(context).buttonColor,
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 4.0),
                                  child: ListTile(
                                    trailing: Icon(
                                      Icons.arrow_right_outlined,
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor,
                                    ),
                                    title: Container(
                                      padding: EdgeInsets.only(
                                        top: 5,
                                      ),
                                      child: Text(
                                        reservas.titulo,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    subtitle: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Container(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 5),
                                          child: Text(
                                            reservas.areacom,
                                            style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              color: Theme.of(context)
                                                  .textSelectionTheme
                                                  .selectionColor,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                            bottom: 5,
                                          ),
                                          child: Text(
                                            '${newData[2]}/${newData[1]}/${newData[0]} ${reservas.horaAgenda}h',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              color: Theme.of(context)
                                                  .textSelectionTheme
                                                  .selectionColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                        );
                      }),
                );
    });
  }
}
