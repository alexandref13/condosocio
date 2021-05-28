import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/controllers/encomendas_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Encomendas extends StatelessWidget {
  final EncomendasController encomendasController =
      Get.put(EncomendasController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Encomendas',
        style: GoogleFonts.montserrat(
          fontSize: 16,
          color: Theme.of(context).textSelectionTheme.selectionColor,
        ),
      )),
      body: Obx(
        () {
          return encomendasController.isLoading.value
              ? CircularProgressIndicatorWidget()
              : Container(
                  child: ListView.builder(
                    itemCount: encomendasController.encomendas.length,
                    itemBuilder: (_, i) {
                      var encomenda = encomendasController.encomendas[i];
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              encomendasController.id.value = encomenda.idenc;
                              encomendasController.codigo.value =
                                  encomenda.codigo;
                              encomendasController.tipo.value = encomenda.tipo;
                              encomendasController.info.value = encomenda.info;
                              encomendasController.status.value =
                                  encomenda.status;
                              encomendasController.morador.value =
                                  encomenda.morador;
                              encomendasController.admCriador.value =
                                  encomenda.admCriador;
                              encomendasController.dataCriada.value =
                                  encomenda.dataCriada;
                              encomendasController.admEntrega.value =
                                  encomenda.admEntrega;
                              encomendasController.dataEntrega.value =
                                  encomenda.dataEntrega;

                              Get.toNamed('/detalhesEncomendas');
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color: Theme.of(context).accentColor,
                              child: ListTile(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      encomenda.codigo,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      encomenda.dataCriada,
                                      style: GoogleFonts.montserrat(
                                        fontSize: 14,
                                        color: Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor,
                                      ),
                                    ),
                                  ],
                                ),
                                subtitle: Text(
                                  encomenda.tipo,
                                  style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                trailing: Icon(
                                  Icons.arrow_right,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor,
                                  size: 30,
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                );
        },
      ),
    );
  }
}
