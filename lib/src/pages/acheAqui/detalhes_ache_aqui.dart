import 'package:condosocio/src/components/utils/alert_button_pressed.dart';
import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/components/utils/confirmed_button_pressed.dart';
import 'package:condosocio/src/components/utils/custom_text_field.dart';
import 'package:condosocio/src/controllers/acheAqui/ache_aqui_controller.dart';
import 'package:condosocio/src/controllers/acheAqui/detalhes_ache_aqui_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DetalhesAcheAqui extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AcheAquiController acheAquiController = Get.put(AcheAquiController());
    DetalhesAcheAquiController detalhesAcheAquiController =
        Get.put(DetalhesAcheAquiController());

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
                          Container(
                            padding: EdgeInsets.only(top: 40),
                            child: Text(
                              'Avalie esta empresa',
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            child: Obx(
                              () {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        detalhesAcheAquiController.star1.value =
                                            true;
                                        detalhesAcheAquiController.star2.value =
                                            false;
                                        detalhesAcheAquiController.star3.value =
                                            false;
                                        detalhesAcheAquiController.star4.value =
                                            false;
                                        detalhesAcheAquiController.star5.value =
                                            false;
                                        detalhesAcheAquiController.star.value =
                                            1;
                                      },
                                      icon: Icon(
                                          detalhesAcheAquiController.star1.value
                                              ? Icons.star
                                              : Icons.star_border_outlined),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        detalhesAcheAquiController.star1.value =
                                            true;
                                        detalhesAcheAquiController.star2.value =
                                            true;
                                        detalhesAcheAquiController.star3.value =
                                            false;
                                        detalhesAcheAquiController.star4.value =
                                            false;
                                        detalhesAcheAquiController.star5.value =
                                            false;
                                        detalhesAcheAquiController.star.value =
                                            2;
                                      },
                                      icon: Icon(
                                          detalhesAcheAquiController.star2.value
                                              ? Icons.star
                                              : Icons.star_border_outlined),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        detalhesAcheAquiController.star1.value =
                                            true;
                                        detalhesAcheAquiController.star2.value =
                                            true;
                                        detalhesAcheAquiController.star3.value =
                                            true;
                                        detalhesAcheAquiController.star4.value =
                                            false;
                                        detalhesAcheAquiController.star5.value =
                                            false;
                                        detalhesAcheAquiController.star.value =
                                            3;
                                      },
                                      icon: Icon(
                                        detalhesAcheAquiController.star3.value
                                            ? Icons.star
                                            : Icons.star_border_outlined,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        detalhesAcheAquiController.star1.value =
                                            true;
                                        detalhesAcheAquiController.star2.value =
                                            true;
                                        detalhesAcheAquiController.star3.value =
                                            true;
                                        detalhesAcheAquiController.star4.value =
                                            true;
                                        detalhesAcheAquiController.star5.value =
                                            false;
                                        detalhesAcheAquiController.star.value =
                                            4;
                                      },
                                      icon: Icon(
                                        detalhesAcheAquiController.star4.value
                                            ? Icons.star
                                            : Icons.star_border_outlined,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        detalhesAcheAquiController.star1.value =
                                            true;
                                        detalhesAcheAquiController.star2.value =
                                            true;
                                        detalhesAcheAquiController.star3.value =
                                            true;
                                        detalhesAcheAquiController.star4.value =
                                            true;
                                        detalhesAcheAquiController.star5.value =
                                            true;
                                        detalhesAcheAquiController.star.value =
                                            5;
                                      },
                                      icon: Icon(
                                          detalhesAcheAquiController.star5.value
                                              ? Icons.star
                                              : Icons.star_border_outlined),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            child: Obx(
                              () {
                                return customTextField(
                                  context,
                                  'Comente',
                                  null,
                                  true,
                                  3,
                                  true,
                                  detalhesAcheAquiController.comentario.value,
                                );
                              },
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            child: ButtonTheme(
                              height: 50.0,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                      return Theme.of(context).accentColor;
                                    },
                                  ),
                                  elevation:
                                      MaterialStateProperty.resolveWith<double>(
                                          (Set<MaterialState> states) {
                                    return 3;
                                  }),
                                  shape: MaterialStateProperty.resolveWith<
                                      OutlinedBorder>(
                                    (Set<MaterialState> states) {
                                      return RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      );
                                    },
                                  ),
                                ),
                                onPressed: () {
                                  detalhesAcheAquiController
                                      .sendAcheAquiAvaliacao()
                                      .then((value) {
                                    if (value == 1) {
                                      confirmedButtonPressed(
                                          context,
                                          'Sua avaliação foi enviada com sucesso! Grato pela sua colaboração.',
                                          null);
                                    } else if (value == 2) {
                                      confirmedButtonPressed(
                                          context,
                                          "Sua avaliação para essa empresa foi atualizada com sucesso!",
                                          null);
                                    } else {
                                      onAlertButtonPressed(
                                          context,
                                          'Algo deu errado\n Tente novamente',
                                          '/acheAqui');
                                    }
                                  });
                                },
                                child: Text(
                                  "ENVIAR",
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
                                  ),
                                ),
                              ),
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
