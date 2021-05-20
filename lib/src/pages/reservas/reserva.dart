import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/controllers/reservas/reservas_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Reserva extends StatelessWidget {
  final ReservasController reservasController = Get.put(ReservasController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reservas',
          style: GoogleFonts.montserrat(
            fontSize: 16,
            color: Theme.of(context).textSelectionTheme.selectionColor,
          ),
        ),
      ),
      body: Obx(
        () {
          return reservasController.isLoading.value
              ? CircularProgressIndicatorWidget()
              : Container(
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
                                  reservasController.nome.value = areas.nome;
                                  Get.toNamed('/calendario');
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  color: Theme.of(context).accentColor,
                                  child: ListTile(
                                      leading: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.store_mall_directory,
                                            color: Theme.of(context)
                                                .textSelectionTheme
                                                .selectionColor,
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
                                                .selectionColor,
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
                                                      .selectionColor,
                                                ),
                                              ),
                                            )
                                          : Container(),
                                      trailing: Icon(
                                        Icons.arrow_right,
                                        color: Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor,
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
      ),
    );
  }
}
