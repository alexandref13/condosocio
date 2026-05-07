import 'package:condosocio/src/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashIntro extends StatefulWidget {
  const SplashIntro({super.key});

  @override
  State<SplashIntro> createState() => _SplashIntroState();
}

class _SplashIntroState extends State<SplashIntro>
    with TickerProviderStateMixin {
  final AuthController authController = Get.put(AuthController());

  late final AnimationController _logoController;
  late final AnimationController _textController;
  late final AnimationController _glowController;

  late final Animation<double> _logoFade;
  late final Animation<double> _logoScale;
  late final Animation<Offset> _logoSlide;
  late final Animation<double> _textFade;
  late final Animation<Offset> _textSlide;
  late final Animation<double> _glowOpacity;
  late final Animation<double> _glowScale;

  bool _routing = false;

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);

    _logoFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.55, curve: Curves.easeOut),
      ),
    );
    _logoScale = Tween<double>(begin: 0.82, end: 1.08).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOut),
    );
    _logoSlide = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: Curves.easeOutCubic,
      ),
    );

    _textFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _textController,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
      ),
    );
    _textSlide = Tween<Offset>(
      begin: const Offset(0, 0.14),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeOut),
    );
    _glowOpacity = Tween<double>(begin: 0.18, end: 0.42).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );
    _glowScale = Tween<double>(begin: 0.92, end: 1.06).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );

    _runIntro();
  }

  Future<void> _runIntro() async {
    await Future.delayed(const Duration(milliseconds: 420));
    if (!mounted) return;

    await _logoController.forward();
    await Future.delayed(const Duration(milliseconds: 120));
    if (!mounted) return;

    await _textController.forward();
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;

    await _routeFromSplash();
  }

  Future<void> _routeFromSplash() async {
    if (_routing) return;
    _routing = true;

    final hasSession = await authController.hasSavedSession();
    if (!mounted) return;

    if (!hasSession) {
      Get.offAllNamed('/login');
      return;
    }

    final canUseBiometrics =
        await authController.canAuthenticateWithBiometrics();
    if (!mounted) return;

    if (!canUseBiometrics) {
      Get.offAllNamed('/login');
      return;
    }

    await authController.authenticate();
    if (!mounted) return;

    if (Get.currentRoute == '/splash') {
      Get.offAllNamed('/login');
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('images/bannertopo.png', fit: BoxFit.cover),
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
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FadeTransition(
                      opacity: _logoFade,
                      child: SlideTransition(
                        position: _logoSlide,
                        child: ScaleTransition(
                          scale: _logoScale,
                          child: SizedBox(
                            width: 175,
                            height: 132,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                FadeTransition(
                                  opacity: _glowOpacity,
                                  child: ScaleTransition(
                                    scale: _glowScale,
                                    child: Container(
                                      width: 133,
                                      height: 133,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: RadialGradient(
                                          colors: [
                                            Colors.white
                                                .withValues(alpha: 0.26),
                                            Colors.white
                                                .withValues(alpha: 0.08),
                                            Colors.transparent,
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Image.asset(
                                  'images/condosocio_logo.png',
                                  width: 144,
                                  fit: BoxFit.contain,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(0, -8),
                      child: FadeTransition(
                        opacity: _textFade,
                        child: SlideTransition(
                          position: _textSlide,
                          child: Text(
                            'A tecnologia que transforma',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                              color: Colors.white.withValues(alpha: 0.78),
                              fontSize: 15,
                              letterSpacing: 0.9,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
