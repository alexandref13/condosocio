import 'dart:ui';

import 'package:condosocio/src/components/utils/alert_button_pressed.dart';
import 'package:condosocio/src/controllers/auth_controller.dart';
import 'package:condosocio/src/controllers/home_page_controller.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:condosocio/src/controllers/theme_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:email_validator/email_validator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  final LoginController loginController = Get.put(LoginController());
  final AuthController authController = Get.put(AuthController());
  final ThemeController themeController = Get.put(ThemeController());
  final HomePageController homePageController = Get.put(HomePageController());

  final _formKey = GlobalKey<FormState>();

  late final AnimationController _animController;
  late final Animation<double> _logoFade;
  late final Animation<Offset> _logoSlide;
  late final Animation<double> _textFade;
  late final Animation<Offset> _textSlide;
  final FocusNode _passwordFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _passwordFocus.addListener(() {
      if (_passwordFocus.hasFocus) {
        _animController.forward(from: 0);
      }
    });
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _logoFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );
    _logoSlide = Tween<Offset>(
      begin: const Offset(0, -0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _textFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.35, 0.85, curve: Curves.easeOut),
      ),
    );
    _textSlide = Tween<Offset>(
      begin: const Offset(0, 0.4),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.35, 0.85, curve: Curves.easeOut),
      ),
    );

    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  InputDecoration _fieldDecoration({
    required String label,
    required IconData icon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white.withValues(alpha: 0.09),
      prefixIcon: Icon(icon, color: Colors.white54, size: 20),
      labelText: label,
      labelStyle: GoogleFonts.montserrat(color: Colors.white54, fontSize: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.white24),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.white70, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.redAccent.withValues(alpha: 0.8)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
      ),
      errorStyle: GoogleFonts.montserrat(
        color: Colors.redAccent.shade100,
        fontSize: 11,
      ),
      suffixIcon: suffixIcon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          // Main content
          SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child: Obx(() {
                  return IntrinsicHeight(
                    child: Column(
                      children: [
                    const SizedBox(height: 64),
                    // Logo
                    FadeTransition(
                      opacity: _logoFade,
                      child: SlideTransition(
                        position: _logoSlide,
                        child: Image.asset(
                          'images/condosocio_logo.png',
                          width: 110,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    FadeTransition(
                      opacity: _textFade,
                      child: SlideTransition(
                        position: _textSlide,
                        child: Text(
                          'A tecnologia que transforma',
                          style: GoogleFonts.montserrat(
                            color: Colors.white54,
                            fontSize: 13,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 52),
                    // Glass card
                    Expanded(child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(36),
                        topRight: Radius.circular(36),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.fromLTRB(22, 44, 22, 48),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.07),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(36),
                              topRight: Radius.circular(36),
                            ),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.12),
                            ),
                          ),
                          child: Form(
                            autovalidateMode: AutovalidateMode.disabled,
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Email
                                TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                  decoration: _fieldDecoration(
                                    label: 'E-mail',
                                    icon: Icons.email_outlined,
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.deny(
                                        RegExp(r'\s')),
                                    TextInputFormatter.withFunction(
                                      (old, val) => val.copyWith(
                                          text: val.text.toLowerCase()),
                                    ),
                                  ],
                                  validator: (v) {
                                    if (!EmailValidator.validate(v!)) {
                                      return 'Entre com e-mail válido!';
                                    }
                                    return null;
                                  },
                                  controller: loginController.email.value,
                                ),
                                const SizedBox(height: 20),
                                // Password
                                Obx(() => TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      obscureText:
                                          loginController.obscurePassword.value,
                                      style: GoogleFonts.montserrat(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                      decoration: _fieldDecoration(
                                        label: 'Senha',
                                        icon: Icons.lock_outline,
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            loginController
                                                    .obscurePassword.value
                                                ? Icons.visibility_off_outlined
                                                : Icons.visibility_outlined,
                                            color: Colors.white38,
                                            size: 20,
                                          ),
                                          onPressed: () => loginController
                                                  .obscurePassword.value =
                                              !loginController
                                                  .obscurePassword.value,
                                        ),
                                      ),
                                      validator: (v) {
                                        if (v!.isEmpty) {
                                          return 'Campo senha vazio!';
                                        }
                                        return null;
                                      },
                                      focusNode: _passwordFocus,
                                      controller:
                                          loginController.password.value,
                                    )),
                                const SizedBox(height: 8),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.white38,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0, vertical: 4),
                                      minimumSize: Size.zero,
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    onPressed: () => Get.toNamed('/esqueci'),
                                    child: Text(
                                      'Esqueceu a senha?',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        color: Colors.white38,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 22),
                                // Terms checkbox
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: Checkbox(
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        side: const BorderSide(
                                            color: Colors.white38),
                                        fillColor: WidgetStateColor.resolveWith(
                                            (states) {
                                          return states.contains(
                                                  WidgetState.selected)
                                              ? const Color(0xFF7C4DFF)
                                              : Colors.white24;
                                        }),
                                        checkColor: Colors.white,
                                        value: loginController.isChecked.value,
                                        onChanged: (v) => loginController
                                            .isChecked.value = v!,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text.rich(TextSpan(
                                        text: 'Li e concordo com os ',
                                        style: GoogleFonts.montserrat(
                                          color: Colors.white54,
                                          fontSize: 12,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'Termos de Uso',
                                            style: GoogleFonts.montserrat(
                                              color: const Color(0xFFB39DDB),
                                              fontSize: 12,
                                              decoration:
                                                  TextDecoration.underline,
                                              decorationColor:
                                                  const Color(0xFFB39DDB),
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                loginController.launched =
                                                    loginController
                                                        .launchInBrowser(
                                                  'https://www.condosocio.com.br/termo.html',
                                                );
                                              },
                                          ),
                                          TextSpan(
                                            text: ' e com a ',
                                            style: GoogleFonts.montserrat(
                                              color: Colors.white54,
                                              fontSize: 12,
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'Política de Privacidade',
                                            style: GoogleFonts.montserrat(
                                              color: const Color(0xFFB39DDB),
                                              fontSize: 12,
                                              decoration:
                                                  TextDecoration.underline,
                                              decorationColor:
                                                  const Color(0xFFB39DDB),
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                loginController.launched =
                                                    loginController
                                                        .launchInBrowser(
                                                  'https://www.condosocio.com.br/privacidade.html',
                                                );
                                              },
                                          ),
                                        ],
                                      )),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 40),
                                // Login button
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
                                    onPressed: loginController.isLoading.value
                                        ? null
                                        : () {
                                            if (loginController
                                                .isChecked.value) {
                                              if (loginController
                                                          .email.value.text ==
                                                      '' ||
                                                  loginController.password.value
                                                          .text ==
                                                      '') {
                                                onAlertButtonPressed(
                                                    context,
                                                    'Campo e-mail ou senha vazio!',
                                                    '',
                                                    'images/error.png');
                                              }
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                loginController
                                                    .login()
                                                    .then((value) {
                                                  if (value == null) {
                                                    loginController.password
                                                        .value.text = '';
                                                    loginController.isLoading
                                                        .value = false;
                                                    onAlertButtonPressed(
                                                        context,
                                                        'E-mail ou Senha Inválidos! \n Tente Novamente',
                                                        '',
                                                        'images/error.png');
                                                  } else {
                                                    loginController.password
                                                        .value.text = '';
                                                    loginController.isLoading
                                                        .value = false;
                                                    loginController
                                                        .hasMoreEmail(
                                                      loginController
                                                          .email.value.text,
                                                    )
                                                        .then((response) {
                                                      if (response.length > 1 ||
                                                          loginController.idcond
                                                                  .value ==
                                                              '') {
                                                        loginController
                                                            .haveListOfCondo
                                                            .value = true;
                                                        Get.offAllNamed(
                                                            '/listOfCondo');
                                                      } else {
                                                        loginController
                                                            .haveListOfCondo
                                                            .value = false;
                                                        loginController
                                                                .id.value =
                                                            value['idusu'];
                                                        loginController
                                                                .idcond.value =
                                                            value['idcond'];
                                                        loginController
                                                                .tipo.value =
                                                            value['tipo'];
                                                        loginController
                                                                .imgperfil
                                                                .value =
                                                            value['imgperfil'];
                                                        loginController.emailUsu
                                                                .value =
                                                            value['email'];
                                                        loginController
                                                                .nomeCondo
                                                                .value =
                                                            value['nome_condo'];
                                                        loginController.imgcondo
                                                                .value =
                                                            value['imgcondo'];
                                                        loginController
                                                                .nome.value =
                                                            value['nome'];
                                                        loginController
                                                                .sobrenome
                                                                .value =
                                                            value['sobrenome'];
                                                        loginController
                                                                .condoTheme
                                                                .value =
                                                            value['cor'];
                                                        loginController
                                                                .logradouro
                                                                .value =
                                                            value['logradouro'];
                                                        loginController
                                                                .tipoun.value =
                                                            value['tipoun'];
                                                        loginController
                                                                .dep.value =
                                                            value['dep'];
                                                        loginController
                                                                .condofacial
                                                                .value =
                                                            value[
                                                                'condofacial'];
                                                        loginController
                                                                .imgfacial
                                                                .value =
                                                            value['imgfacial'];
                                                        loginController
                                                                .idadm.value =
                                                            value['idadm'];
                                                        loginController
                                                                .websiteAdministradora
                                                                .value =
                                                            value[
                                                                'website_administradora'];
                                                        loginController
                                                                .licenca.value =
                                                            value['licenca'];
                                                        loginController
                                                            .storageId();
                                                        themeController
                                                            .setTheme(
                                                          loginController
                                                              .condoTheme.value,
                                                        );
                                                        var sendTags = {
                                                          'idusu':
                                                              loginController
                                                                  .id.value,
                                                          'nome':
                                                              loginController
                                                                  .nome.value,
                                                          'sobrenome':
                                                              loginController
                                                                  .idcond.value,
                                                        };
                                                        OneSignal.User.addTags(
                                                                sendTags)
                                                            .then((_) {
                                                          print(
                                                              "Successfully sent tags: $sendTags");
                                                        }).catchError((error) {
                                                          print(
                                                              "Auth Encountered an error sending tags: $error");
                                                        });
                                                        Get.offAllNamed(
                                                            '/home');
                                                      }
                                                    });
                                                  }
                                                });
                                              }
                                            } else {
                                              loginController.isLoading.value =
                                                  false;
                                              onAlertButtonPressed(
                                                  context,
                                                  'Você precisa aceitar os termos de uso e a política de privacidade para entrar!',
                                                  '',
                                                  'images/error.png');
                                            }
                                          },
                                    child: Text(
                                      'Acessar',
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                        color: Colors.white,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 32),
                                // Divider
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 1,
                                        color: Colors.white12,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      child: Text(
                                        'Siga-nos',
                                        style: GoogleFonts.montserrat(
                                          color: Colors.white24,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 1,
                                        color: Colors.white12,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                // Social icons
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _socialIcon(
                                      FontAwesomeIcons.globe,
                                      () => homePageController.launched =
                                          homePageController.launchInBrowser(
                                              'https://www.condosocio.com.br'),
                                    ),
                                    _socialIcon(
                                      FontAwesomeIcons.facebook,
                                      () => homePageController.launched =
                                          homePageController.launchInBrowser(
                                              'https://www.facebook.com/condosocio'),
                                    ),
                                    _socialIcon(
                                      FontAwesomeIcons.youtube,
                                      () => homePageController.launched =
                                          homePageController.launchInBrowser(
                                              'https://www.youtube.com/channel/UCLPOsAW7jbawmz7nB3UeDvg'),
                                    ),
                                    _socialIcon(
                                      FontAwesomeIcons.instagram,
                                      () => homePageController.launched =
                                          homePageController.launchInBrowser(
                                              'https://www.instagram.com/condosocioapp'),
                                    ),
                                    _socialIcon(
                                      FontAwesomeIcons.whatsapp,
                                      () => homePageController.launched =
                                          homePageController.launchInBrowser(
                                              'https://api.whatsapp.com/send?phone=5591981220670'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )),
                  ],
                    ),
                  );
                }),
              ),
            ),
          ),
          // Loading overlay
          Obx(() => loginController.isLoading.value
              ? Positioned.fill(
                  child: Container(
                    color: Colors.black.withValues(alpha: 0.6),
                    child: const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink()),
        ],
      ),
    );
  }

  Widget _socialIcon(IconData icon, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white12),
          ),
          child: Center(
            child: FaIcon(icon, color: Colors.white54, size: 16),
          ),
        ),
      ),
    );
  }
}
