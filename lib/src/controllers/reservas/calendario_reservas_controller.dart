import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarioReservasController extends GetxController {
  var isLoading = false.obs;

  Map<DateTime, List<dynamic>> events = {};
  List<dynamic> selectedEvents;

  CalendarFormat calendarFormat = CalendarFormat.month;
  var focusedDay = DateTime.now().obs;
  var selectedDay = DateTime.now().obs;

  List<dynamic> getEventsfromDay(DateTime date) {
    return events[date] ?? [];
  }
}
