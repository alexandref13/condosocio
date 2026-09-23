import 'package:condosocio/src/controllers/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Modal quase em tela cheia com a imagem do banner "Home Modal" e um botão
/// no rodapé que redireciona para `URL_LOCAL`.
Future<void> showBannerModalHome(
  BuildContext context,
  Map<String, String> banner,
) {
  return showGeneralDialog<void>(
    context: context,
    barrierDismissible: false,
    barrierLabel: 'Fechar',
    barrierColor: Colors.black.withValues(alpha: 0.6),
    transitionDuration: const Duration(milliseconds: 250),
    pageBuilder: (_, __, ___) => _BannerModalHome(banner: banner),
    transitionBuilder: (_, animation, __, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}

class _BannerModalHome extends StatelessWidget {
  const _BannerModalHome({required this.banner});

  final Map<String, String> banner;

  static const String _textoBotaoPadrao = 'Saiba mais';
  static const Color _fundoCard = Color(0xFFE6F5FA);
  static const List<Color> _gradienteBotao = [
    Color(0xFF3C9E9B),
    Color(0xFF2F69AC),
  ];

  Future<void> _abrirDestino(BuildContext context) async {
    final destino = (banner['urlLocal'] ?? '').trim();
    Navigator.of(context).pop();

    if (destino.isEmpty) return;

    if (destino.startsWith('http://') || destino.startsWith('https://')) {
      await Get.find<HomePageController>().launchInAppBrowser(destino);
      return;
    }

    Get.toNamed(destino.startsWith('/') ? destino : '/$destino');
  }

  @override
  Widget build(BuildContext context) {
    final texto = (banner['botao'] ?? '').trim();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: ColoredBox(
              color: _fundoCard,
              child: Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Image.network(
                            banner['imgUrl'] ?? '',
                            fit: BoxFit.contain,
                            width: double.infinity,
                            loadingBuilder: (_, child, progress) =>
                                progress == null
                                    ? child
                                    : const SizedBox(
                                        height: 240,
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      ),
                            errorBuilder: (_, __, ___) => const SizedBox(
                              height: 240,
                              child: Center(
                                child: Icon(
                                  Icons.broken_image_outlined,
                                  color: Colors.black38,
                                  size: 64,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(28, 4, 28, 20),
                          child: _BotaoGradiente(
                            texto: texto.isEmpty ? _textoBotaoPadrao : texto,
                            gradiente: _gradienteBotao,
                            onPressed: () => _abrirDestino(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Material(
                      color: const Color(0xFFEDEDF0),
                      shape: const CircleBorder(),
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        onTap: () => Navigator.of(context).pop(),
                        child: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.close,
                            size: 22,
                            color: Color(0xFF3A3A3C),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BotaoGradiente extends StatelessWidget {
  const _BotaoGradiente({
    required this.texto,
    required this.gradiente,
    required this.onPressed,
  });

  final String texto;
  final List<Color> gradiente;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(32),
      clipBehavior: Clip.antiAlias,
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: gradiente),
        ),
        child: InkWell(
          onTap: onPressed,
          child: SizedBox(
            height: 58,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    texto,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.chevron_right, color: Colors.white, size: 28),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
