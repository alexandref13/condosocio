import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/components/utils/custom_text_field.dart';
import 'package:condosocio/src/controllers/reservas/add_reservas_controller.dart';
import 'package:condosocio/src/controllers/reservas/calendario_reservas_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AddReservas extends StatefulWidget {
  @override
  _AddReservasState createState() => _AddReservasState();
}

class _AddReservasState extends State<AddReservas> {
  final AddReservasController addReservasController =
      Get.put(AddReservasController());

  final CalendarioReservasController calendarioReservasController =
      Get.put(CalendarioReservasController());

  var startSelectedDate = DateTime.now();
  var startSelectedTime = TimeOfDay.now();
  var startDate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var day = DateFormat('dd/MM/yyyy (EEEE)', 'pt')
        .format(calendarioReservasController.selectedDay.value);

    var selectedDay = calendarioReservasController.selectedDay.value;

    Future<TimeOfDay> selectTime(BuildContext context) {
      final now = DateTime.now();
      return showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: now.hour, minute: now.minute),
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child,
          );
        },
      );
    }

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
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Reserva para o dia ',
                                      style: GoogleFonts.montserrat(
                                        color: Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      day,
                                      style: GoogleFonts.montserrat(
                                        color: Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(bottom: 10),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: customTextField(
                                  context,
                                  'Nome do evento',
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
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              padding: EdgeInsets.only(
                                  bottom: 20, left: 10, right: 10),
                              child: GestureDetector(
                                onTap: () async {
                                  startSelectedTime = await selectTime(context);
                                  if (startSelectedTime == null) return;

                                  setState(() {
                                    startSelectedDate = DateTime(
                                      selectedDay.year,
                                      selectedDay.month,
                                      selectedDay.day,
                                      startSelectedTime.hour,
                                      startSelectedTime.minute,
                                    );

                                    startDate.text = DateFormat("HH:mm").format(
                                      startSelectedDate,
                                    );
                                  });

                                  print(startSelectedDate);
                                },
                                child: customTextField(
                                  context,
                                  'Hora Inicial',
                                  DateFormat("HH:mm").format(
                                    startSelectedDate,
                                  ),
                                  false,
                                  1,
                                  false,
                                  startDate,
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
                                'Incluir',
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
