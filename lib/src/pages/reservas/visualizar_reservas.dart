import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:condosocio/src/controllers/reservas/detalhes_reservas_controller.dart';
import 'package:condosocio/src/controllers/reservas/reservas_controller.dart';
import 'package:condosocio/src/controllers/reservas/visualizar_reservas_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class VisualizarReservas extends StatelessWidget {
  final VisualizarReservasController visualizarReservasController =
      Get.put(VisualizarReservasController());
  final LoginController loginController = Get.put(LoginController());
  final DetalhesReservasController detalhesReservasController =
      Get.put(DetalhesReservasController());
  final ReservasController reservasController = Get.put(ReservasController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return visualizarReservasController.isLoading.value
          ? CircularProgressIndicatorWidget()
          : visualizarReservasController.reservas.isEmpty
              ? LayoutBuilder(
                  builder: (context, constraints) {
                    final textColor =
                        Theme.of(context).textSelectionTheme.selectionColor!;
                    return Center(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: constraints.maxWidth * 0.72,
                                maxHeight: constraints.maxHeight * 0.48,
                              ),
                              child: Image.asset(
                                'images/semregistro.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 16,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withValues(alpha: 0.42),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.10),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    'Nenhuma reserva encontrada',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: textColor,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Quando houver reservas cadastradas, elas aparecerão aqui.',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      height: 1.45,
                                      color: textColor.withValues(alpha: 0.78),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : Container(
                  padding: EdgeInsets.only(top: 20),
                  child: ListView.builder(
                      itemCount: visualizarReservasController.reservas.length,
                      itemBuilder: (_, i) {
                        var reservas = visualizarReservasController.reservas[i];

                        var data = reservas.dataAgenda;
                        var newData = data.split('-');

                        var before = visualizarReservasController.data.isBefore(
                            DateTime.parse(
                                '${reservas.dataAgenda} ${reservas.horaAgenda}'));

                        return GestureDetector(
                          onTap: () {
                            detalhesReservasController.idEve.value =
                                reservas.idevento;
                            detalhesReservasController.validaUsu.value = 1;
                            reservasController.nome.value = reservas.areacom;
                            reservasController.termo.value = reservas.termo;
                            detalhesReservasController.goToDetails(
                              '${loginController.nome.value} ${loginController.sobrenome.value}',
                              loginController.unidade.value,
                              reservas.titulo,
                              reservas.dataAgenda,
                              reservas.areacom,
                              reservas.status,
                              reservas.horaAgenda,
                              reservas.resposta,
                            );
                          },
                          child: before
                              ? Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    color: reservas.status == 'Aprovado'
                                        ? Colors.green[400]
                                        : reservas.status == 'Recusado'
                                            ? Colors.red[300]
                                            : Colors.amber,
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 4.0),
                                  child: ListTile(
                                    trailing: Icon(
                                      Icons.arrow_right_outlined,
                                      color: Colors.black,
                                    ),
                                    title: Container(
                                      padding: EdgeInsets.only(
                                        top: 5,
                                      ),
                                      child: Text(
                                        reservas.titulo,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    subtitle: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Container(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 5),
                                          child: Text(
                                            reservas.areacom,
                                            style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                            bottom: 5,
                                          ),
                                          child: Text(
                                            '${reservas.semana}, ${newData[2]}/${newData[1]}/${newData[0]} às ${reservas.horaAgenda}h',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 4.0),
                                  child: ListTile(
                                    trailing: Icon(
                                      Icons.arrow_right_outlined,
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor!,
                                    ),
                                    title: Container(
                                      padding: EdgeInsets.only(
                                        top: 5,
                                      ),
                                      child: Text(
                                        reservas.titulo,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor!,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    subtitle: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Container(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 5),
                                          child: Text(
                                            reservas.areacom,
                                            style: GoogleFonts.montserrat(
                                              fontSize: 10,
                                              color: Theme.of(context)
                                                  .textSelectionTheme
                                                  .selectionColor!,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                            bottom: 5,
                                          ),
                                          child: Text(
                                            '${reservas.semana}, ${newData[2]}/${newData[1]}/${newData[0]} às ${reservas.horaAgenda}h',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 10,
                                              color: Theme.of(context)
                                                  .textSelectionTheme
                                                  .selectionColor!,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                        );
                      }),
                );
    });
  }
}
