import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/controllers/reservas/calendario_reservas_controller.dart';
import 'package:condosocio/src/controllers/reservas/reservas_controller.dart';
import 'package:condosocio/src/services/reservas/mapa_eventos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class TableCalendarWidget extends StatefulWidget {
  const TableCalendarWidget({Key key}) : super(key: key);

  @override
  _TableCalendarWidgetState createState() => _TableCalendarWidgetState();
}

class _TableCalendarWidgetState extends State<TableCalendarWidget> {
  CalendarioReservasController calendarioReservasController =
      Get.put(CalendarioReservasController());
  ReservasController reservasController = Get.put(ReservasController());

  bool oi = true;

  Widget buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSameDay(calendarioReservasController.selectedDay.value, date)
            ? Theme.of(context).buttonColor
            : Theme.of(context).accentColor,
      ),
      width: 18.0,
      height: 18.0,
      child: Center(
        child: Text('${events.length}',
            style: TextStyle().copyWith(
              color: Colors.white,
              fontSize: 14.0,
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          reservasController.nome.value,
          style: GoogleFonts.montserrat(
            fontSize: 16,
            color: Theme.of(context).textSelectionTheme.selectionColor,
          ),
        ),
      ),
      floatingActionButton: Obx(() {
        return calendarioReservasController.onSelected.value == true &&
                reservasController.multi.value == 'S'
            ? FloatingActionButton(
                onPressed: () {
                  Get.toNamed('/addReservas');
                },
                child: Icon(Icons.add),
              )
            : Container();
      }),
      body: Obx(
        () {
          return calendarioReservasController.isLoading.value
              ? CircularProgressIndicatorWidget()
              : Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      child: TableCalendar(
                        locale: 'pt_BR',
                        firstDay: DateTime(2017),
                        lastDay: DateTime(2100),
                        focusedDay:
                            calendarioReservasController.focusedDay.value,
                        availableGestures: AvailableGestures.all,
                        startingDayOfWeek: StartingDayOfWeek.sunday,
                        eventLoader:
                            calendarioReservasController.getEventsfromDay,
                        headerStyle: HeaderStyle(
                          formatButtonVisible: false,
                          titleCentered: true,
                          formatButtonShowsNext: false,
                          formatButtonDecoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          formatButtonTextStyle: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        calendarBuilders: CalendarBuilders(
                          markerBuilder: (context, date, events) {
                            if (events.isNotEmpty) {
                              return Positioned(
                                right: 4,
                                top: 2,
                                child: buildEventsMarker(date, events),
                              );
                            }
                            return Container();
                          },
                        ),
                        daysOfWeekStyle: DaysOfWeekStyle(
                          weekdayStyle: TextStyle(
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                          ),
                          weekendStyle: TextStyle(
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                          ),
                        ),
                        calendarStyle: CalendarStyle(
                          outsideDaysVisible: false,
                          todayDecoration: BoxDecoration(
                            color: Theme.of(context).buttonColor,
                            shape: BoxShape.circle,
                          ),
                          defaultTextStyle: TextStyle(
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                          ),
                          weekendTextStyle: TextStyle(
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                          ),
                          holidayTextStyle: TextStyle(
                            color: Colors.green,
                          ),
                          selectedTextStyle: TextStyle(
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                          ),
                          selectedDecoration: BoxDecoration(
                            color: Theme.of(context).accentColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        calendarFormat:
                            calendarioReservasController.calendarFormat,
                        onDaySelected: (selectedDay, focusedDay) {
                          calendarioReservasController.onSelected.value = true;

                          if (!isSameDay(selectedDay,
                              calendarioReservasController.selectedDay.value)) {
                            calendarioReservasController.selectedDay.value =
                                selectedDay;
                            calendarioReservasController.focusedDay.value =
                                focusedDay;
                          }

                          if (calendarioReservasController.events[
                                      calendarioReservasController
                                          .selectedDay.value] ==
                                  null &&
                              calendarioReservasController.selectedDay.value
                                  .isAfter(calendarioReservasController.day)) {
                            Get.toNamed('/addReservas');
                          } else {
                            if (calendarioReservasController
                                        .events[calendarioReservasController
                                            .selectedDay.value][0]
                                        .status ==
                                    'Recusado' &&
                                calendarioReservasController
                                        .events[calendarioReservasController
                                            .selectedDay.value][0]
                                        .validausu ==
                                    null) {
                              Get.toNamed('/addReservas');
                            }
                          }
                        },
                        selectedDayPredicate: (DateTime date) {
                          return isSameDay(
                              calendarioReservasController.selectedDay.value,
                              date);
                        },
                      ),
                    ),
                    ...calendarioReservasController
                        .getEventsfromDay(
                      calendarioReservasController.selectedDay.value,
                    )
                        .map((MapaEvento e) {
                      return e.status == 'Recusado'
                          ? e.validausu == null
                              ? Container()
                              : Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    color: e.status == 'Aprovado'
                                        ? Colors.green[400]
                                        : e.status == 'Recusado'
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
                                    title: Text(
                                      e.nome,
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                    ),
                                    subtitle: RichText(
                                      text: TextSpan(
                                        style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          color: Colors.black,
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: e.unidade,
                                              style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      calendarioReservasController.goToDetails(
                                        e.nome,
                                        e.unidade,
                                        e.titulo,
                                        e.dataAgenda,
                                        e.areacom,
                                        e.status,
                                        e.horaAgenda,
                                        e.respevent,
                                      );
                                    },
                                  ),
                                )
                          : Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                color: e.status == 'Aprovado'
                                    ? Colors.green[400]
                                    : e.status == 'Recusado'
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
                                title: Text(
                                  e.nome,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                ),
                                subtitle: RichText(
                                  text: TextSpan(
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: e.unidade,
                                          style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  calendarioReservasController.goToDetails(
                                    e.nome,
                                    e.unidade,
                                    e.titulo,
                                    e.dataAgenda,
                                    e.areacom,
                                    e.status,
                                    e.horaAgenda,
                                    e.respevent,
                                  );
                                },
                              ),
                            );
                    }),
                  ],
                );
        },
      ),
    );
  }
}
