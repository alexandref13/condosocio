import 'dart:ui';

import 'package:condosocio/src/components/utils/alert_button_pressed.dart';
import 'package:condosocio/src/components/utils/confirmed_button_pressed.dart';
import 'package:condosocio/src/controllers/email_controller.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Esqueci extends StatefulWidget {
  @override
  _EsqueciState createState() => _EsqueciState();
}

class _EsqueciState extends State<Esqueci> {
  EmailController emailController = Get.put(EmailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white70, size: 20),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Redefinir Senha',
          style: GoogleFonts.montserrat(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Stack(
        children: [
          // Background image
          SizedBox.expand(
            child: Image.asset('images/bannertopo.png', fit: BoxFit.cover),
          ),
          // Gradient overlay
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xDD06042A),
                  Color(0xBB180048),
                  Color(0xFF0E002E),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Content
          SafeArea(
            child: Obx(() {
              if (emailController.isLoading.value) {
                return const SizedBox.expand(
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                );
              }
              return SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(22, 32, 22, 40),
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    Image.asset('images/key.png', height: 180),
                    const SizedBox(height: 28),
                    Text(
                      'Informe o seu e-mail que iremos lhe enviar instruções para redefinir a senha.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        color: Colors.white60,
                        fontSize: 14,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Glass card
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                        child: Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.07),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.12),
                            ),
                          ),
                          child: Form(
                            key: emailController.form,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.deny(
                                        RegExp(r'\s')),
                                    TextInputFormatter.withFunction(
                                      (old, val) => val.copyWith(
                                          text: val.text.toLowerCase()),
                                    ),
                                  ],
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor:
                                        Colors.white.withValues(alpha: 0.09),
                                    prefixIcon: const Icon(
                                        Icons.email_outlined,
                                        color: Colors.white54,
                                        size: 20),
                                    labelText: 'E-mail',
                                    labelStyle: GoogleFonts.montserrat(
                                        color: Colors.white54, fontSize: 14),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      borderSide:
                                          const BorderSide(color: Colors.white24),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      borderSide: const BorderSide(
                                          color: Colors.white70, width: 1.5),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      borderSide: BorderSide(
                                          color: Colors.redAccent
                                              .withValues(alpha: 0.8)),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      borderSide: const BorderSide(
                                          color: Colors.redAccent, width: 1.5),
                                    ),
                                    errorStyle: GoogleFonts.montserrat(
                                      color: Colors.redAccent.shade100,
                                      fontSize: 11,
                                    ),
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (v) {
                                    if (!EmailValidator.validate(v!)) {
                                      return 'Entre com e-mail válido!';
                                    }
                                    return null;
                                  },
                                  controller:
                                      emailController.emailesqueci.value,
                                ),
                                const SizedBox(height: 24),
                                Container(
                                  height: 54,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF7C4DFF),
                                    borderRadius: BorderRadius.circular(14),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF7C4DFF)
                                            .withValues(alpha: 0.45),
                                        blurRadius: 24,
                                        offset: const Offset(0, 8),
                                      ),
                                    ],
                                  ),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                    ),
                                    onPressed: () {
                                      if (emailController.form.currentState!
                                          .validate()) {
                                        emailController
                                            .email(context)
                                            .then((value) {
                                          if (value == 1) {
                                            confirmedButtonPressed(
                                              context,
                                              "Enviamos um e-mail para a redefinição de senha. Aguarde!",
                                              "/login",
                                            );
                                          } else {
                                            onAlertButtonPressed(
                                                context,
                                                "E-mail não existe em nosso banco de dados! Tente novamente.",
                                                '',
                                                'images/error.png');
                                          }
                                        });
                                      }
                                    },
                                    child: Text(
                                      'Enviar',
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                        color: Colors.white,
                                        letterSpacing: 0.5,
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
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
