import 'package:condosocio/src/components/utils/alert_button_pressed.dart';
import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/components/utils/confirmed_button_pressed.dart';
import 'package:condosocio/src/components/utils/custom_text_field.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:condosocio/src/controllers/reservas/add_reservas_controller.dart';
import 'package:condosocio/src/controllers/reservas/calendario_reservas_controller.dart';
import 'package:condosocio/src/controllers/reservas/reservas_controller.dart';
import 'package:flutter/gestures.dart';
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
  final ReservasController reservasController = Get.put(ReservasController());
  final LoginController loginController = Get.put(LoginController());

  var startSelectedDate = DateTime.now();
  var startSelectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    var day = DateFormat('dd/MM/yyyy (EEEE)', 'pt')
        .format(calendarioReservasController.selectedDay.value);

    var selectedDay = calendarioReservasController.selectedDay.value;

    Future<TimeOfDay?> selectTime(BuildContext context) {
      final now = DateTime.now();
      return showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: now.hour, minute: 00),
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              alwaysUse24HourFormat: false,
            ),
            child: child!,
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          reservasController.nome.value,
          style: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textSelectionTheme.selectionColor!,
          ),
        ),
      ),
      body: Obx(
        () {
          return addReservasController.isLoading.value
              ? CircularProgressIndicatorWidget()
              : SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    padding: EdgeInsets.only(bottom: 10, top: 20),
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      day,
                                      style: GoogleFonts.montserrat(
                                        color: Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor!,
                                        fontSize: 14,
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
                                  startSelectedTime =
                                      (await selectTime(context))!;
                                  if (startSelectedTime == null) return;

                                  setState(() {
                                    startSelectedDate = DateTime(
                                      selectedDay.year,
                                      selectedDay.month,
                                      selectedDay.day,
                                      startSelectedTime.hour,
                                      00,
                                      //startSelectedTime.minute,
                                    );

                                    addReservasController.data.value.text =
                                        DateFormat("HH:mm").format(
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
                                  addReservasController.data.value,
                                ),
                              ),
                            ),
                          ],
                        ),
                        reservasController.termo.value != ''
                            ? Container(
                                padding: EdgeInsets.only(
                                    bottom: 20, left: 10, right: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Checkbox(
                                      value:
                                          addReservasController.isChecked.value,
                                      onChanged: (bool? value) {
                                        addReservasController.isChecked.value =
                                            value!;
                                      },
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      child: Text.rich(TextSpan(
                                          text: '\nLi e concordo com os ',
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .textSelectionTheme
                                                .selectionColor!,
                                          ),
                                          children: [
                                            TextSpan(
                                              text:
                                                  '\nTERMOS DE USO DA ÁREA COMUM',
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
                                    return Theme.of(context)
                                        .colorScheme
                                        .secondary;
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
                              onPressed: () {
                                addReservasController.date.value =
                                    DateFormat('yyyy-MM-dd')
                                        .format(startSelectedDate);
                                addReservasController.hora.value =
                                    DateFormat('HH:mm')
                                        .format(startSelectedDate);
                                addReservasController
                                    .incluirReserva()
                                    .then((value) {
                                  if (value == 'vazio') {
                                    onAlertButtonPressed(
                                        context,
                                        'Campo Nome do Evento, Hora Inicial ou Termos de Uso vazio(s)!',
                                        '',
                                        'sim');
                                  } else if (value == 'hora invalida') {
                                    onAlertButtonPressed(context,
                                        'Hora Inicial Inválida!', '', 'sim');
                                  } else {
                                    if (value == 3) {
                                      onAlertButtonPressed(
                                          context,
                                          'Horário indisponível\n Tente outro horário',
                                          '/home',
                                          'sim');
                                    }
                                    if (value == 1) {
                                      confirmedButtonPressed(
                                        context,
                                        'Reserva agendada com sucesso!',
                                        '/home',
                                      );
                                    }
                                    if (value == 0) {
                                      onAlertButtonPressed(
                                          context,
                                          'Algo deu errado \n Tente novamente',
                                          '/home',
                                          'sim');
                                    }
                                  }
                                });
                              },
                              child: Text(
                                'Incluir',
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor!,
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
