import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/controllers/reservas/reservas_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AreasComuns extends StatelessWidget {
  final ReservasController reservasController = Get.put(ReservasController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (reservasController.isLoading.value) {
          return CircularProgressIndicatorWidget();
        }

        if (reservasController.areas.isEmpty) {
          return LayoutBuilder(
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
                              'Nenhuma área comum cadastrada',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: textColor,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'O condomínio não cadastrou as áreas comuns para reservas. Para maiores informações, entre em contato com a administração.',
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
          );
        }

        return Container(
                padding: EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Expanded(
                      child: SmartRefresher(
                        controller: reservasController.refreshController,
                        onRefresh: reservasController.onRefresh,
                        onLoading: reservasController.onLoading,
                        child: ListView.builder(
                          itemCount: reservasController.areas.length,
                          itemBuilder: (_, i) {
                            var areas = reservasController.areas[i];
                            return GestureDetector(
                              onTap: () {
                                reservasController.termo.value = areas.termo;
                                reservasController.nome.value = areas.nome;
                                reservasController.idarea.value = areas.idarea;
                                reservasController.aprova.value = areas.aprova;
                                reservasController.multi.value = areas.multi;
                                reservasController.lastTime.value =
                                    areas.lastTime;
                                Get.toNamed('/calendario');
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                color: Theme.of(context).colorScheme.secondary,
                                child: ListTile(
                                    leading: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          areas.tipo == 'CHURRASQUEIRA'
                                              ? Icons.store_mall_directory
                                              : areas.tipo ==
                                                      'QUADRA DE FUTEBOL'
                                                  ? Icons.sports_soccer
                                                  : areas.tipo ==
                                                          'QUADRA DE TÊNIS'
                                                      ? Icons.sports_tennis
                                                      : areas.tipo ==
                                                              'QUADRA DE VOLEY'
                                                          ? Icons
                                                              .sports_volleyball
                                                          : areas.tipo ==
                                                                  'QUADRA POLIESPORTIVA'
                                                              ? Icons
                                                                  .sports_basketball
                                                              : areas.tipo ==
                                                                      'QUIOSQUE'
                                                                  ? Icons
                                                                      .local_dining
                                                                  : areas.tipo ==
                                                                          'SALÃO DE FESTA'
                                                                      ? Icons
                                                                          .cake
                                                                      : areas.tipo ==
                                                                              'SALÃO GOURMET'
                                                                          ? Icons
                                                                              .local_bar
                                                                          : Icons
                                                                              .person,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor!,
                                          size: 30,
                                        ),
                                      ],
                                    ),
                                    title: Padding(
                                      padding: EdgeInsets.only(left: 30),
                                      child: Text(
                                        areas.nome,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor!,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    subtitle: areas.qtdMaxConvidados != '0'
                                        ? Container(
                                            margin: EdgeInsets.only(left: 30),
                                            child: Text(
                                              'Qdt max de convidados: ${areas.qtdMaxConvidados}',
                                              style: GoogleFonts.montserrat(
                                                fontSize: 12,
                                                color: Theme.of(context)
                                                    .textSelectionTheme
                                                    .selectionColor!,
                                              ),
                                            ),
                                          )
                                        : Container(),
                                    trailing: Icon(
                                      Icons.arrow_right,
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor!,
                                      size: 30,
                                    )),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }
}
