import 'dart:io';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:condosocio/src/controllers/pets_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

/// Exibe os dados do Pet em um bottom sheet.
/// [imgpet] é o nome do arquivo salvo no servidor (coluna `imgpet`).
void petsModalBottomSheet(
  BuildContext context,
  String nome,
  String tipo,
  String raca,
  String sexo,
  String birthdate,
  String imgpet,
  String idpet,
) {
  final messenger = ScaffoldMessenger.of(context);
  final errorColor = Theme.of(context).colorScheme.error;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).colorScheme.secondary,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (bc) {
      File? selectedFile;
      bool uploading = false;

      return StatefulBuilder(
        builder: (context, setModalState) {
          final textColor = Theme.of(context).textSelectionTheme.selectionColor ?? Colors.white;

          String formatBirthdate(String s) {
            if (s.isEmpty || s == '0000-00-00') return '—';
            try {
              final parts = s.split('-');
              if (parts.length == 3) {
                return '${parts[2].padLeft(2, '0')}/${parts[1].padLeft(2, '0')}/${parts[0]}';
              }
            } catch (_) {}
            return s;
          }

          final imageUrl = (imgpet.trim().isEmpty)
              ? null
              : 'https://www.condosocio.com.br/acond/downloads/fotospets/$imgpet';

          Future<void> pickImage(ImageSource source) async {
            Navigator.pop(context); // fecha o sheet de câmera/galeria
            final picker = ImagePicker();
            final image = await picker.pickImage(source: source);
            if (image == null) return;

            final CroppedFile? cropped = await ImageCropper().cropImage(
              sourcePath: image.path,
              aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
              compressQuality: 80,
              maxWidth: 400,
              maxHeight: 400,
              compressFormat: ImageCompressFormat.jpg,
              uiSettings: [
                AndroidUiSettings(
                  toolbarTitle: 'Imagem para o Pet',
                  toolbarColor: Colors.deepOrange,
                  initAspectRatio: CropAspectRatioPreset.original,
                  statusBarLight: false,
                  backgroundColor: Colors.white,
                  lockAspectRatio: false,
                ),
                IOSUiSettings(title: 'Cortar Imagem'),
              ],
            );

            if (cropped == null) return;

            setModalState(() {
              selectedFile = File(cropped.path);
              uploading = true;
            });

            final result = await PetsController.updatePetImage(idpet, cropped.path);

            setModalState(() => uploading = false);

            if (result == '1') {
              final petsController = Get.find<PetsController>();
              petsController.getPets();
              messenger.showSnackBar(
                SnackBar(
                  content: const Text('A imagem do pet foi atualizada com sucesso.'),
                  backgroundColor: Colors.green.shade700,
                  duration: const Duration(seconds: 3),
                  behavior: SnackBarBehavior.floating,
                  margin: const EdgeInsets.all(12),
                ),
              );
            } else {
              setModalState(() => selectedFile = null);
              messenger.showSnackBar(
                SnackBar(
                  content: const Text('Não foi possível atualizar a imagem. Tente novamente.'),
                  backgroundColor: errorColor,
                  behavior: SnackBarBehavior.floating,
                  margin: const EdgeInsets.all(12),
                ),
              );
            }
          }

          void showPickerSheet() {
            showModalBottomSheet(
              context: context,
              backgroundColor: Theme.of(context).colorScheme.secondary,
              builder: (BuildContext bc) {
                return Container(
                  color: Theme.of(context).colorScheme.secondary,
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Wrap(
                    children: [
                      ListTile(
                        title: Center(
                          child: Text(
                            'Anexar Imagem',
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: textColor,
                            ),
                          ),
                        ),
                      ),
                      Divider(height: 20, color: textColor),
                      ListTile(
                        leading: Icon(Icons.camera_alt, color: textColor),
                        title: Text('Câmera',
                            style: GoogleFonts.montserrat(fontSize: 16, color: textColor)),
                        trailing: Icon(Icons.arrow_right, color: textColor),
                        onTap: () => pickImage(ImageSource.camera),
                      ),
                      Divider(height: 20, color: textColor),
                      ListTile(
                        leading: Icon(Icons.collections, color: textColor),
                        title: Text('Galeria',
                            style: GoogleFonts.montserrat(fontSize: 16, color: textColor)),
                        trailing: Icon(Icons.arrow_right, color: textColor),
                        onTap: () => pickImage(ImageSource.gallery),
                      ),
                      const Divider(height: 20),
                      const SizedBox(height: 15),
                    ],
                  ),
                );
              },
            );
          }

          return SafeArea(
            top: false,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: MediaQuery.of(context).viewInsets.bottom + 18,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // puxador
                  Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),

                  // Avatar com botão de editar
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 96,
                        height: 96,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(color: Colors.black26, blurRadius: 12, offset: Offset(0, 8)),
                          ],
                        ),
                        child: ClipOval(
                          child: uploading
                              ? Container(
                                  color: Theme.of(context).primaryColorDark,
                                  alignment: Alignment.center,
                                  child: const CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                    strokeWidth: 2,
                                  ),
                                )
                              : selectedFile != null
                                  ? Image.file(selectedFile!, fit: BoxFit.cover, width: 96, height: 96)
                                  : imageUrl == null
                                      ? Container(
                                          color: Theme.of(context).primaryColorDark,
                                          alignment: Alignment.center,
                                          child: Icon(Icons.pets, size: 40, color: textColor),
                                        )
                                      : Image.network(
                                          imageUrl,
                                          fit: BoxFit.cover,
                                          width: 96,
                                          height: 96,
                                          loadingBuilder: (context, child, loadingProgress) {
                                            if (loadingProgress == null) return child;
                                            return Container(
                                              color: Theme.of(context).primaryColorDark,
                                              alignment: Alignment.center,
                                              child: const CircularProgressIndicator(
                                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                                strokeWidth: 2,
                                              ),
                                            );
                                          },
                                          errorBuilder: (context, error, stackTrace) => Container(
                                            color: Theme.of(context).primaryColorDark,
                                            alignment: Alignment.center,
                                            child: Icon(Icons.pets, size: 40, color: textColor),
                                          ),
                                        ),
                        ),
                      ),

                      // Ícone de editar
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: uploading ? null : showPickerSheet,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: const Icon(Icons.edit, size: 15, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Nome
                  Text(
                    nome,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.caveat(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    tipo.isEmpty ? '—' : tipo,
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      color: textColor.withValues(alpha:0.85),
                    ),
                  ),

                  const SizedBox(height: 16),
                  Divider(color: Colors.blueGrey.shade300, height: 1),
                  const SizedBox(height: 12),

                  _InfoRow(label: 'Tipo', value: tipo, color: textColor),
                  _InfoRow(label: 'Raça', value: raca, color: textColor),
                  _InfoRow(label: 'Sexo', value: sexo, color: textColor),
                  _InfoRow(label: 'Aniversário', value: formatBirthdate(birthdate), color: textColor),

                  const SizedBox(height: 20),

                  // Botão Excluir
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.error,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        elevation: 0,
                      ),
                      onPressed: () async {
                        LoginController loginController = Get.put(LoginController());
                        PetsController petsController = Get.put(PetsController());

                        final confirmed = await _confirmDelete(context, textColor);
                        if (confirmed == true) {
                          final idusu = loginController.id.value;
                          await PetsController.deletePets(idpet, idusu);
                          Get.back();
                          petsController.getPets();
                          Get.snackbar(
                            'Remoção concluída',
                            'O registro do pet foi excluído com sucesso.',
                            snackPosition: SnackPosition.BOTTOM,
                            duration: const Duration(seconds: 4),
                            backgroundColor: Theme.of(Get.context!).colorScheme.error,
                            colorText: Colors.white,
                            margin: const EdgeInsets.all(12),
                            borderRadius: 8,
                            icon: const Icon(Icons.remove_circle_outline, color: Colors.white),
                          );
                        }
                      },
                      child: Text(
                        'Excluir',
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          color: Colors.white,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _InfoRow({
    Key? key,
    required this.label,
    required this.value,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final v = (value.trim().isEmpty) ? '—' : value;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: GoogleFonts.montserrat(
              fontSize: 14,
              color: color.withValues(alpha:0.85),
              fontWeight: FontWeight.w600,
            ),
          ),
          Expanded(
            child: Text(
              v,
              textAlign: TextAlign.right,
              style: GoogleFonts.montserrat(fontSize: 14, color: color),
            ),
          ),
        ],
      ),
    );
  }
}

Future<bool?> _confirmDelete(BuildContext context, Color textColor) {
  return showDialog<bool>(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text(
          'Confirmar exclusão',
          style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w700, color: textColor),
        ),
        content: Text(
          'Deseja realmente excluir este pet?',
          style: GoogleFonts.montserrat(fontSize: 14, color: textColor.withValues(alpha:0.9)),
        ),
        actionsPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(
              'Cancelar',
              style: GoogleFonts.montserrat(fontSize: 14, color: textColor, fontWeight: FontWeight.w600),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(
              'Excluir',
              style: GoogleFonts.montserrat(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      );
    },
  );
}
