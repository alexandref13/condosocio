import 'package:condosocio/src/services/reservas/mapa_eventos.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:convert';
import 'package:condosocio/src/services/reservas/api_reservas.dart';
import 'package:intl/intl.dart';

class CalendarioReservasController extends GetxController {
  var isLoading = true.obs;

  var nome = ''.obs;
  var unidade = ''.obs;
  var data = ''.obs;
  var titulo = ''.obs;
  var area = ''.obs;
  var status = ''.obs;
  var hora = ''.obs;
  var respevent = ''.obs;
  var idarea = ''.obs;

  var onSelected = false.obs;

  Map<DateTime, List<MapaEvento>> events = {};
  List<dynamic> selectedEvents;

  CalendarFormat calendarFormat = CalendarFormat.month;
  DateTime now = DateTime.now();
  DateTime day;
  var focusedDay = DateTime.now().obs;
  var selectedDay = DateTime.now().obs;

  List<MapaEvento> getEventsfromDay(DateTime date) {
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
              MapaEvento(
                areacom: eventos['areacom'],
                dataAgenda: eventos['data_agenda'],
                descricao: eventos['descricao'],
                idevento: eventos['idevento'],
                img: eventos['img'],
                nome: eventos['nome'],
                respevent: eventos['respevent'],
                status: eventos['status'],
                titulo: eventos['titulo'],
                unidade: eventos['unidade'],
                horaAgenda: eventos['hora_agenda'],
                validausu: eventos['validausu'],
              ),
            );
      }
    }

    isLoading(false);
  }

  goToDetails(
    String newNome,
    String newUnidade,
    String newTitulo,
    String newData,
    String newArea,
    String newStatus,
    String newHora,
    String newResp,
  ) {
    nome(newNome);
    unidade(newUnidade);
    data(newData);
    titulo(newTitulo);
    area(newArea);
    status(newStatus);
    hora(newHora);
    respevent(newResp);

    Get.toNamed('/detalheReservas');
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
