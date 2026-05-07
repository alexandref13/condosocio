import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/controllers/convites/convites_controller.dart';
import 'package:condosocio/src/controllers/convites/visualizar_convites_controller.dart';
import 'package:condosocio/src/services/convites/mapa_convites.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VisualizarConvite extends StatefulWidget {
  @override
  State<VisualizarConvite> createState() => _VisualizarConviteState();
}

class _VisualizarConviteState extends State<VisualizarConvite> {
  final ConvitesController convitesController = Get.find<ConvitesController>();

  DateTime? _parseConviteDate(String value) {
    final normalized = value.trim();
    if (normalized.isEmpty) {
      return null;
    }

    final isoParsed = DateTime.tryParse(normalized);
    if (isoParsed != null) {
      return isoParsed;
    }

    final match = RegExp(
      r'^(\d{2})\/(\d{2})\/(\d{2,4})(?: (\d{2}):(\d{2})(?::(\d{2}))?)?$',
    ).firstMatch(normalized);

    if (match == null) {
      return null;
    }

    final day = int.tryParse(match.group(1) ?? '');
    final month = int.tryParse(match.group(2) ?? '');
    final rawYear = int.tryParse(match.group(3) ?? '');
    final hour = int.tryParse(match.group(4) ?? '') ?? 0;
    final minute = int.tryParse(match.group(5) ?? '') ?? 0;
    final second = int.tryParse(match.group(6) ?? '') ?? 0;

    if (day == null || month == null || rawYear == null) {
      return null;
    }

    final year = rawYear < 100 ? 2000 + rawYear : rawYear;
    return DateTime(year, month, day, hour, minute, second);
  }

  String _formatShortDateTime(String value) {
    final date = _parseConviteDate(value);
    if (date == null) {
      return value;
    }

    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = (date.year % 100).toString().padLeft(2, '0');
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '$day/$month/$year $hour:${minute}h';
  }

  void _openConvite(
    VisualizarConvitesController visualizarConviteController,
    ConvitesMapa convite,
  ) {
    visualizarConviteController.titulo.value = convite.titulo;
    visualizarConviteController.qtdconv.value = convite.qtdconv;
    visualizarConviteController.endDate.value = convite.datafinal;
    visualizarConviteController.idConv.value = convite.idconv;
    visualizarConviteController.acesso.value = convite.acesso;
    visualizarConviteController.getAConvite(convite.idconv);
  }

  Widget _buildEmptyState(BuildContext context, {String? message}) {
    final textColor = Theme.of(context).textSelectionTheme.selectionColor!;
    final title = message ?? 'Nenhum convite cadastrado';
    final subtitle = message != null
        ? 'Tente buscar por outro título de convite.'
        : 'Quando houver convites cadastrados, eles aparecerão aqui.';

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
                        title,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        subtitle,
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

  @override
  Widget build(BuildContext context) {
    final VisualizarConvitesController visualizarConviteController =
        Get.find<VisualizarConvitesController>();

    return Obx(() {
      final isFirstLoadPending = !convitesController.hasLoadedConvites.value;
      final List<ConvitesMapa> currentList =
          convitesController.convites.toList();

      if (visualizarConviteController.isLoading.value ||
          convitesController.isLoading.value ||
          isFirstLoadPending) {
        return CircularProgressIndicatorWidget();
      }

      if (convitesController.convites.isEmpty) {
        return _buildEmptyState(context);
      }

      return Column(
        children: [
          const SizedBox(height: 24),
          Expanded(
            child: SmartRefresher(
              controller: convitesController.refreshController,
              onRefresh: convitesController.onRefresh,
              onLoading: convitesController.onLoading,
              child: currentList.isEmpty
                  ? _buildEmptyState(context)
                  : ListView.builder(
                      padding: const EdgeInsets.only(top: 8, bottom: 16),
                      itemCount: currentList.length,
                      itemBuilder: (_, i) {
                        final convite = currentList[i];
                        final endDate = _parseConviteDate(convite.datafinal);
                        final now = DateTime.now();
                        final isExpired =
                            endDate != null && endDate.isBefore(now);

                        return _ConviteCard(
                          convite: convite,
                          isExpired: isExpired,
                          formattedDate:
                              _formatShortDateTime(convite.datafinal),
                          onTap: () => _openConvite(
                            visualizarConviteController,
                            convite,
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      );
    });
  }
}

class _ConviteCard extends StatelessWidget {
  const _ConviteCard({
    required this.convite,
    required this.isExpired,
    required this.formattedDate,
    required this.onTap,
  });

  final ConvitesMapa convite;
  final bool isExpired;
  final String formattedDate;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textSelectionTheme.selectionColor!;
    final statusText = convite.acesso == '1' ? 'Acesso Livre' : 'Único Acesso';
    final statusColor = isExpired
        ? Theme.of(context).colorScheme.error
        : convite.acesso == '1'
            ? const Color(0xFF87E8A3)
            : Theme.of(context).colorScheme.secondaryContainer;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color:
                      Theme.of(context).primaryColorDark.withValues(alpha: .42),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      convite.dia,
                      style: GoogleFonts.montserrat(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      convite.mes,
                      style: GoogleFonts.montserrat(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        letterSpacing: .8,
                        color: textColor.withValues(alpha: .82),
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
                      convite.titulo,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${convite.qtdconv} convidados',
                      style: GoogleFonts.montserrat(
                        fontSize: 13,
                        color: textColor.withValues(alpha: .82),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Válido até $formattedDate',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        color: textColor.withValues(alpha: .62),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isExpired ? Icons.event_busy : Icons.task_alt,
                        size: 20,
                        color: statusColor,
                      ),
                      const SizedBox(width: 10),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: textColor.withValues(alpha: .72),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    statusText,
                    style: GoogleFonts.montserrat(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: .3,
                      color: statusColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
