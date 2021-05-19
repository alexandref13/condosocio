import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarioReservasController extends GetxController {
  var isLoading = false.obs;

  CalendarFormat calendarController = CalendarFormat.month;
  var focusedDay = DateTime.now().obs;
  var selectedDay = DateTime.now().obs;

  @override
  void onInit() {
    super.onInit();
  }
}
