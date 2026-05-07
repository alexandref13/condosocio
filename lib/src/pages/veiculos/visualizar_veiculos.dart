import 'package:condosocio/src/components/utils/box_search.dart';
import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/pages/veiculos/modal_veiculos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/veiculos/veiculos_controller.dart';

class VisualizarVeiculos extends StatefulWidget {
  @override
  _VisualizarVeiculosState createState() => _VisualizarVeiculosState();
}

class _VisualizarVeiculosState extends State<VisualizarVeiculos> {
  final VeiculosController veiculosController = Get.find<VeiculosController>();

  @override
  void initState() {
    veiculosController.getVeiculos();
    super.initState();
  }

  List<dynamic> _veiculosVisiveis() {
    final bool hasSearch = veiculosController.searchQuery.value.isNotEmpty;

    if (hasSearch) {
      return veiculosController.searchResult.toList();
    }

    return veiculosController.veiculos.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final bool isLoading = veiculosController.isLoading.value;
      final bool hasSearch = veiculosController.searchQuery.value.isNotEmpty;
      final veiculos = _veiculosVisiveis();
      final textColor =
          Theme.of(context).textSelectionTheme.selectionColor ?? Colors.white;

      if (isLoading) {
        return CircularProgressIndicatorWidget();
      }

      return Column(
        children: [
          const SizedBox(height: 20),
          boxSearch(
            context,
            veiculosController.search.value,
            veiculosController.onSearchTextChanged,
            'Pesquise por marca, modelo ou placa...',
          ),
          Expanded(
            child: veiculos.isEmpty
                ? LayoutBuilder(
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
                                      hasSearch
                                          ? 'Nenhum veículo encontrado'
                                          : 'Nenhum veículo cadastrado',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.montserrat(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: textColor,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      hasSearch
                                          ? 'Tente buscar por outra marca, modelo ou placa.'
                                          : 'Quando houver veículos cadastrados, eles aparecerão aqui.',
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
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 18),
                    itemCount: veiculos.length,
                    itemBuilder: (_, i) {
                      final veiculo = veiculos[i];

                      veiculosController.qtdVag.value =
                          int.tryParse(veiculo.qtdVagas) ?? 0;
                      veiculosController.cont.value =
                          int.tryParse(veiculo.contagem) ?? 0;

                      return GestureDetector(
                        onTap: () {
                          veiculosModalBottomSheet(
                            context,
                            veiculo.idvei,
                            veiculo.marca,
                            veiculo.modelo,
                            veiculo.cor,
                            veiculo.ano,
                            veiculo.placa,
                            veiculo.desde,
                            veiculo.contagem,
                            veiculo.qtdVagas,
                          );
                        },
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
                                width: 58,
                                height: 58,
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .primaryColorDark
                                      .withValues(alpha: 0.18),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.directions_car_outlined,
                                  size: 28,
                                  color: textColor,
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${veiculo.marca} ${veiculo.modelo}',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.montserrat(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        color: textColor,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 5,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .primaryColorDark
                                                .withValues(alpha: 0.22),
                                            borderRadius:
                                                BorderRadius.circular(999),
                                          ),
                                          child: Text(
                                            veiculo.placa,
                                            style: GoogleFonts.montserrat(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w700,
                                              letterSpacing: 1.1,
                                              color: textColor,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            'Vagas ${veiculo.contagem}/${veiculo.qtdVagas}',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.montserrat(
                                              fontSize: 11,
                                              color: textColor.withValues(
                                                  alpha: 0.72),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
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
                        ),
                      );
                    },
                  ),
          ),
        ],
      );
    });
  }
}
