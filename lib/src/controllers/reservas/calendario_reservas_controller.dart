import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:convert';
import 'package:condosocio/src/services/reservas/api_reservas.dart';

class CalendarioReservasController extends GetxController {
  var isLoading = true.obs;

  Map<DateTime, List<dynamic>> events = {};
  List<dynamic> selectedEvents;

  CalendarFormat calendarFormat = CalendarFormat.month;
  var focusedDay = DateTime.now().obs;
  var selectedDay = DateTime.now().obs;

  List<dynamic> getEventsfromDay(DateTime date) {
    return events[date] ?? [];
  }

  agendaReservas() async {
    isLoading(true);

    var response = await ApiReservas.agendaReservas();

    var dados = json.decode(response.body);

    if (dados['dados'] != null) {
      for (var eventos in dados['dados']) {
        events
            .putIfAbsent(
                DateTime.parse('${eventos['data_agenda']} 00:00:00.000Z'),
                () => [])
            .add(
                "${eventos['idevento']} - ${eventos['nome']} | ${eventos['data_agenda']} = ${eventos['titulo']} # ${eventos['areacom']} > ${eventos['status']}");
      }
    }

    isLoading(false);
  }

  @override
  void onInit() {
    agendaReservas();
    super.onInit();
  }
}
