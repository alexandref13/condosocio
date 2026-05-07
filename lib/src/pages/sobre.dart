import 'package:condosocio/src/components/condo_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Sobre extends StatelessWidget {
  Sobre({super.key});

  final List<_SobreItem> _items = const [
    _SobreItem(
      title: 'Acessos',
      description:
          'Visualize os acessos autorizados em convite e autorize a saída de funcionários ou materiais.',
      route: 'visualizarAcessos',
      icon: Icons.swap_horiz_rounded,
    ),
    _SobreItem(
      title: 'Avisos',
      description:
          'Receba avisos em tempo real com alertas por notificação push e por e-mail.',
      route: 'avisos',
      icon: Icons.mark_chat_read_rounded,
    ),
    _SobreItem(
      title: 'CondoPlay',
      description:
          'Acompanhe vídeos frequentes para ficar por dentro das questões dos condomínios.',
      route: 'alvoTv',
      icon: Icons.live_tv_outlined,
    ),
    _SobreItem(
      title: 'Convites',
      description:
          'Autorize a entrada de visitantes, prestadores de serviço e app de mobilidade.',
      route: 'convites',
      icon: Icons.receipt_long_outlined,
    ),
    _SobreItem(
      title: 'Encomendas',
      description:
          'Receba notificações das encomendas que chegam na administração do condomínio.',
      route: 'Encomendas',
      icon: Icons.local_shipping_outlined,
    ),
    _SobreItem(
      title: 'Reservas',
      description:
          'Visualize e faça reservas de eventos e dos espaços comuns.',
      route: 'reserva',
      icon: Icons.calendar_month_outlined,
    ),
    _SobreItem(
      title: 'Comunicados',
      description: 'Baixe e acompanhe os comunicados do seu condomínio.',
      route: 'comunicados',
      icon: Icons.notifications_active_outlined,
    ),
    _SobreItem(
      title: 'Documentos',
      description:
          'Tenha sempre em mãos os documentos mais importantes do condomínio.',
      route: 'documentos',
      icon: Icons.folder_copy_outlined,
    ),
    _SobreItem(
      title: 'Enquetes',
      description: 'Participe das enquetes e registre a sua opinião.',
      route: 'enquetes',
      icon: Icons.poll_outlined,
    ),
    _SobreItem(
      title: 'Ocorrências',
      description:
          'Registre sugestões, reclamações e ocorrências do dia a dia do condomínio.',
      route: 'ocorrencias',
      icon: Icons.event_note_outlined,
    ),
    _SobreItem(
      title: 'Ache Aqui',
      description:
          'Busque por produtos e serviços e avalie as prestadoras de serviço.',
      route: 'acheAqui',
      icon: Icons.storefront_outlined,
    ),
    _SobreItem(
      title: 'Ouvidoria',
      description:
          'Fale diretamente com a administração do seu condomínio a qualquer hora.',
      route: 'ouvidoria',
      icon: Icons.question_answer_outlined,
    ),
    _SobreItem(
      title: 'Pets',
      description:
          'Cadastre o seu pet e tenha mais segurança e controle no condomínio.',
      route: 'pets',
      icon: Icons.pets_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor =
        theme.textSelectionTheme.selectionColor ?? Colors.white;

    return SafeArea(
      bottom: true,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Sobre',
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
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHero(context, textColor),
                const SizedBox(height: 22),
                Text(
                  'Serviços disponíveis para você',
                  style: GoogleFonts.montserrat(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Explore os recursos que fazem parte da sua rotina dentro do CondoSócio.',
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    height: 1.45,
                    color: textColor.withValues(alpha: 0.78),
                  ),
                ),
                const SizedBox(height: 16),
                ..._items.map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _SobreCard(item: item),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHero(BuildContext context, Color textColor) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [
            Colors.white.withValues(alpha: 0.14),
            Colors.white.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.12),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.14),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 84,
            height: 84,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.08),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.14),
              ),
            ),
            child: Image.asset(
              'images/condosocio_logo.png',
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'CondoSócio',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.2,
              color: textColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'A plataforma digital que aproxima moradores, síndicos, administradores e serviços do condomínio em uma experiência mais simples e conectada.',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 13,
              height: 1.55,
              color: textColor.withValues(alpha: 0.85),
            ),
          ),
          const SizedBox(height: 18),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: const [
              _SobreChip(label: 'Gestão colaborativa'),
              _SobreChip(label: 'Comunicação em tempo real'),
              _SobreChip(label: 'Mais segurança'),
            ],
          ),
        ],
      ),
    );
  }
}

class _SobreCard extends StatelessWidget {
  const _SobreCard({required this.item});

  final _SobreItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor =
        theme.textSelectionTheme.selectionColor ?? Colors.white;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => Get.toNamed('/${item.route}'),
        child: Ink(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: theme.colorScheme.secondary.withValues(alpha: 0.42),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.10),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.10),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: theme.primaryColorDark.withValues(alpha: 0.24),
                ),
                alignment: Alignment.center,
                child: Icon(
                  item.icon,
                  size: 26,
                  color: textColor,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item.description,
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        height: 1.5,
                        color: textColor.withValues(alpha: 0.78),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: textColor.withValues(alpha: 0.72),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SobreChip extends StatelessWidget {
  const _SobreChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: Colors.white.withValues(alpha: 0.08),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.10),
        ),
      ),
      child: Text(
        label,
        style: GoogleFonts.montserrat(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: Colors.white.withValues(alpha: 0.88),
        ),
      ),
    );
  }
}

class _SobreItem {
  const _SobreItem({
    required this.title,
    required this.description,
    required this.route,
    required this.icon,
  });

  final String title;
  final String description;
  final String route;
  final IconData icon;
}
