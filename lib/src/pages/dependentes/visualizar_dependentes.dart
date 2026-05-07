import 'package:condosocio/src/components/dependentes/modal_bottom_sheet.dart';
import 'package:condosocio/src/components/utils/box_search.dart';
import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/controllers/dependentes_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

String _dependenteImageUrl(String img) {
  if (img.trim().isEmpty) return '';
  return 'https://www.condosocio.com.br/acond/downloads/fotosperfil/$img';
}

String _tipoLabel(String tipo) {
  if (tipo.trim() == 'Morador') return 'Morador';
  if (tipo.trim().isEmpty) return 'Dependente';
  return tipo;
}

Color _tipoBadgeColor(String tipo) {
  if (tipo.trim() == 'Morador') {
    return const Color(0xFF7EE787);
  }
  if (tipo.trim() == 'Prestador de Serviço') {
    return const Color(0xFFFFC978);
  }
  return const Color(0xFFD1D5DB);
}

IconData _tipoBadgeIcon(String tipo) {
  if (tipo.trim() == 'Morador') {
    return Icons.home_rounded;
  }
  if (tipo.trim() == 'Prestador de Serviço') {
    return Icons.badge_rounded;
  }
  return Icons.person_rounded;
}

class VisualizarDependentes extends StatelessWidget {
  const VisualizarDependentes({Key? key}) : super(key: key);

  void _abrirDetalhes(
      BuildContext context, DependentesController ctrl, dynamic dependente) {
    ctrl.idep.value = dependente.idep;
    ctrl.status.value = dependente.status;

    dependentesModalBottomSheet(
      context,
      dependente.nome,
      dependente.sobrenome,
      dependente.status,
      dependente.email,
      dependente.img,
      dependente.celular,
      dependente.facial,
      dependente.tipousuario,
      dependente.idep,
      dependente.condominio_facial,
      dependente.ctlnotificacao,
      ultacesso: dependente.ultacesso,
    );
  }

  @override
  Widget build(BuildContext context) {
    final DependentesController dependentesController =
        Get.find<DependentesController>();

    return Obx(() {
      final bool hasSearch =
          dependentesController.searchQuery.value.isNotEmpty;
      final List<dynamic> dependentes = hasSearch
          ? dependentesController.searchResult.toList()
          : dependentesController.dependentes.toList();

      if (dependentesController.isLoading.value) {
        return CircularProgressIndicatorWidget();
      }

      return Column(
        children: [
          const SizedBox(height: 20),
          boxSearch(
            context,
            dependentesController.search.value,
            dependentesController.onSearchTextChanged,
            "Pesquise por Nome...",
          ),
          Expanded(
            child: dependentes.isEmpty
                ? LayoutBuilder(
                    builder: (context, constraints) {
                      final textColor = Theme.of(context)
                          .textSelectionTheme
                          .selectionColor!;

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
                                          ? 'Nenhum resultado encontrado'
                                          : 'Nenhum usuário cadastrado',
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
                                          ? 'Tente buscar por outro nome, sobrenome ou tipo de usuário.'
                                          : 'Quando houver usuários cadastrados, eles aparecerão aqui.',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        height: 1.45,
                                        color:
                                            textColor.withValues(alpha: 0.78),
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
                    padding: const EdgeInsets.only(bottom: 16),
                    itemCount: dependentes.length,
                    itemBuilder: (_, i) {
                      final dependente = dependentes[i];
                      final textColor =
                          Theme.of(context).textSelectionTheme.selectionColor!;
                      final imageUrl = _dependenteImageUrl(dependente.img);
                      final bool isSuspenso = dependente.status == 'Suspenso';
                      final bool isTitular = dependente.ctlnotificacao != '0';

                      return GestureDetector(
                        onTap: () => _abrirDetalhes(
                            context, dependentesController, dependente),
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 5),
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 12),
                            child: Row(
                              children: [
                                ClipOval(
                                  child: SizedBox(
                                    width: 54,
                                    height: 54,
                                    child: imageUrl.isEmpty
                                        ? Container(
                                            color: Theme.of(context)
                                                .primaryColorDark,
                                            alignment: Alignment.center,
                                            child: Icon(Icons.person,
                                                size: 28, color: textColor),
                                          )
                                        : Image.network(
                                            imageUrl,
                                            fit: BoxFit.cover,
                                            errorBuilder: (_, __, ___) =>
                                                Container(
                                              color: Theme.of(context)
                                                  .primaryColorDark,
                                              alignment: Alignment.center,
                                              child: Icon(Icons.person,
                                                  size: 28, color: textColor),
                                            ),
                                          ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${dependente.nome} ${dependente.sobrenome}',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          color: textColor,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: _tipoBadgeColor(
                                            dependente.tipousuario,
                                          ).withValues(alpha: 0.18),
                                          borderRadius:
                                              BorderRadius.circular(999),
                                          border: Border.all(
                                            color: _tipoBadgeColor(
                                              dependente.tipousuario,
                                            ).withValues(alpha: 0.45),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              _tipoBadgeIcon(
                                                dependente.tipousuario,
                                              ),
                                              size: 12,
                                              color: _tipoBadgeColor(
                                                dependente.tipousuario,
                                              ),
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              _tipoLabel(
                                                dependente.tipousuario,
                                              ),
                                              style: GoogleFonts.montserrat(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w700,
                                                color: _tipoBadgeColor(
                                                  dependente.tipousuario,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 3),
                                      Text(
                                        'Desde ${dependente.desde}',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 11,
                                          color:
                                              textColor.withValues(alpha: 0.75),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          isSuspenso
                                              ? Icons.block_outlined
                                              : Icons.check_circle_outline,
                                          size: 20,
                                          color: isSuspenso
                                              ? Colors.redAccent
                                              : Colors.greenAccent,
                                        ),
                                        if (isTitular) ...[
                                          const SizedBox(width: 4),
                                          const Icon(
                                            Icons.workspace_premium_rounded,
                                            size: 20,
                                            color: Colors.amber,
                                          ),
                                        ],
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      dependente.status,
                                      style: GoogleFonts.montserrat(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color:
                                            textColor.withValues(alpha: 0.75),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 8),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 14,
                                  color: textColor.withValues(alpha: 0.75),
                                ),
                              ],
                            ),
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
