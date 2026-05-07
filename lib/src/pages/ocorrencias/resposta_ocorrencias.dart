import 'package:condosocio/src/components/utils/alert_button_pressed.dart';
import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:condosocio/src/controllers/ocorrencias/resposta_ocorrencias_controller.dart';
import 'package:condosocio/src/controllers/ocorrencias/visualizar_ocorrencias_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RespostaOcorrencias extends StatefulWidget {
  const RespostaOcorrencias({super.key});

  @override
  State<RespostaOcorrencias> createState() => _RespostaOcorrenciasState();
}

class _RespostaOcorrenciasState extends State<RespostaOcorrencias> {
  late final FocusNode _replyFocusNode;

  @override
  void initState() {
    super.initState();
    _replyFocusNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _replyFocusNode.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    _replyFocusNode.dispose();
    super.dispose();
  }

  String _formatDateTime(String data, String hora) {
    final cleanDate = data.trim();
    final cleanHour = hora.trim();
    if (cleanDate.isEmpty && cleanHour.isEmpty) return '';
    if (cleanHour.isEmpty) return cleanDate;
    return '$cleanDate ${cleanHour.endsWith('h') ? cleanHour : '${cleanHour}h'}';
  }

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.put(LoginController());
    final RespostaOcorrenciasController respostaOcorrenciasController =
        Get.put(RespostaOcorrenciasController());
    final VisualizarOcorrenciasController ocorrenciasController =
        Get.put(VisualizarOcorrenciasController());

    final textColor =
        Theme.of(context).textSelectionTheme.selectionColor ?? Colors.white;
    final isResolved = ocorrenciasController.status.value != '0';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios, color: textColor),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ocorrenciasController.titulo.value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.montserrat(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
            ),
            Text(
              ocorrenciasController.tipo.value,
              style: GoogleFonts.montserrat(
                fontSize: 11,
                color: textColor.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
      body: Obx(() {
        if (respostaOcorrenciasController.isLoading.value) {
          return CircularProgressIndicatorWidget();
        }

        final respostas = respostaOcorrenciasController.resposta.toList();

        return Column(
          children: [
            _OcorrenciaResumoCard(
              isResolved: isResolved,
              textColor: textColor,
              ocorrenciasController: ocorrenciasController,
            ),
            Expanded(
              child: respostas.isEmpty
                  ? Center(
                      child: Text(
                        'Nenhuma resposta ainda.',
                        style: GoogleFonts.montserrat(
                          fontSize: 13,
                          color: textColor.withValues(alpha: 0.7),
                        ),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(12, 6, 12, 96),
                      itemCount: respostas.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (_, i) {
                        final resposta = respostas[i];
                        final isRoot = resposta.idraiz.trim().isNotEmpty;
                        final isMine = isRoot ||
                            resposta.idusu == loginController.id.value;

                        final nome = isRoot
                            ? loginController.nome.value
                            : resposta.nomeusu;
                        final tipo = isRoot
                            ? loginController.tipo.value
                            : resposta.tipousu;
                        final texto = isRoot
                            ? ocorrenciasController.descricao.value
                            : resposta.texto;
                        final dataHora = isRoot
                            ? _formatDateTime(
                                resposta.dataraiz,
                                resposta.horaraiz,
                              )
                            : _formatDateTime(
                                resposta.data,
                                resposta.hora,
                              );
                        final imgPerfil = isRoot
                            ? loginController.imgperfil.value
                            : resposta.imgperfil;

                        return _RespostaBubbleCard(
                          isMine: isMine,
                          nome: nome,
                          tipo: tipo,
                          texto: texto,
                          dataHora: dataHora,
                          imgPerfil: imgPerfil,
                          textColor: textColor,
                        );
                      },
                    ),
            ),
          ],
        );
      }),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        color: Theme.of(context).primaryColor,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Theme.of(context).textSelectionTheme.selectionColor!,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  focusNode: _replyFocusNode,
                  controller: respostaOcorrenciasController.texto.value,
                  textCapitalization: TextCapitalization.sentences,
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Envie uma resposta',
                    hintStyle: GoogleFonts.montserrat(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                iconSize: 25,
                color: Theme.of(context).colorScheme.secondary,
                onPressed: () {
                  respostaOcorrenciasController
                      .sendOcorrenciaResp()
                      .then((value) {
                    if (value == 0) {
                      onAlertButtonPressed(
                        context,
                        'Algo deu errado\n Tente novamente',
                        '/home',
                        'images/error.png',
                      );
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OcorrenciaResumoCard extends StatelessWidget {
  final bool isResolved;
  final Color textColor;
  final VisualizarOcorrenciasController ocorrenciasController;

  const _OcorrenciaResumoCard({
    required this.isResolved,
    required this.textColor,
    required this.ocorrenciasController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 12, 12, 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isResolved
                      ? Colors.green.withValues(alpha: 0.15)
                      : Colors.orange.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isResolved
                        ? Colors.green.withValues(alpha: 0.5)
                        : Colors.orange.withValues(alpha: 0.5),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isResolved
                          ? Icons.check_circle_outline
                          : Icons.pending_outlined,
                      size: 13,
                      color: isResolved ? Colors.green : Colors.orange,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      isResolved ? 'Resolvida' : 'Pendente',
                      style: GoogleFonts.montserrat(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: isResolved ? Colors.green : Colors.orange,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              if (ocorrenciasController.imagem.value.isNotEmpty)
                GestureDetector(
                  onTap: () => Get.toNamed('/fotoOcorrencia'),
                  child: Hero(
                    transitionOnUserGestures: true,
                    tag: 'FotoOcorrencia',
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            'https://www.condosocio.com.br/acond/downloads/ocorrencias/${ocorrenciasController.imagem.value}',
                            width: 62,
                            height: 62,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              width: 62,
                              height: 62,
                              decoration: BoxDecoration(
                                color: Colors.grey.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.broken_image_outlined,
                                color: Colors.grey,
                                size: 26,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 3,
                          bottom: 3,
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: const Icon(
                              Icons.zoom_in,
                              color: Colors.white,
                              size: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                Icons.event_outlined,
                size: 15,
                color: textColor.withValues(alpha: 0.6),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  '${ocorrenciasController.dataoco.value} às ${ocorrenciasController.houroco.value}h',
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    color: textColor.withValues(alpha: 0.85),
                  ),
                ),
              ),
            ],
          ),
          if (ocorrenciasController.descricao.value.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                ocorrenciasController.descricao.value,
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  color: textColor.withValues(alpha: 0.75),
                  height: 1.5,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _RespostaBubbleCard extends StatelessWidget {
  final bool isMine;
  final String nome;
  final String tipo;
  final String texto;
  final String dataHora;
  final String imgPerfil;
  final Color textColor;

  const _RespostaBubbleCard({
    required this.isMine,
    required this.nome,
    required this.tipo,
    required this.texto,
    required this.dataHora,
    required this.imgPerfil,
    required this.textColor,
  });

  String _profileUrl(String imageName) {
    if (imageName.trim().isEmpty) return '';
    return 'https://www.condosocio.com.br/acond/downloads/fotosperfil/$imageName';
  }

  @override
  Widget build(BuildContext context) {
    final bubbleColor = isMine
        ? Colors.green.shade600
        : Theme.of(context).colorScheme.secondary.withValues(alpha: 0.92);
    final alignment = isMine ? MainAxisAlignment.end : MainAxisAlignment.start;
    final borderRadius = BorderRadius.circular(24);
    final subtitleText = tipo.trim().isEmpty ? ' ' : tipo;

    return Row(
      mainAxisAlignment: alignment,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.88,
          ),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: bubbleColor,
              borderRadius: borderRadius,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!isMine) ...[
                  _RespostaAvatar(
                    imgPerfil: imgPerfil,
                    textColor: textColor,
                  ),
                  const SizedBox(width: 10),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  nome.trim().isEmpty ? 'Usuário' : nome,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: textColor,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: Text(
                                    subtitleText,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 10,
                                      color: textColor.withValues(alpha: 0.75),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            dataHora,
                            textAlign: TextAlign.right,
                            style: GoogleFonts.montserrat(
                              fontSize: 10,
                              color: textColor.withValues(alpha: 0.72),
                            ),
                          ),
                        ],
                      ),
                      if (texto.trim().isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            texto,
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              color: textColor,
                              height: 1.45,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                if (isMine) ...[
                  const SizedBox(width: 10),
                  _RespostaAvatar(
                    imgPerfil: imgPerfil,
                    textColor: textColor,
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _RespostaAvatar extends StatelessWidget {
  final String imgPerfil;
  final Color textColor;

  const _RespostaAvatar({
    required this.imgPerfil,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = imgPerfil.trim().isEmpty
        ? ''
        : 'https://www.condosocio.com.br/acond/downloads/fotosperfil/$imgPerfil';

    return ClipOval(
      child: Container(
        width: 46,
        height: 46,
        color: Theme.of(context).primaryColorDark.withValues(alpha: 0.25),
        child: imageUrl.isEmpty
            ? Icon(Icons.person, color: textColor, size: 26)
            : Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    Icon(Icons.person, color: textColor, size: 26),
              ),
      ),
    );
  }
}
