import 'package:condosocio/src/components/reservas/calendario_reservas.dart';
import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/components/utils/custom_text_field.dart';
import 'package:condosocio/src/controllers/reservas/add_reservas_controller.dart';
import 'package:condosocio/src/controllers/reservas/calendario_reservas_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class AddReservas extends StatelessWidget {
  const AddReservas({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AddReservasController addReservasController =
        Get.put(AddReservasController());
    CalendarioReservasController calendarioReservasController =
        Get.put(CalendarioReservasController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Reservas'),
      ),
      body: Obx(
        () {
          return addReservasController.isLoading.value
              ? CircularProgressIndicatorWidget()
              : SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    padding: EdgeInsets.only(bottom: 10, top: 50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 15),
                                child: Text(
                                  'Titulo',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(bottom: 10),
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: customTextField(
                                  context,
                                  null,
                                  'Diga qual o seu evento',
                                  false,
                                  1,
                                  true,
                                  addReservasController.titulo.value,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom: 20, left: 10, right: 10),
                              child: Text(
                                'Data',
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              padding: EdgeInsets.only(
                                  bottom: 20, left: 10, right: 10),
                              child: GestureDetector(
                                onTap: () async {
                                  Get.toNamed('/calendario');
                                },
                                child: customTextField(
                                  context,
                                  null,
                                  'Entre com a data do seu evento',
                                  false,
                                  1,
                                  false,
                                  addReservasController.data.value,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom: 20, left: 10, right: 10),
                              child: Text(
                                'Hora Inicial',
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              padding: EdgeInsets.only(
                                  bottom: 20, left: 10, right: 10),
                              child: GestureDetector(
                                onTap: () async {},
                                child: customTextField(
                                  context,
                                  null,
                                  'Entre com a hora de inicio do evento',
                                  false,
                                  1,
                                  false,
                                  addReservasController.hora.value,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: ButtonTheme(
                            height: 50.0,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    return Theme.of(context).accentColor;
                                  },
                                ),
                                shape: MaterialStateProperty.resolveWith<
                                    OutlinedBorder>(
                                  (Set<MaterialState> states) {
                                    return RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    );
                                  },
                                ),
                              ),
                              onPressed: () {},
                              child: Text(
                                'Enviar',
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
