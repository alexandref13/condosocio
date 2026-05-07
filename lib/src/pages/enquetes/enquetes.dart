import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/controllers/enquetes/visualizar_enquetes_controller.dart';
import 'package:condosocio/src/services/enquetes/mapa_enquetes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:condosocio/src/components/condo_nav_bar.dart';

class Enquetes extends StatelessWidget {
  final VisualizarEnquetesController visualizarEnquetesController =
      Get.put(VisualizarEnquetesController());

  Enquetes({super.key});

  static const Map<String, String> _monthLabels = {
    '01': 'JAN',
    '02': 'FEV',
    '03': 'MAR',
    '04': 'ABR',
    '05': 'MAI',
    '06': 'JUN',
    '07': 'JUL',
    '08': 'AGO',
    '09': 'SET',
    '10': 'OUT',
    '11': 'NOV',
    '12': 'DEZ',
  };

  ({String day, String month, String year}) _parts(String value) {
    final parts = value.split('/');
    return (
      day: parts.isNotEmpty ? parts[0] : '--',
      month: parts.length > 1 ? (_monthLabels[parts[1]] ?? parts[1]) : '--',
      year: parts.length > 2 ? parts[2] : '',
    );
  }

  List<Widget> _buildGrouped(List<MapaEnquetes> enquetes) {
    final widgets = <Widget>[];
    String? currentYear;

    for (final enquete in enquetes) {
      final year = _parts(enquete.datacreate).year;
      if (year.isNotEmpty && year != currentYear) {
        widgets.add(_YearHeader(ano: year));
        currentYear = year;
      }

      widgets.add(
        _EnqueteCard(
          enquete: enquete,
          parts: _parts(enquete.datacreate),
          onTap: () {
            visualizarEnquetesController.titulo.value = enquete.titulo;
            visualizarEnquetesController.idenq.value = enquete.idenq;
            Get.toNamed('/votarEnquetes');
          },
        ),
      );
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    final textColor =
        Theme.of(context).textSelectionTheme.selectionColor ?? Colors.white;

    return WillPopScope(
      onWillPop: () async {
        Get.offNamed('/home');
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Get.offNamed('/home'),
            icon: const Icon(Icons.arrow_back_ios),
          ),
          title: Text(
            'Enquetes',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: textColor,
            ),
          ),
          centerTitle: true,
        ),
        bottomNavigationBar: CondoNavBar(),
        body: Obx(() {
          if (visualizarEnquetesController.isLoading.value) {
            return CircularProgressIndicatorWidget();
          }

          final enquetes = visualizarEnquetesController.enquetes.toList();

          if (enquetes.isEmpty) {
            return LayoutBuilder(
              builder: (context, constraints) {
                return Center(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: constraints.maxWidth * 0.72,
                            maxHeight: constraints.maxHeight * 0.48,
                          ),
                          child: Image.asset(
                            'images/semregistro.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withValues(alpha: 0.42),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.10),
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Nenhuma enquete cadastrada',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: textColor,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Quando houver enquetes publicadas pela administração, elas aparecerão aqui.',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  height: 1.45,
                                  color: textColor.withValues(alpha: 0.78),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
            children: _buildGrouped(enquetes),
          );
        }),
      ),
    );
  }
}

class _EnqueteCard extends StatelessWidget {
  final MapaEnquetes enquete;
  final ({String day, String month, String year}) parts;
  final VoidCallback onTap;

  const _EnqueteCard({
    required this.enquete,
    required this.parts,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textColor =
        Theme.of(context).textSelectionTheme.selectionColor ?? Colors.white;
    final isClosed = enquete.datavalida == 'Votação Encerrada';
    final badgeColor = isClosed ? Colors.orange : Colors.green;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
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
        child: Row(
          children: [
            Container(
              width: 62,
              height: 62,
              decoration: BoxDecoration(
                color:
                    Theme.of(context).primaryColorDark.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: Theme.of(context)
                      .primaryColorDark
                      .withValues(alpha: 0.45),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    parts.day,
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: textColor,
                    ),
                  ),
                  Text(
                    parts.month,
                    style: GoogleFonts.montserrat(
                      fontSize: 11,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w600,
                      color: textColor.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    enquete.titulo,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.montserrat(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    enquete.datavalida,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.montserrat(
                      fontSize: 11,
                      color: textColor.withValues(alpha: 0.72),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: badgeColor.withValues(alpha: 0.16),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: badgeColor.withValues(alpha: 0.45),
                    ),
                  ),
                  child: Text(
                    isClosed ? 'Encerrada' : 'Aberta',
                    style: GoogleFonts.montserrat(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: badgeColor,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                  color: textColor.withValues(alpha: 0.7),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _YearHeader extends StatelessWidget {
  final String ano;

  const _YearHeader({required this.ano});

  @override
  Widget build(BuildContext context) {
    final textColor =
        Theme.of(context).textSelectionTheme.selectionColor ?? Colors.white;

    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 10),
      child: Row(
        children: [
          Text(
            ano,
            style: GoogleFonts.montserrat(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: textColor,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              height: 1,
              color: textColor.withValues(alpha: 0.22),
            ),
          ),
        ],
      ),
    );
  }
}
