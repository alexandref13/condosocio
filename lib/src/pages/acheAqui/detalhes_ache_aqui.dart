import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/controllers/acheAqui/ache_aqui_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DetalhesAcheAqui extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AcheAquiController acheAquiController = Get.put(AcheAquiController());

    return Obx(
      () {
        return acheAquiController.isLoading.value
            ? CircularProgressIndicatorWidget()
            : Container(
                child: ListView.builder(
                  itemCount: acheAquiController.acheAquiDetalhes.length,
                  itemBuilder: (_, i) {
                    var detalhes = acheAquiController.acheAquiDetalhes[i];

                    acheAquiController.cel.value = detalhes.cel;
                    acheAquiController.email.value = detalhes.email;
                    acheAquiController.site.value = detalhes.site;
                    acheAquiController.endereco.value = detalhes.endereco;

                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: NetworkImage(
                                      'https://condosocio.com.br/acond/downloads/logofornecedores/${detalhes.imgforn}'),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                              detalhes.fantasia,
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Center(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                detalhes.atividades,
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            child: Text(
                              detalhes.endereco,
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                              ),
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(detalhes.mediaAvaliacoes),
                                Container(
                                  padding: EdgeInsets.only(left: 4, bottom: 3),
                                  child: Icon(
                                    Icons.star,
                                    color: Colors.black,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(bottom: 3),
                                  child: Text(
                                    ' | ',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 18,
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(bottom: 3),
                                  child: Text(
                                    '${detalhes.qtdAvaliacoes} Avaliações',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
      },
    );
  }
}
