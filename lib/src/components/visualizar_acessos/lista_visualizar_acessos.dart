import 'package:condosocio/src/components/visualizar_acessos/modal_bottom_sheet.dart';
import 'package:condosocio/src/controllers/acessos/acessos_controller.dart';
import 'package:condosocio/src/controllers/acessos/visualizar_acessos_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

String _groupLabel(String datahora) {
  if (datahora.isEmpty) return '';
  return datahora.split(' ')[0];
}

String _hourLabel(String datahora) {
  final parts = datahora.split(' ');
  return parts.length > 1 ? parts[1] : '';
}

String _imageUrl(String imgfacial, String tipopessoa) {
  if (imgfacial.trim().isEmpty) return '';
  final isMorador = [
    'Morador',
    'Prestador',
    'Inquilino',
    'NM',
    'Prestador de Serviço',
    'Administrador',
    'Sindico',
    'Master',
    'Proprietario',
    'Proprietária',
  ].contains(tipopessoa);
  final folder = isMorador ? 'fotosperfil' : 'fotosvisitantes';
  return 'https://www.condosocio.com.br/acond/downloads/$folder/$imgfacial';
}

String _vehicleCaptureUrl(String imgplaca) {
  if (imgplaca.trim().isEmpty) return '';
  return 'https://www.condosocio.com.br/acond/downloads/placas/$imgplaca';
}

IconData _personTypeIcon(String tipopessoa) {
  final normalized = tipopessoa.trim().toLowerCase();

  if (normalized == 'convidado') {
    return Icons.person_add_alt_1_outlined;
  }

  if (normalized == 'prestador' || normalized == 'prestador de serviço') {
    return Icons.engineering_outlined;
  }

  if (normalized == 'appmobil' ||
      normalized == 'app mobilidade' ||
      normalized == 'app de mobilidade') {
    return Icons.local_taxi_outlined;
  }

  return Icons.person;
}

String _actorBadgeLabel(String tipopessoa) {
  final normalized = tipopessoa.trim().toLowerCase();

  if (normalized.contains('convidado')) return 'Convidado';
  if (normalized.contains('prestador')) return 'Prestador';
  if (normalized == 'appmobil' ||
      normalized.contains('app mobilidade') ||
      normalized.contains('app de mobilidade')) {
    return 'App Mobilidade';
  }
  if ([
    'morador',
    'inquilino',
    'administrador',
    'sindico',
    'síndico',
    'master',
    'nm',
    'proprietario',
    'proprietária',
  ].any((item) => normalized.contains(item))) {
    return 'Morador';
  }

  return tipopessoa.trim().isEmpty ? 'Acesso' : tipopessoa;
}

Color _actorBadgeColor(String tipopessoa) {
  final normalized = tipopessoa.trim().toLowerCase();

  if (normalized.contains('convidado')) return const Color(0xFF8BD3FF);
  if (normalized.contains('prestador')) return const Color(0xFFFFC978);
  if (normalized == 'appmobil' ||
      normalized.contains('app mobilidade') ||
      normalized.contains('app de mobilidade')) {
    return const Color(0xFFD2A8FF);
  }
  if ([
    'morador',
    'inquilino',
    'administrador',
    'sindico',
    'síndico',
    'master',
    'nm',
    'proprietario',
    'proprietária',
  ].any((item) => normalized.contains(item))) {
    return const Color(0xFF7EE787);
  }

  return const Color(0xFFD1D5DB);
}

IconData _actorBadgeIcon(String tipopessoa) {
  final normalized = tipopessoa.trim().toLowerCase();

  if (normalized.contains('convidado')) return Icons.person_add_alt_1_rounded;
  if (normalized.contains('prestador')) return Icons.engineering_rounded;
  if (normalized == 'appmobil' ||
      normalized.contains('app mobilidade') ||
      normalized.contains('app de mobilidade')) {
    return Icons.local_taxi_rounded;
  }
  if ([
    'morador',
    'inquilino',
    'administrador',
    'sindico',
    'síndico',
    'master',
    'nm',
    'proprietario',
    'proprietária',
  ].any((item) => normalized.contains(item))) {
    return Icons.home_rounded;
  }

  return Icons.person_rounded;
}

Widget listaVisualizarAcessos() => const _ListaAcessos();

class _ListaAcessos extends StatefulWidget {
  const _ListaAcessos();

  @override
  State<_ListaAcessos> createState() => _ListaAcessosState();
}

class _ListaAcessosState extends State<_ListaAcessos> {
  late VisualizarAcessosController _ctrl;
  late AcessosController _acessosCtrl;
  final List<Worker> _workers = [];

  @override
  void initState() {
    super.initState();
    _ctrl = Get.put(VisualizarAcessosController());
    _acessosCtrl = Get.put(AcessosController());
    _workers.add(ever(_ctrl.acessos, (_) {
      if (mounted) setState(() {});
    }));
    _workers.add(ever(_ctrl.isLoading, (_) {
      if (mounted) setState(() {});
    }));
    _workers.add(ever(_ctrl.searchResult, (_) {
      if (mounted) setState(() {});
    }));
  }

  @override
  void dispose() {
    for (final w in _workers) w.dispose();
    super.dispose();
  }

  List<dynamic> _buildItems(List list) {
    final List<dynamic> items = [];
    String lastGroup = '';
    for (final a in list) {
      final group = _groupLabel(a.datahora);
      if (group != lastGroup) {
        items.add(group);
        lastGroup = group;
      }
      items.add(a);
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    final list =
        (_ctrl.searchResult.isNotEmpty || _ctrl.search.value.text.isNotEmpty)
            ? _ctrl.searchResult.toList()
            : _ctrl.acessos.toList();

    final items = _buildItems(list);
    final textColor = Theme.of(context).textSelectionTheme.selectionColor!;

    // ListView é filho DIRETO do SmartRefresher para o RefreshPhysics funcionar
    return SmartRefresher(
      controller: _ctrl.refreshController,
      enablePullUp: true,
      onRefresh: _ctrl.onRefresh,
      onLoading: _ctrl.onLoading,
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 16),
        itemCount: _ctrl.isLoading.value && list.isEmpty
            ? 1
            : list.isEmpty
                ? 1
                : items.length,
        itemBuilder: (context, i) {
          // ── Loading inicial ──
          if (_ctrl.isLoading.value && list.isEmpty) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 4,
                  valueColor: AlwaysStoppedAnimation<Color>(textColor),
                ),
              ),
            );
          }

          // ── Sem registros ──
          if (list.isEmpty) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: Center(
                child: Text(
                  'Sem registros',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ),
            );
          }

          final item = items[i];

          // ── Cabeçalho de seção ──
          if (item is String) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 6),
              child: Text(
                item,
                style: GoogleFonts.montserrat(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                  color: textColor.withValues(alpha: 0.6),
                ),
              ),
            );
          }

          // ── Card de acesso ──
          final a = item;
          final bool isSaida = a.tipoacesso == 'SAIDA';
          final bool isFacial = a.ctlfacial == '1';
          final bool isVehicleMovement = a.acessotipo == 'VEICULO';
          final bool isPortariaRecord = a.foiportaria == '1';
          final bool isVehicleApiRecord =
              !isFacial && isVehicleMovement && a.placa.trim().isNotEmpty;
          final String previewUrl =
              isVehicleApiRecord ? '' : _imageUrl(a.imgfacial, a.tipopessoa);
          final IconData leadingIcon = isVehicleApiRecord
              ? Icons.directions_car_filled_outlined
              : _personTypeIcon(a.tipopessoa);

          final String hora =
              a.dataent.trim().isNotEmpty && a.dataent.trim() != ' '
                  ? _hourLabel(a.dataent)
                  : _hourLabel(a.datahora);

          return GestureDetector(
            onTap: () {
              _acessosCtrl.idAce.value = a.idace;
              _acessosCtrl.idfav.value = a.idfav;
              _acessosCtrl.tel.value = a.cel;
              _acessosCtrl.name.value.text = a.pessoa;
              _acessosCtrl.idvis.value = a.idvis;
              configurandoModalBottomSheet(
                context,
                a.pessoa,
                a.placa,
                a.tipodoc,
                a.documento,
                a.idfav,
                a.dataent,
                a.cel,
                a.tipopessoa,
                a.idconv,
                a.imgfacial,
                a.idvis,
                '1',
                'facialacesso',
                datasai: a.datasai,
                portao: a.portao,
                tipoacesso: a.tipoacesso,
                acessotipo: a.acessotipo,
                ctlfacial: a.ctlfacial,
                imgplaca: a.imgplaca,
                agenteportaria: a.agenteportaria,
                foiportaria: a.foiportaria,
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2)),
                ],
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                child: Row(
                  children: [
                    // Avatar
                    ClipOval(
                      child: SizedBox(
                        width: 52,
                        height: 52,
                        child: previewUrl.isEmpty
                            ? Container(
                                color: Theme.of(context).primaryColorDark,
                                alignment: Alignment.center,
                                child: Icon(
                                  leadingIcon,
                                  size: 28,
                                  color: textColor,
                                ),
                              )
                            : Image.network(
                                previewUrl,
                                fit: BoxFit.cover,
                                loadingBuilder: (_, child, progress) =>
                                    progress == null
                                        ? child
                                        : Container(
                                            color: Theme.of(context)
                                                .primaryColorDark,
                                            alignment: Alignment.center,
                                            child: const SizedBox(
                                              width: 20,
                                              height: 20,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(Colors.white),
                                              ),
                                            ),
                                          ),
                                errorBuilder: (_, __, ___) => Container(
                                  color: Theme.of(context).primaryColorDark,
                                  alignment: Alignment.center,
                                  child: Icon(
                                    leadingIcon,
                                    size: 28,
                                    color: textColor,
                                  ),
                                ),
                              ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    // Infos principais
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            a.pessoa,
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
                              color: _actorBadgeColor(a.tipopessoa)
                                  .withValues(alpha: 0.18),
                              borderRadius: BorderRadius.circular(999),
                              border: Border.all(
                                color: _actorBadgeColor(a.tipopessoa)
                                    .withValues(alpha: 0.45),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  _actorBadgeIcon(a.tipopessoa),
                                  size: 12,
                                  color: _actorBadgeColor(a.tipopessoa),
                                ),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: Text(
                                    _actorBadgeLabel(a.tipopessoa),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: _actorBadgeColor(a.tipopessoa),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            hora,
                            style: GoogleFonts.montserrat(
                              fontSize: 11,
                              color: textColor.withValues(alpha: 0.55),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Ícones + portão
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            if (isVehicleApiRecord) ...[
                              Icon(Icons.videocam_outlined,
                                  size: 18, color: textColor),
                              const SizedBox(width: 4),
                              Icon(
                                  isVehicleMovement
                                      ? Icons.time_to_leave_outlined
                                      : Icons.directions_walk,
                                  size: 18,
                                  color: textColor),
                              const SizedBox(width: 4),
                            ] else ...[
                              isPortariaRecord
                                  ? Icon(Icons.verified_user_outlined,
                                      size: 18, color: textColor)
                                  : isFacial
                                      ? Icon(Icons.face_5_sharp,
                                          size: 18, color: textColor)
                                      : Icon(Icons.verified_user_outlined,
                                          size: 18, color: textColor),
                              const SizedBox(width: 4),
                              Icon(
                                isVehicleMovement
                                    ? Icons.time_to_leave_outlined
                                    : Icons.directions_walk,
                                size: 18,
                                color: textColor,
                              ),
                              const SizedBox(width: 4),
                            ],
                            isSaida
                                ? Icon(Icons.logout_outlined,
                                    size: 18, color: Colors.redAccent)
                                : Icon(Icons.login_outlined,
                                    size: 18, color: Colors.greenAccent),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${a.tipoacesso} ${a.portao}'.trim(),
                          style: GoogleFonts.montserrat(
                            fontSize: 10,
                            color: textColor.withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(width: 4),
                    Icon(Icons.chevron_right,
                        color: textColor.withValues(alpha: 0.4), size: 20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
