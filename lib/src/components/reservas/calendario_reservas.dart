import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/controllers/reservas/add_reservas_controller.dart';
import 'package:condosocio/src/controllers/reservas/calendario_reservas_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class TableCalendarWidget extends StatelessWidget {
  const TableCalendarWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AddReservasController addReservasController =
        Get.put(AddReservasController());
    CalendarioReservasController calendarioReservasController =
        Get.put(CalendarioReservasController());

    return Scaffold(
        appBar: AppBar(),
        body: Obx(() {
          return calendarioReservasController.isLoading.value
              ? CircularProgressIndicatorWidget()
              : TableCalendar(
                  locale: 'pt_BR',
                  firstDay: DateTime.now(),
                  lastDay: DateTime(2100),
                  focusedDay: calendarioReservasController.focusedDay.value,
                  calendarStyle: CalendarStyle(
                    outsideDaysVisible: false,
                    weekendTextStyle:
                        TextStyle(color: Theme.of(context).errorColor),
                    holidayTextStyle: TextStyle(color: Colors.green),
                  ),
                  calendarFormat:
                      calendarioReservasController.calendarController,
                  onDaySelected: (selectedDay, focusedDay) {
                    if (!isSameDay(
                        calendarioReservasController.selectedDay.value,
                        selectedDay)) {
                      calendarioReservasController.selectedDay.value =
                          selectedDay;
                      calendarioReservasController.focusedDay.value =
                          focusedDay;
                    }
                  },
                  onPageChanged: (focusedDay) {
                    calendarioReservasController.focusedDay.value = focusedDay;
                  },
                );
        }));
  }
}

// Widget buildTableCalendarWithBuilders() {

// }
