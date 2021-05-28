import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/controllers/acheAqui/ache_aqui_controller.dart';
import 'package:condosocio/src/controllers/acheAqui/pesquisa_ache_aqui_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PesquisaAcheAqui extends StatelessWidget {
  final PesquisaAcheAquiController pesquisaAcheAquiController =
      Get.put(PesquisaAcheAquiController());
  final AcheAquiController acheAquiController = Get.put(AcheAquiController());

  @override
  Widget build(BuildContext context) {
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
                                labelText: "Pesquise pela empresa ou atividade",
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
                          itemCount:
                              pesquisaAcheAquiController.listaPesquisa.length,
                          itemBuilder: (_, i) {
                            var pesquisa =
                                pesquisaAcheAquiController.listaPesquisa[i];

                            return Container(
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if (pesquisa.tipo == 'empresa') {
                                        acheAquiController.idForm.value =
                                            pesquisa.id;
                                        acheAquiController
                                            .getAcheAquiDetalhes();
                                      } else {
                                        acheAquiController.id.value =
                                            pesquisa.id;
                                        acheAquiController.getAcheAquiForm();
                                      }
                                    },
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      color: Theme.of(context).accentColor,
                                      child: ListTile(
                                        title: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15.0),
                                          child: Text(
                                            pesquisa.nome,
                                            style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                color: Theme.of(context)
                                                    .textSelectionTheme
                                                    .selectionColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        leading: pesquisa.imgforn != ''
                                            ? Container(
                                                width: 50,
                                                height: 50,
                                                child: Image(
                                                  image: NetworkImage(
                                                      'https://condosocio.com.br/acond/downloads/logofornecedores/${pesquisa.imgforn}'),
                                                ),
                                              )
                                            : null,
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
