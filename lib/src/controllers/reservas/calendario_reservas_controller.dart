import 'package:condosocio/src/services/reservas/mapa_eventos.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:convert';
import 'package:condosocio/src/services/reservas/api_reservas.dart';

class CalendarioReservasController extends GetxController {
  var isLoading = true.obs;

  var nome = ''.obs;
  var unidade = ''.obs;
  var data = ''.obs;
  var titulo = ''.obs;
  var area = ''.obs;
  var status = ''.obs;

  Map<DateTime, List<MapaEvento>> events = {};
  List<dynamic> selectedEvents;

  CalendarFormat calendarFormat = CalendarFormat.month;
  var focusedDay = DateTime.now().obs;
  var selectedDay = DateTime.now().obs;

  List<MapaEvento> getEventsfromDay(DateTime date) {
    return events[date] ?? [];
  }

  agendaReservas() async {
    isLoading(true);

    var response = await ApiReservas.agendaReservas();

    var dados = json.decode(response.body);

    print(dados['dados']);

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
  ) {
    nome(newNome);
    unidade(newUnidade);
    data(newData);
    titulo(newTitulo);
    area(newArea);
    status(newStatus);

    Get.toNamed('/detalheReservas');
  }

  @override
  void onInit() {
    agendaReservas();
    super.onInit();
  }
}

// "${eventos['idevento']} - ${eventos['nome']} | ${eventos['data_agenda']} = ${eventos['titulo']} # ${eventos['areacom']} > ${eventos['status']}"
