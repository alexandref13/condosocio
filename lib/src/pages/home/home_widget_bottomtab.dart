import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:condosocio/src/controllers/acessos/visualizar_acessos_controller.dart';
import 'package:condosocio/src/controllers/convites/convites_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/esperaacessos/visualizar_acessos_espera_controller.dart';
import '../../controllers/home_page_controller.dart';
import '../../controllers/login_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class HomeBottomTab extends StatefulWidget {
  const HomeBottomTab({Key? key}) : super(key: key);

  @override
  _HomeBottomTabState createState() => _HomeBottomTabState();
}

class _HomeBottomTabState extends State<HomeBottomTab>
    with AutomaticKeepAliveClientMixin<HomeBottomTab> {
  final ConvitesController convitesController = Get.put(ConvitesController());
  final VisualizarAcessosController visualizarAcessosController =
      Get.put(VisualizarAcessosController());
  final VisualizarAcessosEsperaController visualizarAcessosEsperaController =
      Get.put(VisualizarAcessosEsperaController());
  final LoginController loginController = Get.put(LoginController());
  final HomePageController homePageController = Get.put(HomePageController());

  final RateMyApp rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp_',
    minDays: 3,
    minLaunches: 3,
    remindDays: 0,
    remindLaunches: 5,
    googlePlayIdentifier: 'com.condosocionovo',
    appStoreIdentifier: '1262911877',
  );

  @override
  bool get wantKeepAlive =>
      true; // mantém o estado/scroll ao trocar de aba/rota

  @override
  void initState() {
    super.initState();
    // pós-frame: inicializa rating dialog com segurança
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await rateMyApp.init();
      if (mounted && rateMyApp.shouldOpenDialog) {
        showCustomRateDialog();
      }
    });
  }

  // força um repaint quando a página volta ao foco (corrige layout só “arrumar” ao tocar/carusel trocar)
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() {});
    });
  }

  Future<void> _launchExternal(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<List<Map<String, String>>> _loadBannersAndPrecache(
      BuildContext context) async {
    final data = await HomePageController.getBannersHome();
    if (data.isNotEmpty) {
      // Precarrega todas as imagens antes de exibir o carrossel
      await Future.wait(
        data.map((b) async {
          final url = b['imgUrl'];
          if (url != null && url.isNotEmpty) {
            final image = Image.network(url).image;
            try {
              await precacheImage(image, context);
            } catch (_) {
              // Ignora erros de cache, deixamos o errorBuilder tratar na UI
            }
          }
        }),
      );
    }
    return data;
  }

  void showCustomRateDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: Column(
            children: [
              Image.asset(
                'images/logocolor.png',
                height: 70,
              ),
              const SizedBox(height: 20),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Você gosta do nosso App? Deixe uma avaliação na loja de aplicativos e ajude mais pessoas a descobrirem nossos serviços! Seu feedback é muito importante para nós!',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemSize: 30,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Theme.of(context).primaryColor,
                ),
                onRatingUpdate: (rating) async {
                  if (rating >= 4) {
                    final url = Platform.isIOS
                        ? 'https://apps.apple.com/app/id1262911877?action=write-review'
                        : 'https://play.google.com/store/apps/details?id=com.condosocionovo';
                    await _launchExternal(url);
                  } else {
                    const message = "Nos informe como podemos melhorar?";
                    final whatsappUrl =
                        "https://api.whatsapp.com/send?phone=5591981220670&text=${Uri.encodeComponent(message)}";
                    await _launchExternal(whatsappUrl);
                  }
                  await rateMyApp
                      .callEvent(RateMyAppEventType.rateButtonPressed);
                  if (mounted) Navigator.pop(context);
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                rateMyApp.callEvent(RateMyAppEventType.laterButtonPressed);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // necessário para manter o estado
    return Scaffold(
      body: SafeArea(
        top: false, // topo já é tratado pelo AppBarWidget
        child: CustomScrollView(
          key: const PageStorageKey<String>('homeScrollKey'),
          primary: false,
          slivers: <Widget>[
            // Banner
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 25),
                child: FutureBuilder<List<Map<String, String>>>(
                  future: _loadBannersAndPrecache(context),
                  builder: (context, snapshot) {
                    final spinnerColor =
                        Theme.of(context).textSelectionTheme.selectionColor ??
                            Theme.of(context).colorScheme.primary;

                    if (snapshot.connectionState != ConnectionState.done) {
                      // Mantém a altura fixa enquanto carrega TUDO
                      return SizedBox(
                        height: 160,
                        child: Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 4,
                            valueColor: AlwaysStoppedAnimation(spinnerColor),
                          ),
                        ),
                      );
                    }

                    if (snapshot.hasError) {
                      return SizedBox(
                        height: 160,
                        child: Center(
                          child: Text(
                            'Erro: ${snapshot.error}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }

                    final banners =
                        snapshot.data ?? const <Map<String, String>>[];
                    if (banners.isEmpty) {
                      return const SizedBox(
                        height: 160,
                        child: Center(child: Text('Nenhum banner disponível')),
                      );
                    }

                    return CarouselSlider(
                      options: CarouselOptions(
                        height: 160,
                        enlargeCenterPage: true,
                        viewportFraction: 0.85,
                        autoPlay: true,
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        autoPlayInterval: const Duration(seconds: 5),
                      ),
                      items: banners.map((banner) {
                        return GestureDetector(
                          onTap: () async {
                            final url = banner['url'];
                            if (url != null && url.isNotEmpty) {
                              await _launchExternal(
                                  url); // sua função já existente
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 6,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Image.network(
                                    banner['imgUrl'] ?? '',
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Center(
                                        child: Text('Erro ao carregar imagem'),
                                      );
                                    },
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.black.withOpacity(0.2),
                                          Colors.transparent,
                                        ],
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
            ),

            // Acesso rápido (substitui o campo de pesquisa)
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: SizedBox(
                  height: 70, // compacto
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _QuickAccessButton(
                        icon: Icons.contact_mail_outlined,
                        label: 'Convites',
                        onTap: () {
                          convitesController.page.value = 1;
                          Get.toNamed('/convites');
                        },
                      ),
                      _QuickAccessButton(
                        icon: Icons.swap_horiz,
                        label: 'Acessos',
                        onTap: () {
                          visualizarAcessosEsperaController.getAcessosEspera();
                          visualizarAcessosController.getAcessos();
                          Get.toNamed('/visualizarAcessos');
                        },
                      ),
                      loginController.dep.value == '0'
                          ? _QuickAccessButton(
                              icon: Icons.group_outlined,
                              label: 'Usuários',
                              onTap: () => Get.toNamed('/dependentes'),
                            )
                          : const SizedBox.shrink(), // retorna um widget vazio

                      _QuickAccessButton(
                        icon: Icons.account_circle_outlined,
                        label: 'Perfil',
                        onTap: () => Get.toNamed('/perfil'),
                      ),
                      _QuickAccessButton(
                        icon: Icons.menu_book,
                        label: 'Tutoriais',
                        onTap: () => Get.toNamed('/Tutoriais'),
                      ),
                      _QuickAccessButton(
                        icon: Icons.shopping_cart_outlined,
                        label: 'Ache Aqui',
                        onTap: () => Get.toNamed('/acheAqui'),
                      ),
                      _QuickAccessButton(
                        icon: Icons.help_outline_rounded,
                        label: 'Ajuda',
                        onTap: () => _launchExternal(
                          'https://api.whatsapp.com/send?phone=5591981220670',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Grid de funcionalidades
            SliverPadding(
              padding: const EdgeInsets.all(20), // folga extra no fim
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  mainAxisExtent: 132,
                ),
                delegate: SliverChildListDelegate([
                  // Facial (habilita/desabilita pelo condofacial)
                  _MenuCard(
                    icon: Icons.face_5_sharp,
                    label: 'Facial',
                    subtitle: 'Reconhecimento e cadastro facial',
                    enabled: loginController.condofacial.value == "SIM",
                    onTap: loginController.condofacial.value == "SIM"
                        ? () => Get.toNamed('/facial')
                        : null,
                  ),

                  // Veículos (somente dep == 0)
                  _MenuCard(
                    icon: Icons.directions_car_outlined,
                    label: 'Veículos',
                    subtitle: 'Cadastre e visualize veículos',
                    enabled: loginController.dep.value == '0',
                    onTap: loginController.dep.value == '0'
                        ? () => Get.toNamed('/veiculos')
                        : null,
                  ),

                  _MenuCard(
                    icon: Icons.contact_mail_outlined,
                    label: 'Convites',
                    subtitle: 'Envie e gerencie seus convites',
                    onTap: () {
                      convitesController.page.value = 1;
                      Get.toNamed('/convites');
                    },
                  ),

                  _MenuCard(
                    icon: Icons.swap_horiz,
                    label: 'Acessos',
                    subtitle: 'Entradas e saídas do condomínio',
                    onTap: () {
                      visualizarAcessosEsperaController.getAcessosEspera();
                      visualizarAcessosController.getAcessos();
                      Get.toNamed('/visualizarAcessos');
                    },
                  ),

                  _MenuCard(
                    icon: Icons.date_range_outlined,
                    label: 'Reservas',
                    subtitle: 'Agende as áreas comuns',
                    onTap: () => Get.toNamed('/reserva'),
                  ),

                  _MenuCard(
                    icon: Icons.report_problem_outlined,
                    label: 'Ocorrências',
                    subtitle: 'Registre e acompanhe',
                    onTap: () => Get.toNamed('/ocorrencias'),
                  ),

                  _MenuCard(
                    icon: Icons.file_copy_outlined,
                    label: 'Documentos',
                    subtitle: 'Atas, regulamentos e mais',
                    onTap: () => Get.toNamed('/documentos'),
                  ),

                  _MenuCard(
                    icon: Icons.group_outlined,
                    label: 'Usuários',
                    subtitle: 'Moradores, prestadores e hóspedes',
                    enabled: loginController.dep.value == '0',
                    onTap: loginController.dep.value == '0'
                        ? () => Get.toNamed('/dependentes')
                        : null,
                  ),

                  _MenuCard(
                    icon: Icons.comment_outlined,
                    label: 'Avisos',
                    subtitle: 'Avisos rápidos no seu celular.',
                    onTap: () => Get.toNamed('/avisos'),
                  ),

                  _MenuCard(
                    icon: Icons.campaign_outlined,
                    label: 'Comunicados',
                    subtitle: 'Baixe os comunicados do condomínio',
                    onTap: () => Get.toNamed('/comunicados'),
                  ),

                  _MenuCard(
                    icon: Icons.live_tv_outlined,
                    label: 'CondoPlay',
                    subtitle: 'Vídeos com informações do condomínio',
                    onTap: () => Get.toNamed('/alvoTv'),
                  ),

                  _MenuCard(
                    icon: Icons.question_answer_outlined,
                    label: 'Ouvidoria',
                    subtitle: 'Fale com a administração',
                    onTap: () => Get.toNamed('/ouvidoria'),
                  ),

                  _MenuCard(
                    icon: Icons.ballot_outlined,
                    label: 'Enquetes',
                    subtitle: 'Participe das decisões',
                    onTap: () => Get.toNamed('/enquetes'),
                  ),

                  _MenuCard(
                    icon: Icons.shopping_cart_outlined,
                    label: 'Ache Aqui',
                    subtitle: 'Produtos e serviços',
                    onTap: () => Get.toNamed('/acheAqui'),
                  ),

                  _MenuCard(
                    icon: Icons.local_shipping_outlined,
                    label: 'Encomendas',
                    subtitle: 'Correspondências ou encomendas',
                    onTap: () => Get.toNamed('/encomendas'),
                  ),

                  _MenuCard(
                    icon: Icons.pets,
                    label: 'Pets',
                    subtitle: 'Cadastre seu melhor amigo(a)',
                    onTap: () => Get.toNamed('/pets'),
                  ),

                  _MenuCard(
                    icon: Icons.search,
                    label: 'Sobre',
                    subtitle: 'Saiba + sobre o CondoSócio',
                    onTap: () => Get.toNamed('/sobre'),
                  ),

                  _MenuCard(
                    icon: Icons.help_outline_rounded,
                    label: 'Central de Ajuda',
                    subtitle: 'Atendimento via WhatsApp',
                    onTap: () => _launchExternal(
                      'https://api.whatsapp.com/send?phone=5591981220670',
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ===== Widgets =====

class _QuickAccessButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickAccessButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // largura responsiva com limites
    final double screenWidth = MediaQuery.of(context).size.width;
    final double itemWidth = (screenWidth * 0.22).clamp(68.0, 110.0);

    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: itemWidth,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 22, color: Theme.of(context).primaryColor),
              const SizedBox(height: 4),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 10),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? subtitle;
  final VoidCallback? onTap;
  final bool enabled;

  const _MenuCard({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.subtitle,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fg = theme.textSelectionTheme.selectionColor ?? Colors.white;

    return InkWell(
      onTap: enabled ? onTap : null,
      borderRadius: BorderRadius.circular(12),
      child: Ink(
        decoration: BoxDecoration(
          color: enabled
              ? theme.colorScheme.secondary.withOpacity(.6)
              : theme.disabledColor.withOpacity(.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: (enabled ? theme.colorScheme.secondary : theme.disabledColor)
                .withOpacity(.20),
          ),
          boxShadow: const [
            BoxShadow(
                color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor:
                        theme.colorScheme.secondary.withOpacity(.15),
                    child: Icon(icon,
                        size: 22,
                        color: fg.withValues(alpha: enabled ? 1.0 : 0.6)),
                  ),
                  const Spacer(),
                  Icon(Icons.arrow_outward_rounded,
                      size: 16, color: fg.withValues(alpha: 0.7)),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: fg.withValues(alpha: enabled ? 1.0 : 0.6),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 2),
                Text(
                  subtitle!,
                  style: GoogleFonts.montserrat(
                    fontSize: 11,
                    color: fg.withValues(alpha: 0.78),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
