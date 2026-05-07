import 'package:condosocio/src/controllers/convites/convites_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CondoNavBar extends StatelessWidget {
  /// Index of the currently active tab (-1 = none).
  /// 0=Usuários 1=Senha 2=Menu 3=Convites 4=Acessos
  final int activeIndex;

  /// When provided, the center Menu button calls this instead of /home.
  final VoidCallback? onMenuTap;

  const CondoNavBar({super.key, this.activeIndex = -1, this.onMenuTap});

  void _handleTap(int index) {
    final cc = Get.find<ConvitesController>();
    switch (index) {
      case 0:
        if (Get.currentRoute != '/dependentes') Get.offNamed('/dependentes');
        break;
      case 1:
        if (Get.currentRoute != '/senha') Get.offNamed('/senha');
        break;
      case 2:
        if (onMenuTap != null) {
          onMenuTap!();
        } else {
          Get.offAllNamed('/home');
        }
        break;
      case 3:
        if (Get.currentRoute != '/alvoTv') Get.offNamed('/alvoTv');
        break;
      case 4:
        if (Get.currentRoute != '/convites') {
          cc.page.value = 1;
          Get.offNamed('/convites');
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    const barHeight = 62.0;
    const buttonSize = 70.0;
    const floatLift = 20.0;
    final bottomPad = MediaQuery.of(context).padding.bottom;
    final barMarginBottom = bottomPad > 0 ? bottomPad : 12.0;
    final totalHeight = barMarginBottom + barHeight + floatLift + 4;

    final color = Theme.of(context).textSelectionTheme.selectionColor!;

    return SizedBox(
      height: totalHeight,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.fromLTRB(16, 0, 16, barMarginBottom),
              height: barHeight,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorDark,
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _navItem(context, 0, Icons.people_outline_rounded, color),
                  _navItem(context, 1, Icons.lock_outline_rounded, color),
                  const SizedBox(width: buttonSize),
                  _navItem(context, 3, Icons.play_circle_outline_rounded, color),
                  _navItem(context, 4, Icons.card_travel_outlined, color),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: barMarginBottom + barHeight / 2 - buttonSize / 2 + floatLift / 2,
            child: _centerButton(context, buttonSize, color),
          ),
        ],
      ),
    );
  }

  Widget _navItem(
      BuildContext context, int index, IconData icon, Color color) {
    final selected = activeIndex == index;
    return GestureDetector(
      onTap: () => _handleTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? color.withValues(alpha: 0.18) : Colors.transparent,
          borderRadius: BorderRadius.circular(22),
        ),
        child: AnimatedScale(
          scale: selected ? 1.15 : 1.0,
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          child: Icon(
            icon,
            size: 22,
            color: selected ? color : color.withValues(alpha: 0.45),
          ),
        ),
      ),
    );
  }

  Widget _centerButton(BuildContext context, double size, Color color) {
    final selected = activeIndex == 2;
    return _ZoomButton(
      onTap: () => _handleTap(2),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorDark,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.menu_rounded,
          color: selected ? color : color.withValues(alpha: 0.45),
          size: 31,
        ),
      ),
    );
  }
}

class _ZoomButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  const _ZoomButton({required this.child, required this.onTap});

  @override
  State<_ZoomButton> createState() => _ZoomButtonState();
}

class _ZoomButtonState extends State<_ZoomButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 140),
      lowerBound: 0.0,
      upperBound: 1.0,
    );
    _scale = Tween<double>(begin: 1.0, end: 0.88).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) {
        _ctrl.reverse();
        widget.onTap();
      },
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(scale: _scale, child: widget.child),
    );
  }
}
