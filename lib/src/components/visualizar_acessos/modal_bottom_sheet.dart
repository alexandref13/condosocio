import 'package:condosocio/src/components/utils/alert_button_pressed.dart';
import 'package:condosocio/src/components/utils/delete_alert.dart';
import 'package:condosocio/src/components/utils/edge_alert_widget.dart';
import 'package:condosocio/src/controllers/acessos/acessos_controller.dart';
import 'package:condosocio/src/controllers/acessos/visualizar_acessos_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/acessos/acessos_controller_espera.dart';
import '../../controllers/esperaacessos/visualizar_acessos_espera_controller.dart';

String _vehicleCaptureUrl(String imgplaca) {
  if (imgplaca.trim().isEmpty) return '';
  return 'https://www.condosocio.com.br/acond/downloads/placas/$imgplaca';
}

void configurandoModalBottomSheet(
  context,
  String pessoa,
  String placa,
  String tipoDoc,
  String documento,
  String idFav,
  String dataEntrada,
  String cel,
  String tipo,
  String idConv,
  String imgfacial,
  String idvis,
  String espera,
  String heroTag, {
  String datasai = '',
  String portao = '',
  String tipoacesso = '',
  String acessotipo = '',
  String ctlfacial = '',
  String imgplaca = '',
  String agenteportaria = '',
  String foiportaria = '',
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).colorScheme.secondary,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (BuildContext bc) {
      final AcessosController acessosController = Get.put(AcessosController());
      final AcessosEsperaController acessosEsperaController =
          Get.put(AcessosEsperaController());
      final VisualizarAcessosEsperaController
          visualizarAcessosEsperaController =
          Get.put(VisualizarAcessosEsperaController());
      final VisualizarAcessosController visualizarAcessosController =
          Get.put(VisualizarAcessosController());

      acessosController.name.value.text = pessoa;
      acessosController.tel.value = cel;

      if (idFav == "0") {
        visualizarAcessosController.fav.value = false;
      } else {
        visualizarAcessosController.fav.value = true;
      }

      final textColor =
          Theme.of(context).textSelectionTheme.selectionColor ?? Colors.white;
      final bool isFacial = ctlfacial == '1';
      final bool hasEntry =
          dataEntrada.trim().isNotEmpty && dataEntrada.trim() != ' ';
      final bool hasSaida = datasai.trim().isNotEmpty && datasai.trim() != ' ';
      final bool hasDoc = documento.trim().isNotEmpty;
      final bool hasPlaca = placa.trim().isNotEmpty;
      final bool hasCel = cel.trim().isNotEmpty;
      final bool hasVehicleCapture = imgplaca.trim().isNotEmpty;
      final bool isVeiculo = acessotipo == 'VEICULO';
      final bool isPortariaRecord =
          foiportaria == '1' || agenteportaria.trim().isNotEmpty;
      final double infoItemWidth =
          (MediaQuery.of(context).size.width - 32 - 10) / 2;

      final infoTiles = <Widget>[
        if (hasDoc)
          _InfoTile(
            icon: Icons.badge_outlined,
            label: tipoDoc.trim().isNotEmpty ? tipoDoc : 'Documento',
            value: documento,
            textColor: textColor,
          ),
        if (hasPlaca)
          _InfoTile(
            icon: Icons.directions_car_outlined,
            label: 'Veículo',
            value: placa,
            textColor: textColor,
          ),
        if (hasCel && !hasVehicleCapture)
          _InfoTile(
            icon: Icons.phone_outlined,
            label: 'Telefone',
            value: cel,
            textColor: textColor,
          ),
        if (agenteportaria.trim().isNotEmpty)
          _InfoTile(
            icon: Icons.verified_user_outlined,
            label: 'Agente de Portaria',
            value: agenteportaria,
            textColor: textColor,
          ),
      ];

      // Badge color por tipo pessoa
      Color badgeColor;
      String badgeLabel;
      final tipoLower = tipo.toLowerCase();
      if (tipoLower.contains('convidado')) {
        badgeColor = Colors.blueAccent;
        badgeLabel = 'CONVIDADO';
      } else if (tipoLower.contains('prestador')) {
        badgeColor = Colors.orange;
        badgeLabel = 'PRESTADOR';
      } else if (tipoLower.contains('app mobilidade')) {
        badgeColor = Colors.purple;
        badgeLabel = 'APP MOBILIDADE';
      } else if (['morador', 'inquilino', 'nm', 'proprietario', 'sindico']
          .any((t) => tipoLower.contains(t))) {
        badgeColor = Colors.green;
        badgeLabel = 'MORADOR(A)';
      } else {
        badgeColor = Colors.blueGrey;
        badgeLabel = tipo.toUpperCase();
      }

      return SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Puxador
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white38,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),

              // Foto + Badge + Nome centralizados
              Center(
                child: Column(
                  children: [
                    if (imgfacial.trim().isNotEmpty &&
                        badgeLabel != 'MORADOR(A)')
                      _ProfilePhoto(
                          imgfacial: imgfacial,
                          tipopessoa: tipo,
                          textColor: textColor),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: badgeColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: badgeColor.withValues(alpha: 0.5)),
                      ),
                      child: Text(
                        badgeLabel,
                        style: GoogleFonts.montserrat(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: badgeColor,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      pessoa,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),
              Divider(color: Colors.blueGrey.shade300, height: 1),
              const SizedBox(height: 12),

              // Entrada — só mostra se o registro é de ENTRADA
              if (hasEntry && tipoacesso == 'ENTRADA')
                _AccessInfoRow(
                  icon: isVeiculo ? Icons.time_to_leave : Icons.login_outlined,
                  iconColor: Colors.greenAccent,
                  label: 'Entrada',
                  dateTime: dataEntrada.trim(),
                  portao: portao.trim(),
                  textColor: textColor,
                ),

              // Saída — só mostra se o registro é de SAÍDA
              if (hasSaida && tipoacesso == 'SAIDA')
                _AccessInfoRow(
                  icon: isVeiculo
                      ? Icons.time_to_leave_outlined
                      : Icons.logout_outlined,
                  iconColor: Colors.redAccent,
                  label: 'Saída',
                  dateTime: datasai.trim(),
                  portao: portao.trim(),
                  textColor: textColor,
                ),

              if (infoTiles.isNotEmpty) ...[
                const SizedBox(height: 6),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: infoTiles
                      .map((tile) => SizedBox(
                            width: infoItemWidth,
                            child: tile,
                          ))
                      .toList(),
                ),
                const SizedBox(height: 16),
              ] else
                const SizedBox(height: 16),

              if (hasVehicleCapture)
                _VehicleCapturePhoto(
                  imgplaca: imgplaca,
                  textColor: textColor,
                ),

              // Foto do reconhecimento facial inline
              if (isFacial && !isPortariaRecord)
                _FacialEventPhoto(
                  idace: acessosController.idAce.value,
                  textColor: textColor,
                ),

              // Botão favorito (apenas Convidado com entrada)
              if (hasEntry && tipo == 'Convidado')
                Obx(() => _ActionButton(
                      icon: visualizarAcessosController.fav.value
                          ? Icons.favorite
                          : Icons.favorite_border,
                      label: visualizarAcessosController.fav.value
                          ? 'Remover Favorito'
                          : 'Adicionar aos Favoritos',
                      color: Theme.of(context).colorScheme.secondary,
                      textColor: textColor,
                      onTap: () async {
                        visualizarAcessosController.fav.value =
                            !visualizarAcessosController.fav.value;
                        await visualizarAcessosController
                            .sendFavorite(visualizarAcessosController.fav.value)
                            .then((_) {
                          visualizarAcessosController.getAcessos();
                          acessosController.getFavoritos();
                        });
                      },
                    )),

              // Botão excluir (apenas quando ainda sem entrada registrada)
              if (!hasEntry)
                _ActionButton(
                  icon: Icons.delete_outline,
                  label: 'Excluir Acesso',
                  color: Theme.of(context).colorScheme.error,
                  textColor: Colors.white,
                  onTap: () {
                    deleteAlert(context, 'Deseja excluir o acesso?', () {
                      if (espera == '1') {
                        acessosController.deleteAcesso(espera).then((value) {
                          if (value == 1) {
                            visualizarAcessosController.getAcessos();
                            showToast(context, 'Parabéns!',
                                'Acesso excluído com sucesso.');
                            Get.back();
                            Get.back();
                          } else if (value == 2) {
                            onAlertButtonPressed(
                                context,
                                'Esse acesso já possui registro de entrada ou saída e não pode ser excluído.',
                                '',
                                'images/error.png');
                          } else {
                            onAlertButtonPressed(
                                context,
                                'Algo deu errado\nTente novamente',
                                '/home',
                                'images/error.png');
                          }
                        });
                      } else {
                        acessosEsperaController
                            .deleteAcesso(espera)
                            .then((value) {
                          if (value == 1) {
                            visualizarAcessosEsperaController
                                .getAcessosEspera();
                            showToast(context, 'Parabéns!',
                                'Acesso excluído com sucesso.');
                            Get.back();
                            Get.back();
                          } else if (value == 2) {
                            onAlertButtonPressed(
                                context,
                                'Esse acesso já possui registro de entrada ou saída e não pode ser excluído.',
                                '',
                                'images/error.png');
                          } else {
                            onAlertButtonPressed(
                                context,
                                'Algo deu errado\nTente novamente',
                                '/home',
                                'images/error.png');
                          }
                        });
                      }
                    });
                  },
                ),

              const SizedBox(height: 8),
            ],
          ),
        ),
      );
    },
  );
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final String label;
  final String value;
  final Color textColor;
  final CrossAxisAlignment contentAlignment;
  final TextAlign valueTextAlign;
  final int? valueMaxLines;

  const _InfoRow({
    required this.icon,
    this.iconColor,
    required this.label,
    required this.value,
    required this.textColor,
    this.contentAlignment = CrossAxisAlignment.start,
    this.valueTextAlign = TextAlign.start,
    this.valueMaxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon,
              size: 18, color: iconColor ?? textColor.withValues(alpha: 0.6)),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.montserrat(
                  fontSize: 11,
                  color: textColor.withValues(alpha: 0.55),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 1),
              Text(
                value,
                maxLines: valueMaxLines,
                overflow: valueMaxLines != null ? TextOverflow.ellipsis : null,
                style: GoogleFonts.montserrat(
                  fontSize: 13,
                  color: textColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final String label;
  final String value;
  final Color textColor;

  const _InfoTile({
    required this.icon,
    this.iconColor,
    required this.label,
    required this.value,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 18,
            color: iconColor ?? textColor.withValues(alpha: 0.7),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.montserrat(
                    fontSize: 10,
                    color: textColor.withValues(alpha: 0.55),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.4,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    color: textColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AccessInfoRow extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final String label;
  final String dateTime;
  final String portao;
  final Color textColor;

  const _AccessInfoRow({
    required this.icon,
    this.iconColor,
    required this.label,
    required this.dateTime,
    required this.portao,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final gateText = portao.isNotEmpty ? 'Portão $portao' : '';
    final accessText = gateText.isNotEmpty ? '$label  $gateText' : label;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: _AccessInfoChip(
              icon: icon,
              iconColor: iconColor ?? textColor.withValues(alpha: 0.6),
              label: accessText,
              textColor: textColor,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _AccessInfoChip(
              icon: Icons.calendar_today_outlined,
              iconColor: textColor.withValues(alpha: 0.6),
              label: dateTime,
              textColor: textColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _AccessInfoChip extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final Color textColor;

  const _AccessInfoChip({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(icon, size: 16, color: iconColor),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontSize: 12,
                color: textColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color textColor;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          icon: Icon(icon, color: textColor, size: 18),
          label: Text(
            label,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
          onPressed: onTap,
        ),
      ),
    );
  }
}

class _ProfilePhoto extends StatelessWidget {
  final String imgfacial;
  final String tipopessoa;
  final Color textColor;

  const _ProfilePhoto(
      {required this.imgfacial,
      required this.tipopessoa,
      required this.textColor});

  String get _url {
    final isMorador = [
      'Morador',
      'Prestador',
      'Inquilino',
      'NM',
      'Prestador de Serviço',
      'Administrador',
      'Sindico',
      'Master'
    ].contains(tipopessoa);
    final folder = isMorador ? 'fotosperfil' : 'fotosvisitantes';
    return 'https://www.condosocio.com.br/acond/downloads/$folder/$imgfacial';
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              barrierColor: Colors.black87,
              builder: (_) => Dialog(
                backgroundColor: Colors.transparent,
                insetPadding: const EdgeInsets.all(32),
                child: Stack(
                  children: [
                    InteractiveViewer(
                      minScale: 0.5,
                      maxScale: 5,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          _url,
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        icon: const Icon(Icons.close,
                            color: Colors.white, size: 28),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          child: Stack(
            children: [
              ClipOval(
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: Image.network(
                    _url,
                    fit: BoxFit.cover,
                    loadingBuilder: (_, child, progress) => progress == null
                        ? child
                        : Container(
                            color: Theme.of(context).primaryColorDark,
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(textColor),
                            ),
                          ),
                    errorBuilder: (_, __, ___) => Container(
                      color: Theme.of(context).primaryColorDark,
                      alignment: Alignment.center,
                      child: Icon(Icons.person, size: 36, color: textColor),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child:
                      const Icon(Icons.zoom_in, color: Colors.white, size: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FacialEventPhoto extends StatelessWidget {
  final String idace;
  final Color textColor;

  const _FacialEventPhoto({required this.idace, required this.textColor});

  @override
  Widget build(BuildContext context) {
    if (idace.isEmpty || idace == '0') return const SizedBox.shrink();

    final url =
        'https://www.condosocio.com.br/acond/ajax/getFaceImage.php?idace=$idace&tipo=evento';

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Captura do reconhecimento',
            style: GoogleFonts.montserrat(
              fontSize: 11,
              color: textColor.withValues(alpha: 0.55),
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  barrierColor: Colors.black87,
                  builder: (_) => Dialog(
                    backgroundColor: Colors.transparent,
                    insetPadding: const EdgeInsets.all(16),
                    child: Stack(
                      children: [
                        InteractiveViewer(
                          minScale: 0.5,
                          maxScale: 5,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              url,
                              fit: BoxFit.contain,
                              errorBuilder: (_, __, ___) =>
                                  const SizedBox.shrink(),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: IconButton(
                            icon: const Icon(Icons.close,
                                color: Colors.white, size: 28),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      url,
                      width: 200,
                      fit: BoxFit.cover,
                      loadingBuilder: (_, child, progress) => progress == null
                          ? child
                          : SizedBox(
                              width: 200,
                              height: 150,
                              child: Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor:
                                      AlwaysStoppedAnimation<Color>(textColor),
                                ),
                              ),
                            ),
                      errorBuilder: (_, __, ___) => Container(
                        width: 200,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.no_photography_outlined,
                                size: 32,
                                color: textColor.withValues(alpha: 0.4)),
                            const SizedBox(height: 6),
                            Text(
                              'Sem imagem da captura',
                              style: GoogleFonts.montserrat(
                                fontSize: 11,
                                color: textColor.withValues(alpha: 0.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(Icons.zoom_in,
                          color: Colors.white, size: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _VehicleCapturePhoto extends StatelessWidget {
  final String imgplaca;
  final Color textColor;

  const _VehicleCapturePhoto({
    required this.imgplaca,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final url = _vehicleCaptureUrl(imgplaca);
    if (url.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Captura do veículo',
            style: GoogleFonts.montserrat(
              fontSize: 11,
              color: textColor.withValues(alpha: 0.55),
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  barrierColor: Colors.black87,
                  builder: (_) => Dialog(
                    backgroundColor: Colors.transparent,
                    insetPadding: const EdgeInsets.all(16),
                    child: Stack(
                      children: [
                        InteractiveViewer(
                          minScale: 0.5,
                          maxScale: 5,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              url,
                              fit: BoxFit.contain,
                              errorBuilder: (_, __, ___) =>
                                  const SizedBox.shrink(),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: IconButton(
                            icon: const Icon(Icons.close,
                                color: Colors.white, size: 28),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      url,
                      width: 200,
                      fit: BoxFit.cover,
                      loadingBuilder: (_, child, progress) => progress == null
                          ? child
                          : SizedBox(
                              width: 200,
                              height: 150,
                              child: Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor:
                                      AlwaysStoppedAnimation<Color>(textColor),
                                ),
                              ),
                            ),
                      errorBuilder: (_, __, ___) => Container(
                        width: 200,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.no_photography_outlined,
                                size: 32,
                                color: textColor.withValues(alpha: 0.4)),
                            const SizedBox(height: 6),
                            Text(
                              'Sem imagem da captura',
                              style: GoogleFonts.montserrat(
                                fontSize: 11,
                                color: textColor.withValues(alpha: 0.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(Icons.zoom_in,
                          color: Colors.white, size: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
