import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:condosocio/src/controllers/pets_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

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
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).colorScheme.secondary,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (bc) {
      final textColor =
          Theme.of(context).textSelectionTheme.selectionColor ?? Colors.white;

      String formatBirthdate(String s) {
        if (s.isEmpty || s == '0000-00-00') return '—';
        try {
          final parts = s.split('-'); // [yyyy, mm, dd]
          if (parts.length == 3) {
            final y = parts[0];
            final m = parts[1];
            final d = parts[2];
            return '${d.padLeft(2, '0')}/${m.padLeft(2, '0')}/$y';
          }
        } catch (_) {}
        return s;
      }

      final imageUrl = (imgpet.trim().isEmpty)
          ? null
          : 'https://www.condosocio.com.br/acond/downloads/fotospets/$imgpet';

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

              // Avatar
              Container(
                width: 96,
                height: 96,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 12,
                      offset: Offset(0, 8),
                    )
                  ],
                ),
                child: Container(
                  width: 96,
                  height: 96,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 12,
                        offset: Offset(0, 8),
                      )
                    ],
                  ),
                  child: ClipOval(
                    child: imageUrl == null
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
                                width: 96,
                                height: 96,
                                color: Theme.of(context).primaryColorDark,
                                alignment: Alignment.center,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                  strokeWidth: 2,
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Theme.of(context).primaryColorDark,
                                alignment: Alignment.center,
                                child: Icon(Icons.pets,
                                    size: 40, color: textColor),
                              );
                            },
                          ),
                  ),
                ),
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
                  color: textColor.withOpacity(0.85),
                ),
              ),

              const SizedBox(height: 16),
              Divider(color: Colors.blueGrey.shade300, height: 1),
              const SizedBox(height: 12),

              _InfoRow(label: 'Raça', value: raca, color: textColor),
              _InfoRow(label: 'Sexo', value: sexo, color: textColor),
              _InfoRow(
                label: 'Aniversário',
                value: formatBirthdate(birthdate),
                color: textColor,
              ),

              const SizedBox(height: 20),

              // Botão Excluir
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.error,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () async {
                    LoginController loginController =
                        Get.put(LoginController());

                    PetsController petsController = Get.put(PetsController());

                    final confirmed =
                        await _confirmDelete(context, textColor); // 👈 AQUI

                    if (confirmed == true) {
                      final idusu = loginController.id.value;
                      print('idusu: $idusu, idpet: $idpet');
                      await PetsController.deletePets(
                          idpet, idusu); // 👈 chame seu controller
                      Get.back(); // fecha o modal
                      petsController.getPets(); // atualiza a lista
                      Get.snackbar(
                        'Remoção concluída',
                        'O registro do pet foi excluído com sucesso.',
                        snackPosition: SnackPosition.BOTTOM,
                        duration: const Duration(seconds: 4),
                        backgroundColor:
                            Theme.of(Get.context!).colorScheme.error,
                        colorText: Colors.white, // texto branco
                        margin: const EdgeInsets.all(
                            12), // opcional: dá um respiro nas bordas
                        borderRadius: 8, // opcional: cantos arredondados
                        icon: const Icon(Icons.remove_circle_outline,
                            color: Colors.white), // opcional: ícone
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

              // Botão Fechar
              /*SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).shadowColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () => Get.back(),
                  child: Text(
                    'Fechar',
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      color: textColor,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),*/
            ],
          ),
        ),
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
              color: color.withOpacity(0.85),
              fontWeight: FontWeight.w600,
            ),
          ),
          Expanded(
            child: Text(
              v,
              textAlign: TextAlign.right,
              style: GoogleFonts.montserrat(
                fontSize: 14,
                color: color,
              ),
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
          style: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: textColor,
          ),
        ),
        content: Text(
          'Deseja realmente excluir este pet?',
          style: GoogleFonts.montserrat(
            fontSize: 14,
            color: textColor.withOpacity(0.9),
          ),
        ),
        actionsPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(
              'Cancelar',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                color: textColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(
              'Excluir',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      );
    },
  );
}
