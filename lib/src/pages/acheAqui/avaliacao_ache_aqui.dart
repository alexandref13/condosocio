import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/controllers/acheAqui/detalhes_ache_aqui_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AvaliacaoAcheAqui extends StatelessWidget {
  const AvaliacaoAcheAqui({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DetalhesAcheAquiController detalhesAcheAquiController =
        Get.put(DetalhesAcheAquiController());

    return Obx(
      () {
        return detalhesAcheAquiController.isLoading.value
            ? CircularProgressIndicatorWidget()
            : Container(
                padding: EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        child: ListView.builder(
                          itemCount:
                              detalhesAcheAquiController.avaliacao.length,
                          itemBuilder: (_, i) {
                            var avaliacao =
                                detalhesAcheAquiController.avaliacao[i];
                            return Container(
                              padding: EdgeInsets.only(left: 5),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                color: Theme.of(context).accentColor,
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.fromLTRB(7, 5, 7, 0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .5,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        '${avaliacao.usuario} | ${avaliacao.estrelas}',
                                                        style: GoogleFonts
                                                            .montserrat(
                                                          fontSize: 12,
                                                          color: Theme.of(
                                                                  context)
                                                              .textSelectionTheme
                                                              .selectionColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Icon(Icons.star, size: 14)
                                                    ],
                                                  )),
                                              Text(
                                                avaliacao.data,
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 10,
                                                  color: Theme.of(context)
                                                      .textSelectionTheme
                                                      .selectionColor,
                                                ),
                                              )
                                            ],
                                          ),
                                          Container(
                                            child: Text(
                                              avaliacao.condominio,
                                              style: GoogleFonts.montserrat(
                                                fontSize: 10,
                                                color: Theme.of(context)
                                                    .textSelectionTheme
                                                    .selectionColor,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      width: MediaQuery.of(context).size.width *
                                          .9,
                                      child: Text(
                                        avaliacao.comentario,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              );
      },
    );
  }
}
