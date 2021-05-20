import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/controllers/reservas/add_reservas_controller.dart';
import 'package:condosocio/src/controllers/reservas/calendario_reservas_controller.dart';
import 'package:condosocio/src/services/reservas/mapa_eventos.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Obx(
        () {
          return calendarioReservasController.isLoading.value
              ? CircularProgressIndicatorWidget()
              : Column(
                  children: [
                    TableCalendar(
                      locale: 'pt_BR',
                      firstDay: DateTime(1990),
                      lastDay: DateTime(2100),
                      focusedDay: calendarioReservasController.focusedDay.value,
                      availableGestures: AvailableGestures.all,
                      startingDayOfWeek: StartingDayOfWeek.sunday,
                      daysOfWeekVisible: true,
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
                        if (!isSameDay(selectedDay,
                            calendarioReservasController.selectedDay.value)) {
                          calendarioReservasController.selectedDay.value =
                              selectedDay;
                          calendarioReservasController.focusedDay.value =
                              focusedDay;

                          print(calendarioReservasController.focusedDay.value);
                        }
                      },
                      selectedDayPredicate: (DateTime date) {
                        return isSameDay(
                            calendarioReservasController.selectedDay.value,
                            date);
                      },
                    ),
                    IconButton(
                      onPressed: () {
                        print(calendarioReservasController.events);
                      },
                      icon: Icon(Icons.add),
                    )
                  ],
                );
        },
      ),
    );
  }
}

// Widget buildTableCalendarWithBuilders() {

// }
