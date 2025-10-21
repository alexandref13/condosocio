import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/components/utils/progress_indicator_widget.dart';
import 'package:condosocio/src/controllers/enquetes/visualizar_enquetes_controller.dart';
import 'package:condosocio/src/controllers/enquetes/votar_enquete.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:condosocio/src/components/utils/animated_dialog.dart'; // <- helper com showScaledDialog
import '../../components/utils/alert_button_pressed.dart';
import '../../components/utils/edge_alert_error_widget.dart';
import '../../components/utils/edge_alert_widget.dart';

class VotarEnquete extends StatelessWidget {
  final VotarEnqueteController enquetesController =
      Get.put(VotarEnqueteController());
  final VisualizarEnquetesController visualizarEnquetesController =
      Get.put(VisualizarEnquetesController());
  final LoginController loginController = Get.put(LoginController());

  VotarEnquete({super.key});

  @override
  Widget build(BuildContext context) {
    void confirmedVote(String text, VoidCallback onOk) {
      showScaledDialog(
        context: context,
        barrierDismissible: false,
        transitionDuration: const Duration(milliseconds: 500),
        builder: (BuildContext context) {
          final theme = Theme.of(context);
          final bg = theme.textSelectionTheme.selectionColor ?? Colors.white;

          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            backgroundColor: bg,
            content: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.warning,
                    color: Colors.orange,
                    size: 54,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    text,
                    style: GoogleFonts.poppins(
                      color: theme.primaryColor,
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
                    color: theme.colorScheme.error,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                child: Text(
                  "OK",
                  style: GoogleFonts.montserrat(
                    color: theme.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // fecha o diálogo antes
                  onOk(); // executa ação
                },
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
            ? const CircularProgressIndicatorWidget()
            : ListView.builder(
                itemCount: enquetesController.enquete.length,
                itemBuilder: (_, index) {
                  final enquetes = enquetesController.enquete[index];

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Image.asset(
                          'images/enquete.png',
                          height: 340,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(10, 5, 10, 20),
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
                        GestureDetector(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                (enquetes.verificavoto == 'Não Votou' &&
                                        enquetes.valida == 'Votação Aberta')
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          i == 0
                                              ? const SizedBox.shrink()
                                              : Text(
                                                  '${enquetes.perguntas[i]} (${enquetes.votacao[i]})',
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 12,
                                                    color: Theme.of(context)
                                                        .textSelectionTheme
                                                        .selectionColor!,
                                                  ),
                                                ),
                                          i == 0
                                              ? const SizedBox.shrink()
                                              : Obx(
                                                  () => Radio<int>(
                                                    value: i,
                                                    groupValue:
                                                        enquetesController
                                                            .i.value,
                                                    onChanged: (value) {
                                                      enquetesController
                                                          .i.value = value!;
                                                    },
                                                    activeColor: Colors.white,
                                                  ),
                                                ),
                                        ],
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          i == 0
                                              ? const SizedBox.shrink()
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5),
                                                  child: Text(
                                                    '${enquetes.perguntas[i]} (${enquetes.votacao[i]})',
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      fontSize: 10,
                                                      color: Theme.of(context)
                                                          .textSelectionTheme
                                                          .selectionColor!,
                                                    ),
                                                  ),
                                                ),
                                          i == 0
                                              ? const SizedBox.shrink()
                                              : Text(
                                                  enquetes.votacao[i] != 0
                                                      ? '${((enquetes.votacao[i] / enquetes.soma) * 100).toStringAsFixed(0)}%'
                                                      : '0%',
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 10,
                                                    color: Theme.of(context)
                                                        .textSelectionTheme
                                                        .selectionColor!,
                                                  ),
                                                ),
                                        ],
                                      ),
                                (enquetes.verificavoto != 'Não Votou' ||
                                        enquetes.valida ==
                                            'Votações Encerradas')
                                    ? Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            5, 8, 5, 8),
                                        height: 15,
                                        child: ProgressIndicatorWidget(
                                          value: enquetes.votacao[i] != 0
                                              ? (enquetes.votacao[i] /
                                                  enquetes.soma)
                                              : 0,
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                              ],
                            ),
                          ),
                        ),
                      (enquetes.verificavoto == 'Não Votou' &&
                              enquetes.valida != 'Votações Encerradas')
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: SizedBox(
                                height: 50,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty
                                        .resolveWith<Color>((_) {
                                      return Theme.of(context)
                                          .colorScheme
                                          .secondary;
                                    }),
                                    shape: MaterialStateProperty.resolveWith<
                                        OutlinedBorder>((_) {
                                      return RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      );
                                    }),
                                  ),
                                  onPressed: () {
                                    if (enquetesController.i.value == 0) {
                                      showToastError(
                                          context, 'Escolha uma opção!');
                                      return;
                                    }
                                    confirmedVote(
                                      'Deseja realmente votar em ${enquetes.perguntas[enquetesController.i.value]}',
                                      () {
                                        enquetesController
                                            .votarEnquete()
                                            .then((value) {
                                          if (value == 1) {
                                            showToast(
                                              context,
                                              'Parabéns!',
                                              'Voto computado com sucesso',
                                            );
                                          } else {
                                            onAlertButtonPressed(
                                              context,
                                              'Houve algum problema! Tente novamente',
                                              '',
                                              'images/error.png',
                                            );
                                          }
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
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                color: Theme.of(context).colorScheme.secondary,
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
                                        ? Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              enquetes.verificavoto,
                                              style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                color: Theme.of(context)
                                                    .textSelectionTheme
                                                    .selectionColor!,
                                              ),
                                            ),
                                          )
                                        : const SizedBox.shrink(),
                                    enquetes.verificavoto != 'Não Votou'
                                        ? Container(
                                            alignment: Alignment.center,
                                            margin: const EdgeInsets.symmetric(
                                              vertical: 20,
                                              horizontal: 10,
                                            ),
                                            child: Text(
                                              'Obrigado Pela Sua Participação!',
                                              style: GoogleFonts.montserrat(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context)
                                                    .textSelectionTheme
                                                    .selectionColor!,
                                              ),
                                            ),
                                          )
                                        : const SizedBox.shrink(),
                                  ],
                                ),
                              ),
                            ),
                    ],
                  );
                },
              );
      }),
    );
  }
}
