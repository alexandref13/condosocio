import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/controllers/encomendas_controller.dart';
import 'package:condosocio/src/services/encomendas/mapa_encomendas.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:condosocio/src/components/condo_nav_bar.dart';

class Encomendas extends StatelessWidget {
  final EncomendasController encomendasController =
      Get.put(EncomendasController());

  Encomendas({super.key});

  String _groupLabel(String dataCriada) {
    final datePart = dataCriada.split(' ').first.trim();
    final now = DateTime.now();
    final today = _formatDate(now);
    final yesterday = _formatDate(now.subtract(const Duration(days: 1)));

    if (datePart == today) return 'Hoje';
    if (datePart == yesterday) return 'Ontem';
    return datePart;
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = (date.year % 100).toString().padLeft(2, '0');
    return '$day/$month/$year';
  }

  List<Widget> _buildAgrupadas(List<MapaEncomendas> encomendas) {
    final widgets = <Widget>[];
    String? groupAtual;

    for (final encomenda in encomendas) {
      final grupo = _groupLabel(encomenda.dataCriada);
      if (grupo != groupAtual) {
        widgets.add(_SectionHeader(label: grupo));
        groupAtual = grupo;
      }
      widgets.add(
        _EncomendaCard(
          encomenda: encomenda,
          onTap: () => _abrirDetalhe(encomenda),
        ),
      );
    }

    return widgets;
  }

  void _abrirDetalhe(MapaEncomendas encomenda) {
    encomendasController.id.value = encomenda.idenc;
    encomendasController.idcript.value = encomenda.idcript;
    encomendasController.codigo.value = encomenda.codigo;
    encomendasController.tipo.value = encomenda.tipo;
    encomendasController.info.value = encomenda.info;
    encomendasController.status.value = encomenda.status;
    encomendasController.morador.value = encomenda.morador;
    encomendasController.admCriador.value = encomenda.admCriador;
    encomendasController.dataCriada.value = encomenda.dataCriada;
    encomendasController.admEntrega.value = encomenda.admEntrega;
    encomendasController.dataEntrega.value = encomenda.dataEntrega;
    encomendasController.imgEncomenda.value = encomenda.imgEncomenda;

    Get.toNamed('/detalhesEncomendas');
  }

  @override
  Widget build(BuildContext context) {
    final textColor =
        Theme.of(context).textSelectionTheme.selectionColor ?? Colors.white;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.offNamed('/home'),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          'Encomendas',
          style: GoogleFonts.montserrat(
            fontSize: 16,
            color: textColor,
          ),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: CondoNavBar(),
      body: Obx(() {
        if (encomendasController.isLoading.value &&
            encomendasController.encomendas.isEmpty) {
          return CircularProgressIndicatorWidget();
        }

        if (encomendasController.encomendas.isEmpty) {
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
                              'Nenhuma encomenda encontrada',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: textColor,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Quando houver encomendas registradas para sua unidade, elas aparecerão aqui.',
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

        return SmartRefresher(
          controller: encomendasController.refreshController,
          enablePullDown: true,
          enablePullUp: encomendasController.hasMore.value,
          onRefresh: encomendasController.onRefresh,
          onLoading: encomendasController.onLoading,
          footer: const ClassicFooter(
            loadingText: 'Carregando mais encomendas...',
            idleText: 'Puxe para carregar mais',
            noDataText: 'Todas as encomendas foram carregadas',
          ),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
            children: _buildAgrupadas(encomendasController.encomendas.toList()),
          ),
        );
      }),
    );
  }
}

class _EncomendaCard extends StatelessWidget {
  final MapaEncomendas encomenda;
  final VoidCallback onTap;

  const _EncomendaCard({
    required this.encomenda,
    required this.onTap,
  });

  String get _horaCriada {
    final parts = encomenda.dataCriada.split(' ');
    if (parts.length < 2) return '';
    final hora = parts[1].trim();
    return hora.endsWith('h') ? hora : '${hora}h';
  }

  @override
  Widget build(BuildContext context) {
    final textColor =
        Theme.of(context).textSelectionTheme.selectionColor ?? Colors.white;
    final isReady = encomenda.status == 'PRONTO PRA RETIRADA';

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
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: isReady
                    ? Colors.green.withValues(alpha: 0.16)
                    : Theme.of(context).primaryColorDark.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isReady
                      ? Colors.green.withValues(alpha: 0.45)
                      : Theme.of(context)
                          .primaryColorDark
                          .withValues(alpha: 0.45),
                ),
              ),
              child: Icon(
                isReady ? Icons.inventory_2_outlined : Icons.local_shipping,
                size: 28,
                color: isReady ? Colors.green.shade300 : textColor,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    encomenda.codigo.length > 24
                        ? '${encomenda.codigo.substring(0, 24)}...'
                        : encomenda.codigo,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    encomenda.tipo,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      color: textColor.withValues(alpha: 0.82),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _horaCriada,
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
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
                    color: isReady
                        ? Colors.green.withValues(alpha: 0.16)
                        : Colors.orange.withValues(alpha: 0.16),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isReady
                          ? Colors.green.withValues(alpha: 0.45)
                          : Colors.orange.withValues(alpha: 0.45),
                    ),
                  ),
                  child: Text(
                    isReady ? 'À receber' : 'Entregue',
                    style: GoogleFonts.montserrat(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: isReady ? Colors.green.shade300 : Colors.orange,
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

class _SectionHeader extends StatelessWidget {
  final String label;

  const _SectionHeader({required this.label});

  @override
  Widget build(BuildContext context) {
    final textColor =
        Theme.of(context).textSelectionTheme.selectionColor ?? Colors.white;

    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        children: [
          Text(
            label,
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
