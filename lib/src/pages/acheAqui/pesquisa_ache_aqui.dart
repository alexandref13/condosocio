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
                              textInputAction: TextInputAction.search,
                              onSubmitted: (value) {
                                pesquisaAcheAquiController.acheAquiPesquisa();
                              },
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
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    pesquisaAcheAquiController
                                        .pesquisa.value.text = '';
                                  },
                                  icon: Icon(
                                    Icons.close,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
                                    size: 12,
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
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: pesquisaAcheAquiController
                                        .listaPesquisa.length ==
                                    0 &&
                                pesquisaAcheAquiController.wasSearch.value ==
                                    true
                            ? Stack(
                                children: <Widget>[
                                  Container(
                                    child: Image.asset(
                                      'images/semregistro.png',
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                  Center(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(top: 100),
                                          //child: Icon(Icons.block, size: 34, color: Colors.red[900]),
                                        ),
                                        Text(
                                          'Sem registros',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 14.0,
                                            color: Theme.of(context)
                                                .textSelectionTheme
                                                .selectionColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )
                            : ListView.builder(
                                itemCount: pesquisaAcheAquiController
                                    .listaPesquisa.length,
                                itemBuilder: (_, i) {
                                  var pesquisa = pesquisaAcheAquiController
                                      .listaPesquisa[i];

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
                                              acheAquiController
                                                  .getAcheAquiForm();
                                            }
                                          },
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            color:
                                                Theme.of(context).accentColor,
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
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              leading: pesquisa.imgforn != ''
                                                  ? Container(
                                                      width: 50,
                                                      height: 50,
                                                      child: Image(
                                                        image: NetworkImage(
                                                            'https://alvocomtec.com.br/acond/downloads/logofornecedores/${pesquisa.imgforn}'),
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
