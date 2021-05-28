import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/controllers/acheAqui/pesquisa_ache_aqui_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PesquisaAcheAqui extends StatelessWidget {
  const PesquisaAcheAqui({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PesquisaAcheAquiController pesquisaAcheAquiController =
        Get.put(PesquisaAcheAquiController());
    return Obx(
      () {
        return pesquisaAcheAquiController.isLoading.value
            ? CircularProgressIndicatorWidget()
            : Container(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(5, 15, 5, 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: TextField(
                              controller:
                                  pesquisaAcheAquiController.pesquisa.value,
                              style: GoogleFonts.montserrat(
                                fontSize: 16,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                              ),
                              decoration: InputDecoration(
                                labelText: "Pesquise pelo nome ...",
                                labelStyle: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor,
                                ),
                                isDense: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
                                    width: 1,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                            height: 50,
                            child: ButtonTheme(
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
                                  pesquisaAcheAquiController.acheAquiPesquisa();
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
                    ),
                    Expanded(
                      child: Container(
                        child: ListView.builder(
                          itemBuilder: (_, i) {
                            return Container();
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
