import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../controllers/login_controller.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onTap;
  final String? image;

  // Tamanhos/espaços
  static const double _logoSize =
      120; // altura do bloco da logo (como você usava)
  static const double _helloHeight = 26; // ~1 linha de texto
  static const double _gapBelowRow =
      2; // espaço visual entre a linha do menu+logo e o "Olá"
  static const double _vPadTop = 0; // padding interno superior
  static const double _vPadBottom =
      8; // padding interno inferior (pequeno respiro)

  const AppBarWidget({
    Key? key,
    this.onTap,
    this.image = '',
  }) : super(key: key);

  // Altura EXPLODIDA do AppBar = logo + linha "Olá" + paddings + gap
  @override
  Size get preferredSize => const Size.fromHeight(
      _logoSize + _helloHeight + _vPadTop + _vPadBottom + _gapBelowRow);

  // Escolhe ícones claros/escuros do status bar conforme fundo
  SystemUiOverlayStyle _overlayFor(Color bg) {
    final isLightBg = bg.computeLuminance() > 0.5;
    return (isLightBg ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light)
        .copyWith(statusBarColor: Colors.transparent);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bg = theme.scaffoldBackgroundColor;
    final fg =
        theme.textSelectionTheme.selectionColor ?? theme.colorScheme.onSurface;

    final loginController = Get.find<LoginController>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: _overlayFor(bg),
      child: Material(
        color: bg,
        elevation: 0,
        child: SafeArea(
          top: true,
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0)
                .copyWith(top: _vPadTop, bottom: _vPadBottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Linha: Menu à esquerda + Logomarca centralizada
                SizedBox(
                  height: _logoSize,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          icon: Icon(Icons.menu, color: fg, size: 28),
                          onPressed: onTap,
                          tooltip: 'Menu',
                        ),
                      ),
                      // Logo centralizada e grande (como estava)
                      SizedBox(
                        height: _logoSize *
                            0.65, // fator para ocupar bem sem estourar
                        child: (image != null && image!.isNotEmpty)
                            ? Image.network(
                                'https://www.condosocio.com.br/acond/downloads/logocondo/$image',
                                fit: BoxFit.contain,
                              )
                            : Icon(Icons.apartment, size: 48, color: fg),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: _gapBelowRow),

                // “Olá, …” (fica entre a linha acima e o próximo conteúdo)
                // “Olá, …” (fica entre a linha acima e o próximo conteúdo)
                SizedBox(
                  height: _helloHeight,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    // ajuste fino: se seus SliverGrid têm padding: EdgeInsets.all(20),
                    // use também left: 20 aqui para casar perfeitamente.
                    child: Obx(() {
                      final nome = loginController.nome.value.trim();
                      final primeiroNome =
                          nome.isEmpty ? '' : nome.split(' ').first;
                      return Text(
                        'Olá, $primeiroNome',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          letterSpacing: .3,
                          height: 1.2,
                          color: fg,
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
