import 'package:condosocio/src/components/utils/alert_button_pressed.dart';
import 'package:condosocio/src/components/utils/delete_alert.dart';
import 'package:condosocio/src/components/utils/edge_alert_widget.dart';
import 'package:condosocio/src/components/utils/whatsapp_send.dart';
import 'package:condosocio/src/controllers/dependentes_controller.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

String _formatarUltimoAcesso(String ultacesso) {
  return ultacesso.replaceFirstMapped(
    RegExp(r'(\d{2}):(\d{2})'),
    (match) => '${match.group(1)}:${match.group(2)}h',
  );
}

void dependentesModalBottomSheet(
  context,
  String nome,
  String sobrenome,
  String status,
  String email,
  String img,
  String cel,
  String facial,
  String tipousuario,
  String idep,
  String condominio_facial,
  String ctlnotificacao, {
  String ultacesso = '',
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).colorScheme.secondary,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (BuildContext bc) {
      final DependentesController dependentesController =
          Get.put(DependentesController());
      final LoginController loginController = Get.put(LoginController());
      final Color textColor =
          Theme.of(context).textSelectionTheme.selectionColor ?? Colors.white;
      final bool hasImage = img.trim().isNotEmpty;
      final bool isMorador = tipousuario == 'Morador';
      final bool isPrestador = tipousuario == 'Prestador de Serviço';

      return SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
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
              _DependenteHeader(
                nome: nome,
                sobrenome: sobrenome,
                tipousuario: tipousuario,
                img: img,
                hasImage: hasImage,
                textColor: textColor,
              ),
              const SizedBox(height: 16),
              Divider(color: Colors.blueGrey.shade300, height: 1),
              const SizedBox(height: 12),
              if (isMorador && email.trim().isNotEmpty)
                _InfoRow(
                  icon: Icons.email_outlined,
                  label: 'E-mail',
                  value: email,
                  textColor: textColor,
                ),
              if (cel.trim().isNotEmpty)
                _InfoRow(
                  icon: Icons.phone_outlined,
                  label: 'Celular',
                  value: cel,
                  textColor: textColor,
                ),
              if (ultacesso.trim().isNotEmpty)
                _InfoRow(
                  icon: Icons.history_outlined,
                  label: 'Último acesso',
                  value: _formatarUltimoAcesso(ultacesso),
                  textColor: textColor,
                ),
              _InfoRow(
                icon: status == 'Suspenso'
                    ? Icons.block_outlined
                    : Icons.check_circle_outline,
                label: 'Status',
                value: status,
                textColor: textColor,
                iconColor: status == 'Suspenso'
                    ? Colors.redAccent
                    : Colors.greenAccent,
              ),
              const SizedBox(height: 16),
              if (facial == '1')
                _ActionButton(
                  label: 'Resetar Face',
                  color: Theme.of(context).primaryColorDark,
                  textColor: Colors.white,
                  onTap: () {
                    deleteAlert(
                      context,
                      'Deseja resetar a face do usuário?',
                      () {
                        dependentesController.delFace().then((value) {
                          if (value == 1) {
                            dependentesController.getDependentes();
                            showToast(context,
                                'Parabéns! Face resetada com sucesso.', '');
                            Get.back();
                            Get.back();
                          } else {
                            onAlertButtonPressed(
                              context,
                              'Algo deu errado\n Tente novamente',
                              '/home',
                              'images/error.png',
                            );
                          }
                        });
                      },
                    );
                  },
                )
              else if (tipousuario == "Prestador de Serviço")
                _ActionButton(
                  label: 'Enviar Via Whatsapp',
                  color: Theme.of(context).primaryColorDark,
                  textColor: Colors.white,
                  onTap: () {
                    final celular = cel
                        .replaceAll("+", "")
                        .replaceAll("(", "")
                        .replaceAll(")", "")
                        .replaceAll("-", "")
                        .replaceAll(" ", "");
                    dependentesController.sendWhatsApp(cel).then((value) {
                      if (value != 0) {
                        final message =
                            'Olá! o Sr(a) ${loginController.nome.value} enviou este link para a liberação de acesso na portaria do condomínio ${loginController.nomeCondo.value}, preencha os campos os campos abertos e insira uma foto de perfil sem utilizacão de óculos ou máscaras . Grato! https://www.condosocio.com.br/paginas/acesso_prestador.php?chave=${value['idusu']}';

                        whatsAppSend(
                          context,
                          "55$celular",
                          Uri.encodeFull(message),
                        );
                      } else {
                        onAlertButtonPressed(
                          context,
                          'Algo deu errado\n Tente novamente',
                          '/home',
                          'images/error.png',
                        );
                      }
                    });
                  },
                )
              else
                _ActionButton(
                  label: 'Reenviar E-mail',
                  color: Theme.of(context).primaryColorDark,
                  textColor: Colors.white,
                  onTap: () {
                    dependentesController.reenviarEmail(email).then((value) {
                      dependentesController.getDependentes();
                      showToast(context, 'Parabéns! $value', '');
                      Get.back();
                    });
                  },
                ),
              if (!isPrestador)
                _ActionButton(
                  label: ctlnotificacao == "0"
                      ? "Tornar esse dependente\n titular da unidade"
                      : "Remover esse dependente\n como titular da unidade",
                  color: Theme.of(context).primaryColorDark,
                  textColor: Colors.white,
                  onTap: () {
                    dependentesController
                        .ativarNotificacoes(idep, ctlnotificacao)
                        .then((value) {
                      dependentesController.getDependentes();

                      if (ctlnotificacao == "0") {
                        showToast(context,
                            'Esse dependente agora é o titular da unidade!', '');
                      } else {
                        showToast(
                            context,
                            'Esse dependente deixou de ser o titular da unidade!',
                            '');
                      }
                      Get.back();
                    });
                  },
                ),
              if (condominio_facial != 'SIM')
                status == 'Normal'
                    ? _ActionButton(
                        label: 'Suspender',
                        color: Theme.of(context).primaryColorDark,
                        textColor: Colors.white,
                        onTap: () {
                          dependentesController.changeStatus('2').then((value) {
                            dependentesController.getDependentes();
                            Get.back();
                          });
                        },
                      )
                    : _ActionButton(
                        label: 'Normalizar',
                        color: Theme.of(context).primaryColorDark,
                        textColor: Colors.white,
                        onTap: () {
                          dependentesController.changeStatus('1').then((value) {
                            dependentesController.getDependentes();
                            Get.back();
                          });
                        },
                      ),
              _ActionButton(
                label: 'Excluir',
                color: Theme.of(context).colorScheme.error,
                textColor: Colors.white,
                onTap: () {
                  deleteAlert(
                    context,
                    'Deseja excluir usuário?',
                    () {
                      dependentesController.deleteDependente().then((value) {
                        if (value == 1) {
                          dependentesController.getDependentes();
                          showToast(context,
                              'Parabéns! Usuário excluído com sucesso.', '');
                          Get.back();
                          Get.back();
                        } else {
                          onAlertButtonPressed(
                            context,
                            'Algo deu errado\n Tente novamente',
                            '/home',
                            'images/error.png',
                          );
                        }
                      });
                    },
                  );
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}

class _DependenteHeader extends StatelessWidget {
  final String nome;
  final String sobrenome;
  final String tipousuario;
  final String img;
  final bool hasImage;
  final Color textColor;

  const _DependenteHeader({
    required this.nome,
    required this.sobrenome,
    required this.tipousuario,
    required this.img,
    required this.hasImage,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl =
        'https://www.condosocio.com.br/acond/downloads/fotosperfil/$img';

    return Center(
      child: Column(
        children: [
          GestureDetector(
            onTap: hasImage
                ? () {
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
                                  imageUrl,
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
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 28,
                                ),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                : null,
            child: Stack(
              children: [
                ClipOval(
                  child: SizedBox(
                    width: 84,
                    height: 84,
                    child: hasImage
                        ? Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => _placeholder(context),
                          )
                        : _placeholder(context),
                  ),
                ),
                if (hasImage)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(
                        Icons.zoom_in,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorDark.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color:
                    Theme.of(context).primaryColorDark.withValues(alpha: 0.5),
              ),
            ),
            child: Text(
              tipousuario.toUpperCase(),
              style: GoogleFonts.montserrat(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: textColor,
                letterSpacing: 1,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '$nome $sobrenome',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _placeholder(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColorDark,
      alignment: Alignment.center,
      child: Icon(
        Icons.person_outline,
        color: textColor,
        size: 40,
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color textColor;
  final Color? iconColor;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.textColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon,
              size: 18, color: iconColor ?? textColor.withValues(alpha: 0.6)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
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
                  style: GoogleFonts.montserrat(
                    fontSize: 13,
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

class _ActionButton extends StatelessWidget {
  final String label;
  final Color color;
  final Color textColor;
  final VoidCallback onTap;

  const _ActionButton({
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
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 0,
            backgroundColor: color,
          ),
          onPressed: onTap,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              color: textColor,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
