import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/controllers/reservas/add_reservas_controller.dart';
import 'package:condosocio/src/controllers/reservas/calendario_reservas_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class TableCalendarWidget extends StatefulWidget {
  const TableCalendarWidget({Key key}) : super(key: key);

  @override
  _TableCalendarWidgetState createState() => _TableCalendarWidgetState();
}

class _TableCalendarWidgetState extends State<TableCalendarWidget> {
  AddReservasController addReservasController =
      Get.put(AddReservasController());

  CalendarioReservasController calendarioReservasController =
      Get.put(CalendarioReservasController());

  // Widget buildEventsMarker(DateTime date, List events) {
  //   return AnimatedContainer(
  //     duration: const Duration(milliseconds: 300),
  //     decoration: BoxDecoration(
  //       shape: BoxShape.circle,
  //       color: _calendarController.isSelected(date)
  //           ? Colors.black
  //           : _calendarController.isToday(date)
  //               ? Colors.grey
  //               : Colors.grey,
  //     ),
  //     width: 18.0,
  //     height: 18.0,
  //     child: Center(
  //       child: Text(
  //         '${events.length}',
  //         style: TextStyle().copyWith(
  //           color: Colors.white,
  //           fontSize: 14.0,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Obx(
        () {
          return addReservasController.isLoading.value
              ? CircularProgressIndicatorWidget()
              : Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      child: TableCalendar(
                        locale: 'pt_BR',
                        firstDay: DateTime.now(),
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
                            color: Theme.of(context).errorColor,
                            shape: BoxShape.rectangle,
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
                            shape: BoxShape.rectangle,
                          ),
                        ),
                        // calendarBuilders: CalendarBuilders(
                        //   markerBuilder: (context, date, events) {
                        //     final children = <Widget>[];
                        //     if (events.isNotEmpty) {
                        //       children.add(
                        //         Positioned(
                        //           right: 1,
                        //           top: 1,
                        //           child: buildEventsMarker(date, events),
                        //         ),
                        //       );
                        //     }
                        //   },
                        // ),
                        calendarFormat:
                            calendarioReservasController.calendarFormat,
                        onDaySelected: (selectedDay, focusedDay) {
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
                              null) {
                            Get.toNamed('/addReservas');
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
                            calendarioReservasController.selectedDay.value)
                        .map((e) => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                color: e.split('>')[1] == ' Aprovado'
                                    ? Colors.green
                                    : e.split('>')[1] == ' Recusado'
                                        ? Colors.red
                                        : Colors.amber,
                              ),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 4.0),
                              child: ListTile(
                                trailing: Text(
                                  "OS ${e.split('-')[0]}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                                title: Text(
                                  e.split('-')[1].split('|')[0],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13.0,
                                  ),
                                ),
                                onTap: () {
                                  print(calendarioReservasController.events);
                                },
                              ),
                            )),
                  ],
                );
        },
      ),
    );
  }
}
