import 'package:condosocio/src/services/reservas/mapa_eventos.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:convert';
import 'package:condosocio/src/services/reservas/api_reservas.dart';
import 'package:intl/intl.dart';

class CalendarioReservasController extends GetxController {
  var isLoading = true.obs;

  var onSelected = false.obs;

  Map<DateTime, List<MapaEvento>> events = {};
  late List<dynamic> selectedEvents;

  CalendarFormat calendarFormat = CalendarFormat.month;
  DateTime now = DateTime.now();
  DateTime? day;
  var focusedDay = DateTime.now().obs;
  var selectedDay = DateTime.now().obs;

  List<MapaEvento> getEventsfromDay(DateTime date) {
    return events[date] ?? [];
  }

  agendaReservas() async {
    isLoading(true);

    var response = await ApiReservas.agendaReservas();

    var dados = json.decode(response.body);

    if (dados != 0) {
      for (var eventos in dados['dados']) {
        events
            .putIfAbsent(
                DateTime.parse('${eventos['data_agenda']} 00:00:00.000Z'),
                () => [])
            .add(
              MapaEvento(
                dataAgenda: eventos['data_agenda'] ?? '',
                descricao: eventos['descricao'] ?? '',
                idevento: eventos['idevento'] ?? '',
                img: eventos['img'] ?? '',
                nome: eventos['nome'] ?? '',
                areacom: eventos['areacom'] ?? '',
                respevent: eventos['respevent'] ?? '',
                status: eventos['status'] ?? '',
                titulo: eventos['titulo'] ?? '',
                unidade: eventos['unidade'] ?? '',
                horaAgenda: eventos['hora_agenda'] ?? '',
                validausu: eventos['validausu'] ??
                    0, // Ajuste para um valor numérico padrão, se necessário
                ctl: '',
              ),
            );
      }
    }

    isLoading(false);
  }

  init() {
    var date = DateFormat('yyyy-MM-dd').format(selectedDay.value);

    var newSelectedDay = DateTime.parse('$date 00:00:00.000Z');

    selectedDay.value = newSelectedDay;

    day = DateTime(now.year, now.month, now.day - 1);
  }

  @override
  void onInit() {
    init();
    agendaReservas();
    super.onInit();
  }
}
