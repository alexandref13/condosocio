import 'package:condosocio/src/components/condo_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class Configuracoes extends StatefulWidget {
  const Configuracoes({super.key});

  @override
  State<Configuracoes> createState() => _ConfiguracoesState();
}

class _ConfiguracoesState extends State<Configuracoes>
    with WidgetsBindingObserver {
  bool _permitido = OneSignal.Notifications.permission;
  bool _inscrito = OneSignal.User.pushSubscription.optedIn ?? false;
  bool _carregando = false;

  // Ativo somente se o sistema permite notificações E o app está inscrito.
  bool get _notificacoes => _permitido && _inscrito;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // O estado do OneSignal é atualizado por eventos nativos (com atraso),
    // então a tela reage a eles em vez de ler o valor uma única vez.
    OneSignal.Notifications.addPermissionObserver(_onPermissao);
    OneSignal.User.pushSubscription.addObserver(_onInscricao);
    _atualizar();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    OneSignal.Notifications.removePermissionObserver(_onPermissao);
    OneSignal.User.pushSubscription.removeObserver(_onInscricao);
    super.dispose();
  }

  void _onPermissao(bool permitido) {
    if (!mounted) return;
    setState(() => _permitido = permitido);
  }

  void _onInscricao(OSPushSubscriptionChangedState estado) {
    if (!mounted) return;
    setState(() => _inscrito = estado.current.optedIn);
  }

  // Ao voltar das configurações do sistema, relê o estado da permissão.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed) return;
    _atualizar();
    // O sistema pode demorar a notificar a mudança; confere de novo depois.
    Future.delayed(const Duration(seconds: 1), _atualizar);
    Future.delayed(const Duration(seconds: 3), _atualizar);
  }

  // Lê a permissão diretamente do sistema (no iOS) em vez do valor em cache.
  Future<void> _atualizar() async {
    var permitido = OneSignal.Notifications.permission;
    try {
      final nativo = await OneSignal.Notifications.permissionNative();
      permitido = nativo == OSNotificationPermission.authorized ||
          nativo == OSNotificationPermission.provisional ||
          nativo == OSNotificationPermission.ephemeral;
    } catch (e) {
      debugPrint('Erro ao ler permissão de notificações: $e');
    }
    if (!mounted) return;
    setState(() {
      _permitido = permitido;
      _inscrito = OneSignal.User.pushSubscription.optedIn ?? _inscrito;
    });
  }

  // Desligar apenas cancela a inscrição no OneSignal. Ligar reinscreve e, se
  // a permissão do sistema não estiver concedida, leva o usuário às
  // configurações do dispositivo para ativá-la.
  Future<void> _alternar(bool ativar) async {
    if (_carregando) return;
    setState(() {
      _carregando = true;
      _inscrito = ativar;
    });

    try {
      if (ativar) {
        await OneSignal.User.pushSubscription.optIn();
        await _atualizar();
        if (!_permitido) await openAppSettings();
      } else {
        await OneSignal.User.pushSubscription.optOut();
      }
    } catch (e) {
      debugPrint('Erro ao alterar notificações: $e');
    }

    if (!mounted) return;
    setState(() => _carregando = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.textSelectionTheme.selectionColor ?? Colors.white;

    return SafeArea(
      bottom: true,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Configurações',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
          centerTitle: true,
        ),
        bottomNavigationBar: const CondoNavBar(),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                theme.primaryColor,
                theme.primaryColor.withValues(alpha: 0.95),
                theme.colorScheme.secondary.withValues(alpha: 0.92),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 28),
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.white.withValues(alpha: 0.10),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.12),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: textColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        _notificacoes
                            ? Icons.notifications_active_outlined
                            : Icons.notifications_off_outlined,
                        color: textColor,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Notificações',
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: textColor,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            _notificacoes
                                ? 'Ativadas neste dispositivo'
                                : 'Ative para receber avisos, comunicados e acessos',
                            style: GoogleFonts.montserrat(
                              fontSize: 11.5,
                              height: 1.4,
                              color: textColor.withValues(alpha: 0.78),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Switch.adaptive(
                      value: _notificacoes,
                      onChanged: _carregando ? null : _alternar,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
