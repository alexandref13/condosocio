import 'package:condosocio/src/components/utils/animated_dialog.dart';
import 'package:condosocio/src/components/utils/alert_button_pressed.dart';
import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/components/utils/edge_alert_error_widget.dart';
import 'package:condosocio/src/components/utils/edge_alert_widget.dart';
import 'package:condosocio/src/components/utils/progress_indicator_widget.dart';
import 'package:condosocio/src/controllers/enquetes/visualizar_enquetes_controller.dart';
import 'package:condosocio/src/controllers/enquetes/votar_enquete.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class VotarEnquete extends StatelessWidget {
  final VotarEnqueteController enquetesController =
      Get.put(VotarEnqueteController());
  final VisualizarEnquetesController visualizarEnquetesController =
      Get.put(VisualizarEnquetesController());

  VotarEnquete({super.key});

  void _confirmedVote(
    BuildContext context,
    String text,
    VoidCallback onOk,
  ) {
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
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: bg,
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.how_to_vote_outlined,
                  color: Colors.orange,
                  size: 54,
                ),
                const SizedBox(height: 12),
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
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancelar',
                style: GoogleFonts.montserrat(
                  color: theme.colorScheme.error,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onOk();
              },
              child: Text(
                'OK',
                style: GoogleFonts.montserrat(
                  color: theme.primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final textColor =
        Theme.of(context).textSelectionTheme.selectionColor ?? Colors.white;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Enquete',
          style: GoogleFonts.montserrat(
            fontSize: 16,
            color: textColor,
          ),
        ),
      ),
      body: Obx(() {
        if (enquetesController.isLoading.value) {
          return const CircularProgressIndicatorWidget();
        }

        if (enquetesController.enquete.isEmpty) {
          return Center(
            child: Text(
              'Nenhuma enquete encontrada.',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                color: textColor,
              ),
            ),
          );
        }

        final enquete = enquetesController.enquete.first;
        final canVote = enquete.verificavoto == 'Não Votou' &&
            enquete.valida == 'Votação Aberta';
        final options =
            List<int>.generate(enquete.qdtperguntas, (index) => index)
                .where((index) =>
                    index != 0 && enquete.perguntas[index].trim().isNotEmpty)
                .toList();

        return ListView(
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 24),
          children: [
            _EnqueteHeaderCard(
              titulo: visualizarEnquetesController.titulo.value,
              valida: enquete.valida,
              canVote: canVote,
            ),
            const SizedBox(height: 14),
            ...options.map(
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: canVote
                    ? Obx(
                        () => _VoteOptionCard(
                          texto: enquete.perguntas[index],
                          votos: enquete.votacao[index],
                          selected: enquetesController.i.value == index,
                          onTap: () => enquetesController.i.value = index,
                        ),
                      )
                    : _VoteResultCard(
                        texto: enquete.perguntas[index],
                        votos: enquete.votacao[index],
                        total: enquete.soma,
                      ),
              ),
            ),
            const SizedBox(height: 6),
            canVote
                ? SizedBox(
                    height: 52,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (_) => Theme.of(context).colorScheme.secondary,
                        ),
                        shape:
                            MaterialStateProperty.resolveWith<OutlinedBorder>(
                          (_) => RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (enquetesController.i.value == 0) {
                          showToastError(context, 'Escolha uma opção!');
                          return;
                        }

                        _confirmedVote(
                          context,
                          'Deseja realmente votar em ${enquete.perguntas[enquetesController.i.value]}?',
                          () {
                            enquetesController.votarEnquete().then((value) {
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
                        'Confirmar voto',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                    ),
                  )
                : _EnqueteFooterCard(
                    valida: enquete.valida,
                    soma: enquete.soma,
                    verificavoto: enquete.verificavoto,
                  ),
          ],
        );
      }),
    );
  }
}

class _EnqueteHeaderCard extends StatelessWidget {
  final String titulo;
  final String valida;
  final bool canVote;

  const _EnqueteHeaderCard({
    required this.titulo,
    required this.valida,
    required this.canVote,
  });

  @override
  Widget build(BuildContext context) {
    final textColor =
        Theme.of(context).textSelectionTheme.selectionColor ?? Colors.white;
    final badgeColor = canVote ? Colors.green : Colors.orange;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Image.asset(
            'images/enquete.png',
            height: 180,
          ),
          const SizedBox(height: 8),
          Text(
            titulo,
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: badgeColor.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(
                color: badgeColor.withValues(alpha: 0.45),
              ),
            ),
            child: Text(
              valida,
              style: GoogleFonts.montserrat(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: badgeColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _VoteOptionCard extends StatelessWidget {
  final String texto;
  final int votos;
  final bool selected;
  final VoidCallback onTap;

  const _VoteOptionCard({
    required this.texto,
    required this.votos,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textColor =
        Theme.of(context).textSelectionTheme.selectionColor ?? Colors.white;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: selected
              ? Theme.of(context).primaryColorDark.withValues(alpha: 0.26)
              : Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected
                ? Colors.green.withValues(alpha: 0.55)
                : Colors.white.withValues(alpha: 0.08),
            width: selected ? 1.2 : 1,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected ? Colors.green : Colors.transparent,
                border: Border.all(
                  color: selected
                      ? Colors.green
                      : textColor.withValues(alpha: 0.55),
                ),
              ),
              child: selected
                  ? const Icon(
                      Icons.check,
                      size: 14,
                      color: Colors.white,
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                texto,
                style: GoogleFonts.montserrat(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              '($votos)',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                color: textColor.withValues(alpha: 0.72),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VoteResultCard extends StatelessWidget {
  final String texto;
  final int votos;
  final int total;

  const _VoteResultCard({
    required this.texto,
    required this.votos,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final textColor =
        Theme.of(context).textSelectionTheme.selectionColor ?? Colors.white;
    final percentage = total == 0 ? 0 : ((votos / total) * 100).round();

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '$texto ($votos)',
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    color: textColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '$percentage%',
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  color: textColor.withValues(alpha: 0.78),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 14,
            child: ProgressIndicatorWidget(
              value: total == 0 ? 0 : (votos / total),
            ),
          ),
        ],
      ),
    );
  }
}

class _EnqueteFooterCard extends StatelessWidget {
  final String valida;
  final int soma;
  final String verificavoto;

  const _EnqueteFooterCard({
    required this.valida,
    required this.soma,
    required this.verificavoto,
  });

  @override
  Widget build(BuildContext context) {
    final textColor =
        Theme.of(context).textSelectionTheme.selectionColor ?? Colors.white;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            valida,
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Total de votos: $soma',
            style: GoogleFonts.montserrat(
              fontSize: 13,
              color: textColor.withValues(alpha: 0.82),
            ),
          ),
          if (verificavoto != 'Não Votou') ...[
            const SizedBox(height: 8),
            Text(
              verificavoto,
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontSize: 13,
                color: textColor.withValues(alpha: 0.82),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Obrigado pela sua participação!',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
