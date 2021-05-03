import 'package:condosocio/src/controllers/convites/visualizar_convites_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DetalheConviteWidget extends StatelessWidget {
  const DetalheConviteWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VisualizarConvitesController visualizarConvitesController =
        Get.put(VisualizarConvitesController());

    var endDate = DateTime.parse(visualizarConvitesController.endDate.value);

    var formatEndDateDay = DateFormat("dd/MM/yyyy").format(
      endDate,
    );
    var formatEndDateHour = DateFormat("HH:mm").format(
      endDate,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(visualizarConvitesController.titulo.value),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    child: Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Text(
                              'Término do evento',
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Feather.calendar,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                                size: 20,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 5),
                                child: Text(
                                  formatEndDateDay,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 20,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.watch_later_outlined,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                          size: 20,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            formatEndDateHour,
                            style: GoogleFonts.montserrat(
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
