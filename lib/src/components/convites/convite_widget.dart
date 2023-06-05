import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/components/utils/custom_text_field.dart';
import 'package:condosocio/src/controllers/acessos/acessos_controller.dart';
import 'package:condosocio/src/controllers/convites/convites_controller.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ConviteWidget extends StatefulWidget {
  @override
  _ConviteWidgetState createState() => _ConviteWidgetState();
}

class _ConviteWidgetState extends State<ConviteWidget> {
  var startSelectedDate = DateTime.now();
  var startSelectedTime = TimeOfDay.now();
  var endSelectedDate = DateTime.now();
  var endSelectedTime = TimeOfDay.now();
  var startDate = TextEditingController();
  var startTime = TextEditingController();
  var endDate = TextEditingController();
  var endTime = TextEditingController();

  //Bool acesso;

  AcessosController acessosController = Get.put(AcessosController());
  ConvitesController convitesController = Get.put(ConvitesController());
  LoginController loginController = Get.put(LoginController());

  Future<TimeOfDay?> selectTime(BuildContext context) {
    final now = DateTime.now();
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: now.hour, minute: now.minute),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!);
      },
    );
  }

  Future<TimeOfDay?> selectEndTime(BuildContext context) {
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 23, minute: 59),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!);
      },
    );
  }

  Future<DateTime?> selectDateTime(BuildContext context) => showDatePicker(
        context: context,
        initialDate: DateTime.now().add(Duration(seconds: 1)),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100),
      );

  Future<DateTime?> selectDateOnEndTime(BuildContext context) => showDatePicker(
        context: context,
        initialDate: startSelectedDate,
        firstDate: startSelectedDate,
        lastDate: DateTime(2030),
      );

  @override
  void initState() {
    var formatDate = convitesController.endDate.value != ''
        ? DateTime.parse(convitesController.endDate.value)
        : null;

    var formatDateStart = convitesController.startDate.value != ''
        ? DateTime.parse(convitesController.startDate.value)
        : null;

    convitesController.endDate.value != ''
        ? endSelectedDate = DateTime(
            formatDate!.year,
            formatDate.month,
            formatDate.day,
            formatDate.hour,
            formatDate.minute,
          )
        : endSelectedDate = DateTime(
            startSelectedDate.year,
            startSelectedDate.month,
            startSelectedDate.day,
            23,
            59,
          );

    convitesController.startDate.value != ''
        ? startSelectedDate = DateTime(
            formatDateStart!.year,
            formatDateStart.month,
            formatDateStart.day,
            formatDateStart.hour,
            formatDateStart.minute,
          )
        : startSelectedDate = DateTime(
            startSelectedDate.year,
            startSelectedDate.month,
            startSelectedDate.day,
            startSelectedTime.hour,
            startSelectedTime.minute,
          );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return acessosController.isLoading.value
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 15),
                              child: Text(
                                'Nome do convite',
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor!,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 10),
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: customTextField(
                                context,
                                '',
                                'Convite de ${loginController.nome.value}',
                                false,
                                1,
                                true,
                                convitesController.inviteName.value,
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
                              'Início',
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor!,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            padding: EdgeInsets.only(
                                bottom: 20, left: 10, right: 10),
                            child: GestureDetector(
                              onTap: () async {
                                startSelectedDate =
                                    (await selectDateTime(context))!;
                                if (startSelectedDate == '') return;

                                startSelectedTime =
                                    (await selectTime(context))!;
                                if (startSelectedTime == '') return;

                                setState(() {
                                  startSelectedDate = DateTime(
                                    startSelectedDate.year,
                                    startSelectedDate.month,
                                    startSelectedDate.day,
                                    startSelectedTime.hour,
                                    startSelectedTime.minute,
                                  );
                                });
                              },
                              child: customTextField(
                                context,
                                '',
                                DateFormat("dd/MM/yyyy HH:mm").format(
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
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: 20, left: 10, right: 10),
                            child: Text(
                              'Término',
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor!,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            padding: EdgeInsets.only(
                                bottom: 20, left: 10, right: 10),
                            child: GestureDetector(
                              onTap: () async {
                                endSelectedDate =
                                    (await selectDateOnEndTime(context))!;
                                if (endSelectedDate == '') return;

                                endSelectedTime =
                                    (await selectEndTime(context))!;
                                if (endSelectedTime == '') return;

                                setState(() {
                                  endSelectedDate = DateTime(
                                    endSelectedDate.year,
                                    endSelectedDate.month,
                                    endSelectedDate.day,
                                    endSelectedTime.hour,
                                    endSelectedTime.minute,
                                  );
                                });
                              },
                              child: customTextField(
                                context,
                                '',
                                (DateFormat("dd/MM/yyyy HH:mm").format(
                                  endSelectedDate,
                                )),
                                false,
                                1,
                                false,
                                endTime,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Spacer(),
                          Column(
                            children: [
                              Text(
                                'Acesso Livre (N/S)',
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor!,
                                ),
                              ),
                            ],
                          ),
                          Obx(
                            () => Column(
                              children: [
                                Switch(
                                  value: convitesController.isChecked.value,
                                  onChanged: (newValue) {
                                    convitesController.isChecked.value =
                                        newValue;
                                  },
                                  activeColor: Theme.of(context).shadowColor,
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                      Center(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            convitesController.isChecked.value == true
                                ? 'Com o acesso livre, os convidados têm a liberdade de entrar e sair quantas vezes desejarem durante todo o período do evento.'
                                : 'Com o único acesso, os convidados terão permissão para entrar no evento apenas uma vez durante todo o período.',
                            style: GoogleFonts.montserrat(
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor!,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                              convitesController.startDate.value =
                                  startSelectedDate.toString();
                              convitesController.endDate.value =
                                  endSelectedDate.toString();
                              convitesController.handleAddPage();
                            },
                            child: Text(
                              'Continuar',
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
    );
  }
}
