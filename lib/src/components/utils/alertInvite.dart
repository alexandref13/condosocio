import 'package:condosocio/src/components/utils/animated_dialog.dart';
import 'package:flutter/material.dart';

Future<void> confirmedInviteAlert(
  BuildContext context,
  String text,
  String imagem,
  String button,
  VoidCallback onTap, {
  bool barrierDismissible = true,
  bool showCloseButton = true,
  VoidCallback? onDismiss,
}) async {
  await precacheImage(AssetImage(imagem), context);

  showScaledDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    transitionDuration: const Duration(seconds: 1),
    builder: (BuildContext context) {
      final size = MediaQuery.of(context).size;
      final VoidCallback dismissDialog =
          onDismiss ?? () => Navigator.of(context).pop();
      final maxDialogHeight = size.height * 0.72;
      final maxImageHeight = size.height * 0.24;

      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: dismissDialog,
        child: Center(
          child: GestureDetector(
            onTap: () {},
            child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: Colors.white,
              elevation: 0,
              child: Stack(
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: 360,
                      maxHeight: maxDialogHeight,
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight: 120,
                                maxHeight: maxImageHeight,
                              ),
                              child: Image.asset(
                                imagem,
                                fit: BoxFit.contain,
                                errorBuilder: (_, __, ___) => const Icon(
                                  Icons.image_not_supported_outlined,
                                  size: 72,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                text,
                                style: TextStyle(
                                  fontSize: 16,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: onTap,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                minimumSize: const Size(140, 44),
                              ),
                              child: Text(
                                button,
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (showCloseButton)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: IconButton(
                        onPressed: dismissDialog,
                        icon: Icon(
                          Icons.close,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 22,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
