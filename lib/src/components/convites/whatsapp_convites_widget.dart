import 'package:condosocio/src/components/utils/alert_button_pressed.dart';
import 'package:condosocio/src/components/utils/whatsapp_send.dart';
import 'package:condosocio/src/controllers/convites/visualizar_convites_controller.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class WhatsAppConvitesWidget extends StatefulWidget {
  const WhatsAppConvitesWidget({Key? key}) : super(key: key);

  @override
  State<WhatsAppConvitesWidget> createState() => _WhatsAppConvitesWidgetState();
}

class _WhatsAppConvitesWidgetState extends State<WhatsAppConvitesWidget> {
  late TextEditingController _controller;
  String? _erro;

  @override
  void initState() {
    super.initState();
    final numeroInicial = (Get.arguments ?? '').toString();
    _controller = TextEditingController(text: numeroInicial);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool _isInternacional(String numero) => numero.trimLeft().startsWith('+');

  bool _validar(String numero) {
    if (_isInternacional(numero)) {
      return numero.replaceAll(RegExp(r'\D'), '').length >= 8;
    }
    final digits = numero.replaceAll(RegExp(r'\D'), '');
    if (digits.length != 11) return false;
    final ddd = int.tryParse(digits.substring(0, 2)) ?? 0;
    if (ddd < 11 || ddd > 99) return false;
    if (digits[2] != '9') return false;
    return true;
  }

  String _wame(String numero) {
    final digits = numero.replaceAll(RegExp(r'\D'), '');
    if (_isInternacional(numero)) return digits;
    return '55$digits';
  }

  void _enviar() {
    final numero = _controller.text.trim();
    if (!_validar(numero)) {
      setState(() => _erro = 'Número inválido. Ex: 21999998888');
      return;
    }
    setState(() => _erro = null);

    final ctrl = Get.find<VisualizarConvitesController>();
    final loginController = Get.put(LoginController());

    ctrl.whatsappNumber.value.text = _isInternacional(numero)
        ? numero
        : numero.replaceAll(RegExp(r'\D'), '');

    ctrl.sendWhatsApp().then((value) {
      if (value != null && value['idace'] != null && value['idace'].toString().isNotEmpty) {
        final message =
            'Olá! Você foi convidado por ${loginController.nome.value}, '
            'morador do condomínio ${loginController.nomeCondo.value}. '
            'Agilize seu acesso clicando no link e preencha os campos em aberto. Grato! '
            'https://www.condosocio.com.br/paginas/a.php?chave=${value['idace']}';
        whatsAppSend(context, _wame(numero), Uri.encodeFull(message)).then((_) {
          Get.offAllNamed('/home');
        });
      } else {
        onAlertButtonPressed(
          context,
          'Algo deu errado. Tente novamente.',
          '/home',
          'images/error.png',
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textSelectionTheme.selectionColor!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'WhatsApp',
          style: GoogleFonts.montserrat(fontSize: 14, color: textColor),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.asset('images/landing1.png')),
            const SizedBox(height: 24),
            Text(
              'O número não está no formato correto para o WhatsApp.\n'
              'Por favor, corrija abaixo:',
              style: GoogleFonts.montserrat(fontSize: 14, color: textColor),
            ),
            const SizedBox(height: 6),
            Text(
              'Ex: 21 9 99999999',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                color: textColor.withValues(alpha: 0.6),
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[\d\+\(\)\-\s]')),
              ],
              style: GoogleFonts.montserrat(fontSize: 16, color: textColor),
              decoration: InputDecoration(
                labelText: 'Número WhatsApp',
                labelStyle: GoogleFonts.montserrat(
                    color: textColor.withValues(alpha: 0.7), fontSize: 14),
                errorText: _erro,
                errorStyle: GoogleFonts.montserrat(color: Colors.red[400]!),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      BorderSide(color: textColor.withValues(alpha: 0.5)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: textColor, width: 1.5),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.red[400]!),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.red[700]!),
                ),
                prefixIcon: Icon(Icons.phone_outlined,
                    color: textColor.withValues(alpha: 0.7)),
              ),
              onSubmitted: (_) => _enviar(),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: _enviar,
                child: Text(
                  'ENVIAR',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: textColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
