import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/components/utils/progress_indicator_widget.dart';
import 'package:condosocio/src/controllers/enquetes/visualizar_enquetes_controller.dart';
import 'package:condosocio/src/controllers/enquetes/votar_enquete.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import '../../components/utils/alert_button_pressed.dart';
import '../../components/utils/edge_alert_error_widget.dart';
import '../../components/utils/edge_alert_widget.dart';

class VotarEnquete extends StatelessWidget {
  final VotarEnqueteController enquetesController =
      Get.put(VotarEnqueteController());
  final VisualizarEnquetesController visualizarEnquetesController =
      Get.put(VisualizarEnquetesController());
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    confirmedVote(String text, VoidCallback function) {
      showAnimatedDialog(
        context: context,
        barrierDismissible: false,
        animationType: DialogTransitionType.fadeScale,
        curve: Curves.fastOutSlowIn,
        duration: Duration(milliseconds: 500),
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            backgroundColor:
                Theme.of(context).textSelectionTheme.selectionColor,
            content: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.warning,
                    color: Colors.orange,
                    size: 54,
                  ),
                  SizedBox(height: 10),
                  Text(
                    text,
                    style: GoogleFonts.poppins(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text(
                  "Cancelar",
                  style: GoogleFonts.montserrat(
                      color: Theme.of(context).colorScheme.error,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text(
                  "OK",
                  style: GoogleFonts.montserrat(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                onPressed: function,
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Enquete',
          style: GoogleFonts.montserrat(
            fontSize: 16,
            color: Theme.of(context).textSelectionTheme.selectionColor!,
          ),
        ),
      ),
      body: Obx(() {
        return enquetesController.isLoading.value
            ? CircularProgressIndicatorWidget()
            : Container(
                child: ListView.builder(
                    itemCount: enquetesController.enquete.length,
                    itemBuilder: (_, index) {
                      var enquetes = enquetesController.enquete[index];

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            child: Padding(
                              padding: EdgeInsets.only(top: 0),
                              child: Container(
                                //color: Color(0xfff5f5f5),
                                child: Image.asset(
                                  'images/enquete.png',
                                  height: 340,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(10, 5, 10, 20),
                            child: Center(
                              child: Text(
                                visualizarEnquetesController.titulo.value,
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor!,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          for (var i = 0; i < enquetes.qdtperguntas; i++)
                            Container(
                              child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        enquetes.verificavoto == 'Não Votou' &&
                                                enquetes.valida ==
                                                    'Votação Aberta'
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  i == 0
                                                      ? Container()
                                                      : Text(
                                                          '${enquetes.perguntas[i]} (${enquetes.votacao[i]})',
                                                          style: GoogleFonts
                                                              .montserrat(
                                                            fontSize: 12,
                                                            color: Theme.of(
                                                                    context)
                                                                .textSelectionTheme
                                                                .selectionColor!,
                                                          ),
                                                        ),
                                                  i == 0
                                                      ? Container()
                                                      : Obx(
                                                          () => Radio(
                                                            value: i,
                                                            groupValue:
                                                                enquetesController
                                                                    .i.value,
                                                            onChanged: (value) {
                                                              enquetesController
                                                                      .i.value =
                                                                  value as int;
                                                            },
                                                            activeColor:
                                                                Colors.white,
                                                          ),
                                                        )
                                                ],
                                              )
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  i == 0
                                                      ? Container()
                                                      : Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 5),
                                                          child: Text(
                                                            '${enquetes.perguntas[i]} (${enquetes.votacao[i]})',
                                                            style: GoogleFonts
                                                                .montserrat(
                                                              fontSize: 10,
                                                              color: Theme.of(
                                                                      context)
                                                                  .textSelectionTheme
                                                                  .selectionColor!,
                                                            ),
                                                          ),
                                                        ),
                                                  i == 0
                                                      ? Container()
                                                      : Text(
                                                          enquetes.votacao[i] !=
                                                                  0
                                                              ? '${((enquetes.votacao[i] / enquetes.soma) * 100).toStringAsFixed(0)}%'
                                                              : '0%',
                                                          style: GoogleFonts
                                                              .montserrat(
                                                            fontSize: 10,
                                                            color: Theme.of(
                                                                    context)
                                                                .textSelectionTheme
                                                                .selectionColor!,
                                                          ),
                                                        )
                                                ],
                                              ),
                                        enquetes.verificavoto != 'Não Votou' ||
                                                enquetes.valida ==
                                                    'Votações Encerradas'
                                            ? Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    5, 8, 5, 8),
                                                height: 15,
                                                child: ProgressIndicatorWidget(
                                                  value: enquetes.votacao[i] !=
                                                          0
                                                      ? (enquetes.votacao[i] /
                                                          enquetes.soma)
                                                      : 0,
                                                ),
                                              )
                                            : Container(),
                                      ],
                                    )),
                              ),
                            ),
                          enquetes.verificavoto == 'Não Votou' &&
                                  enquetes.valida != 'Votações Encerradas'
                              ? Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: ButtonTheme(
                                    height: 50.0,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty
                                            .resolveWith<Color>(
                                          (Set<MaterialState> states) {
                                            return Theme.of(context)
                                                .colorScheme
                                                .secondary;
                                          },
                                        ),
                                        shape: MaterialStateProperty
                                            .resolveWith<OutlinedBorder>(
                                          (Set<MaterialState> states) {
                                            return RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            );
                                          },
                                        ),
                                      ),
                                      onPressed: () {
                                        enquetesController.i.value == 0
                                            ? showToastError(
                                                context, 'Escolha uma opção!')
                                            : confirmedVote(
                                                'Deseja realmente votar em ${enquetes.perguntas[enquetesController.i.value]}',
                                                () {
                                                  enquetesController
                                                      .votarEnquete()
                                                      .then((value) {
                                                    value == 1
                                                        ? showToast(
                                                            context,
                                                            'Parabéns!',
                                                            'Voto computado com sucesso')
                                                        : onAlertButtonPressed(
                                                            context,
                                                            'Houve algum problema!Tente novamente',
                                                            '',
                                                            'images/error.png');
                                                  });
                                                },
                                              );
                                      },
                                      child: Text(
                                        'Votar',
                                        style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor!,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      shadowColor: Colors.black,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              enquetes.valida,
                                              style: GoogleFonts.montserrat(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context)
                                                    .textSelectionTheme
                                                    .selectionColor!,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Total de votos: ${enquetes.soma}',
                                              style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                color: Theme.of(context)
                                                    .textSelectionTheme
                                                    .selectionColor!,
                                              ),
                                            ),
                                          ),
                                          enquetes.verificavoto != "Não Votou"
                                              ? Container(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      enquetes.verificavoto,
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        fontSize: 14,
                                                        color: Theme.of(context)
                                                            .textSelectionTheme
                                                            .selectionColor!,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Container(),
                                          enquetes.verificavoto != 'Não Votou'
                                              ? Container(
                                                  alignment: Alignment.center,
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 20,
                                                      horizontal: 10),
                                                  child: Text(
                                                    'Obrigado Pela Sua Participação!',
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Theme.of(context)
                                                          .textSelectionTheme
                                                          .selectionColor!,
                                                    ),
                                                  ),
                                                )
                                              : Container(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      );
                    }));
      }),
    );
  }
}
