import 'package:flutter/material.dart';

/// Mostra um diálogo com fade + scale (parecido com flutter_animated_dialog)
Future<T?> showScaledDialog<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  Duration transitionDuration = const Duration(milliseconds: 250),
  bool barrierDismissible = true,
  Color barrierColor = Colors.black54,
}) {
  return showGeneralDialog<T>(
    context: context,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierDismissible: barrierDismissible,
    barrierColor: barrierColor,
    transitionDuration: transitionDuration,
    pageBuilder: (ctx, anim, secondaryAnim) {
      final child = Builder(builder: builder);
      return SafeArea(
        child: Builder(
          builder: (_) => Center(
            child: Material(
              color: Colors.transparent,
              child: child,
            ),
          ),
        ),
      );
    },
    transitionBuilder: (ctx, anim, secondaryAnim, child) {
      final curved = CurvedAnimation(parent: anim, curve: Curves.easeOutCubic);
      return FadeTransition(
        opacity: curved,
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.95, end: 1.0).animate(curved),
          child: child,
        ),
      );
    },
  );
}

/// Versão “slide from bottom”
Future<T?> showSlideUpDialog<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  Duration transitionDuration = const Duration(milliseconds: 250),
  bool barrierDismissible = true,
  Color barrierColor = Colors.black54,
}) {
  return showGeneralDialog<T>(
    context: context,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierDismissible: barrierDismissible,
    barrierColor: barrierColor,
    transitionDuration: transitionDuration,
    pageBuilder: (ctx, anim, secondaryAnim) {
      final child = Builder(builder: builder);
      return SafeArea(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Material(
            color: Colors.transparent,
            child: child,
          ),
        ),
      );
    },
    transitionBuilder: (ctx, anim, secondaryAnim, child) {
      final curved = CurvedAnimation(parent: anim, curve: Curves.easeOutCubic);
      return SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero)
            .animate(curved),
        child: FadeTransition(opacity: curved, child: child),
      );
    },
  );
}
