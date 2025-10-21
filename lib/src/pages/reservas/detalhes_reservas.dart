import 'package:condosocio/src/components/utils/alert_button_pressed.dart';
import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/components/utils/confirmed_button_pressed.dart';
import 'package:condosocio/src/components/utils/animated_dialog.dart'; // <- usa showScaledDialog
import 'package:condosocio/src/controllers/reservas/add_reservas_controller.dart';
import 'package:condosocio/src/controllers/reservas/detalhes_reservas_controller.dart';
import 'package:condosocio/src/controllers/reservas/reservas_controller.dart';
import 'package:condosocio/src/controllers/reservas/visualizar_reservas_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../components/utils/delete_alert.dart';

class DetalhesReservas extends StatelessWidget {
  final VisualizarReservasController visualizarReservasController =
      Get.put(VisualizarReservasController());
  final DetalhesReservasController detalhesReservasController =
      Get.put(DetalhesReservasController());
  final ReservasController reservasController = Get.put(ReservasController());
  final AddReservasController addReservasController =
      Get.put(AddReservasController());

  DetalhesReservas({super.key});

  @override
  Widget build(BuildContext context) {
    void confirmDelete(String text, VoidCallback onOk) {
      showScaledDialog(
        context: context,
        barrierDismissible: false,
        transitionDuration: const Duration(milliseconds: 500),
        builder: (BuildContext context) {
          final theme = Theme.of(context);
          final bg = theme.textSelectionTheme.selectionColor ?? Colors.white;

          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            backgroundColor: bg,
            content: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.warning, color: Colors.orange, size: 54),
                  const SizedBox(height: 10),
                  Text(
                    text,
                    style: GoogleFonts.poppins(
                      color: theme.primaryColor,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text(
                  "Cancelar",
                  style: GoogleFonts.montserrat(
                    color: theme.colorScheme.error,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                child: Text(
                  "OK",
                  style: GoogleFonts.montserrat(
                    color: theme.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // fecha o diálogo
                  onOk(); // executa ação
                },
              ),
            ],
          );
        },
      );
    }

    final day = DateTime.parse(detalhesReservasController.data.value);
    final newDate = DateFormat.yMMMMd('pt').format(day);

    final same = isSameDay(visualizarReservasController.dataDetalhes, day);
    final isBefore = visualizarReservasController.dataDetalhes.isBefore(day);

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(
          'Reservas',
          style: GoogleFonts.montserrat(
            fontSize: 16,
            color: Theme.of(context).textSelectionTheme.selectionColor!,
          ),
        ),
      ),
      body: Obx(() {
        return detalhesReservasController.isLoading.value
            ? const CircularProgressIndicatorWidget()
            : SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * .33,
                        width: MediaQuery.of(context).size.width * .9,
                        child: Card(
                          color: detalhesReservasController.status.value ==
                                  'Aprovado'
                              ? Colors.green[400]
                              : detalhesReservasController.status.value ==
                                      'Recusado'
                                  ? Colors.red[300]
                                  : Colors.amber,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text(
                                        detalhesReservasController.nome.value,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(top: 3),
                                      child: Text(
                                        detalhesReservasController
                                            .unidade.value,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              _kvRow('EVENTO: ',
                                  detalhesReservasController.titulo.value),
                              _kvRow('DATA: ',
                                  '$newDate às ${detalhesReservasController.hora.value}'),
                              _kvRow('ÁREA COMUM: ',
                                  detalhesReservasController.areacom.value),
                              _kvRow('STATUS: ',
                                  detalhesReservasController.status.value),
                              if (detalhesReservasController.status.value ==
                                  "Recusado")
                                _kvRow('MOTIVO: ',
                                    detalhesReservasController.respevent.value),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Botão Termo
                    if (reservasController.termo.value != '')
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 25),
                        child: SizedBox(
                          height: 50.0,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                      (_) => Colors.white),
                              shape: MaterialStateProperty.resolveWith<
                                  OutlinedBorder>(
                                (_) => RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                            onPressed: () => Get.toNamed('/termos'),
                            child: Text(
                              "Leia o Termo de Uso ${reservasController.nome.value}",
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),

                    // Botão Cancelar (condicional)
                    if (!same &&
                        isBefore &&
                        detalhesReservasController.validaUsu.value != 0)
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 25),
                        child: SizedBox(
                          height: 50.0,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (_) => Theme.of(context).colorScheme.error,
                              ),
                              shape: MaterialStateProperty.resolveWith<
                                  OutlinedBorder>(
                                (_) => RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                            onPressed: () {
                              deleteAlert(
                                context,
                                'Deseja excluir a reserva\n ${detalhesReservasController.titulo.value}?',
                                () {
                                  detalhesReservasController
                                      .deleteReserva()
                                      .then((value) {
                                    if (value == 1) {
                                      confirmedButtonPressed(
                                        context,
                                        'Sua reserva foi cancelada com sucesso',
                                        '/home',
                                      );
                                    } else {
                                      onAlertButtonPressed(
                                        context,
                                        'Algo deu errado \n Tente novamente mais tarde',
                                        '/home',
                                        'images/error.png',
                                      );
                                    }
                                  });
                                },
                              );
                              // Alternativa usando o confirmDelete local (com a mesma UX):
                              // confirmDelete('Deseja excluir a reserva\n ${detalhesReservasController.titulo.value}?', () { ... });
                            },
                            child: Text(
                              "Cancelar",
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor!,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
      }),
    );
  }

  // helper para reduzir repetição de linhas chave/valor
  Widget _kvRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      child: Row(
        children: [
          Text(
            label,
            style: GoogleFonts.montserrat(
              fontSize: 12,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Flexible(
            child: Text(
              value,
              style: GoogleFonts.montserrat(
                fontSize: 12,
                color: Colors.black,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
