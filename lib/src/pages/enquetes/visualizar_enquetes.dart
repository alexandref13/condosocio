import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/controllers/enquetes/visualizar_enquetes_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class VisualizarEnquetes extends StatelessWidget {
  final VisualizarEnquetesController visualizarEnquetesController =
      Get.put(VisualizarEnquetesController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return visualizarEnquetesController.isLoading.value
          ? CircularProgressIndicatorWidget()
          : Container(
              padding: EdgeInsets.all(8),
              child: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                      itemCount: visualizarEnquetesController.enquetes.length,
                      itemBuilder: (context, index) {
                        var enquetes =
                            visualizarEnquetesController.enquetes[index];

                        var day = enquetes.datacreate.split('/');

                        if (day[1] == '01') {
                          visualizarEnquetesController.month.value = 'Jan';
                        } else if (day[1] == '02') {
                          visualizarEnquetesController.month.value = 'Fev';
                        } else if (day[1] == '03') {
                          visualizarEnquetesController.month.value = 'Mar';
                        } else if (day[1] == '04') {
                          visualizarEnquetesController.month.value = 'Abr';
                        } else if (day[1] == '05') {
                          visualizarEnquetesController.month.value = 'Mai';
                        } else if (day[1] == '06') {
                          visualizarEnquetesController.month.value = 'Jul';
                        } else if (day[1] == '07') {
                          visualizarEnquetesController.month.value = 'Jun';
                        } else if (day[1] == '08') {
                          visualizarEnquetesController.month.value = 'Ago';
                        } else if (day[1] == '09') {
                          visualizarEnquetesController.month.value = 'Set';
                        } else if (day[1] == '10') {
                          visualizarEnquetesController.month.value = 'Out';
                        } else if (day[1] == '11') {
                          visualizarEnquetesController.month.value = 'Nov';
                        } else if (day[1] == '12') {
                          visualizarEnquetesController.month.value = 'Dez';
                        }

                        return GestureDetector(
                          onTap: () {
                            print(day[1]);
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            color: Theme.of(context).accentColor,
                            child: ListTile(
                                leading: RichText(
                                  text: TextSpan(
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: day[0] + '  ',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                        text: visualizarEnquetesController
                                            .month.value,
                                        style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            color: Theme.of(context)
                                                .textSelectionTheme
                                                .selectionColor,
                                            letterSpacing: 2),
                                      ),
                                    ],
                                  ),
                                ),
                                title: Container(
                                  child: Text(
                                    enquetes.titulo,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        color: Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                subtitle: Text(
                                  enquetes.datavalida,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 11,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
                                  ),
                                ),
                                trailing: Icon(
                                  Icons.arrow_right,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor,
                                  size: 30,
                                )),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
    });
  }
}
