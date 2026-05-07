import 'package:condosocio/src/components/home_page_app_bar/app_bar_widget.dart';
import 'package:condosocio/src/components/utils/delete_alert.dart';
import 'package:condosocio/src/components/utils/edge_alert_widget.dart';
import 'package:condosocio/src/controllers/convites/convites_controller.dart';
import 'package:condosocio/src/controllers/home_page_controller.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:condosocio/src/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:condosocio/src/pages/home/home_widget_bottomtab.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import '../../components/utils/edge_alert_error_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final LoginController loginController = Get.put(LoginController());
  final ThemeController themeController = Get.put(ThemeController());
  final HomePageController homePageController = Get.put(HomePageController());
  ConvitesController convitesController = Get.put(ConvitesController());
  String _version = '';

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((info) {
      final parts = info.version.split('.');
      setState(() => _version = '${parts[0]}.${parts.length > 1 ? parts[1] : '0'}');
    });
  }

  void onItemTapped(int index) {
    setState(() {
      loginController.selectedIndex.value = index;
    });
    if (index == 0) Get.toNamed('/dependentes');
    if (index == 1) Get.toNamed('/senha');
    if (index == 2) scaffoldKey.currentState!.openDrawer();
    if (index == 3) Get.toNamed('/alvoTv');
    if (index == 4) {
      convitesController.page.value = 1;
      Get.toNamed('/convites');
    }
  }
  //int selectedIndex = 0;

  /*void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }*/

  final _picker = ImagePicker();
  File? _selectedFile;

  final uri =
      Uri.parse("https://www.condosocio.com.br/flutter/upload_imagem.php");

  Future<void> logoutUser() async {
    await GetStorage.init();

    final box = GetStorage();
    box.erase();

    loginController.email.value.text = '';
    loginController.password.value.text = '';
    loginController.id.value = '';
    loginController.idcond.value = '';
    loginController.tipo.value = '';
    loginController.imgperfil.value = '';
    loginController.emailUsu.value = '';
    loginController.nomeCondo.value = '';
    loginController.imgcondo.value = '';
    loginController.nome.value = '';
    loginController.condoTheme.value = '';
    loginController.logradouro.value = '';
    loginController.tipoun.value = '';
    loginController.dep.value = '';
    loginController.condofacial.value = '';
    loginController.websiteAdministradora.value = '';
    loginController.idadm.value = '';

    themeController.setTheme('admin');
    //Get.offAllNamed('/login');
    Get.offNamedUntil('login', (route) => false);
  }

  Future uploadImage() async {
    var request = http.MultipartRequest('POST', uri);
    request.fields['idusu'] = loginController.id.value;
    var pic = await http.MultipartFile.fromPath("image", _selectedFile!.path);
    print(" meu arquivo => ${_selectedFile!.path}");
    request.files.add(pic);
    var response = await request.send();
    print(response.request);

    if (response.statusCode == 200) {
      loginController.newLogin(loginController.id.value);

      showToast(context, 'Parabéns!', 'Imagem do perfil alterada com sucesso.');
    } else if (response.statusCode == 404) {
      loginController.imgperfil.value = '';
    } else {
      Navigator.of(context).pop();
      showToastError(context, 'Imagem não enviada');
    }
    _selectedFile = null;
  }

  Widget getImageWidget() {
    if (_selectedFile != null) {
      return GestureDetector(
        onTap: () {
          _configurandoModalBottomSheet(context);
          //Navigator.pushNamed(context, '/Home');
        },
        child: Container(
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.only(left: 40, bottom: 5),
                  child: Center(
                    child: Icon(
                      Icons.edit,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.secondary,
                  )),
            ],
          ),
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(
              image: new FileImage(_selectedFile!),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          _configurandoModalBottomSheet(context);
        },
        child: loginController.imgperfil.value == ''
            ? Container(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 40, bottom: 5),
                      child: Center(
                        child: Icon(
                          Icons.edit,
                          size: 20,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor!,
                        ),
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('images/user.png'),
                  ),
                ),
              )
            : Container(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 40, bottom: 5),
                      child: Center(
                        child: Icon(
                          Icons.edit,
                          size: 20,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor!,
                        ),
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://www.condosocio.com.br/acond/downloads/fotosperfil/${loginController.imgperfil.value}'),
                  ),
                ),
              ),
      );
    }
  }

  /* getImage(ImageSource source) async {
    this.setState(() {});
    PickedFile? image = await _picker.getImage(source: source);
    if (image != null) {
      File? cropped = await ImageCropper().cropImage(
          sourcePath: image.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          compressQuality: 80,
          maxWidth: 400,
          maxHeight: 400,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
            toolbarColor: Colors.deepOrange,
            toolbarTitle: "Imagem para o Perfil",
            statusBarColor: Colors.deepOrange.shade900,
            backgroundColor: Colors.white,
          ));

      this.setState(() {
        _selectedFile = File(image.path);
        _selectedFile = cropped;
        if (cropped != null) {
          uploadImage();
          Get.back();
        }
      });
    }
  }*/

  Future<void> getImage(ImageSource source) async {
    final image = await _picker.pickImage(source: source);
    if (image != null) {
      final CroppedFile? cropped = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 80,
        maxWidth: 400,
        maxHeight: 400,
        compressFormat: ImageCompressFormat.jpg,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Imagem para o Perfil',
            toolbarColor: Colors.deepOrange,
            initAspectRatio: CropAspectRatioPreset.original,
            statusBarColor: Colors.deepOrange.shade900,
            backgroundColor: Colors.white,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            title: 'Cortar Imagem',
          ),
        ],
      );

      this.setState(() {
        _selectedFile = File(image.path);
        if (cropped != null) {
          _selectedFile = File(cropped.path);
          uploadImage();
          Get.back();
        }
      });
    }
  }

  void _configurandoModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            color: Theme.of(context).colorScheme.secondary,
            padding: EdgeInsets.only(bottom: 30),
            child: Wrap(
              children: <Widget>[
                ListTile(
                    title: Center(
                        child: Text(
                  "Alterar Imagem",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor!),
                ))),
                Divider(
                  height: 20,
                  color: Theme.of(context).textSelectionTheme.selectionColor!,
                ),
                ListTile(
                    leading: new Icon(
                      Icons.camera_alt,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor!,
                    ),
                    title: new Text(
                      'Câmera',
                      style: GoogleFonts.montserrat(
                          fontSize: 16,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor!),
                    ),
                    trailing: new Icon(
                      Icons.arrow_right,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor!,
                    ),
                    onTap: () => {getImage(ImageSource.camera)}),
                Divider(
                  height: 20,
                  color: Theme.of(context).textSelectionTheme.selectionColor!,
                ),
                ListTile(
                    leading: new Icon(Icons.collections,
                        color: Theme.of(context)
                            .textSelectionTheme
                            .selectionColor!),
                    title: new Text(
                      'Galeria',
                      style: GoogleFonts.montserrat(
                          fontSize: 16,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor!),
                    ),
                    trailing: new Icon(Icons.arrow_right,
                        color: Theme.of(context)
                            .textSelectionTheme
                            .selectionColor!),
                    onTap: () => {getImage(ImageSource.gallery)}),
                Divider(
                  height: 20,
                  color: Theme.of(context).textSelectionTheme.selectionColor!,
                ),
                SizedBox(
                  height: 15,
                )
              ],
            ),
          );
        });
  }

  Widget _navItem(
      BuildContext context, int index, IconData icon, String label) {
    final selected = loginController.selectedIndex.value == index;
    final color = Theme.of(context).textSelectionTheme.selectionColor!;
    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: selected
              ? color.withValues(alpha: 0.18)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(22),
        ),
        child: AnimatedScale(
          scale: selected ? 1.15 : 1.0,
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          child: Icon(icon,
              size: 22,
              color: selected ? color : color.withValues(alpha: 0.45)),
        ),
      ),
    );
  }

  Widget _centerMenuButton(BuildContext context, double size) {
    final iconColor = Theme.of(context).textSelectionTheme.selectionColor!;
    final selected = loginController.selectedIndex.value == 2;
    return _ZoomButton(
      onTap: () => onItemTapped(2),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorDark,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.menu_rounded,
          color: selected ? iconColor : iconColor.withValues(alpha: 0.45),
          size: 31,
        ),
      ),
    );
  }

  Widget _drawerItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? iconColor,
    Color? titleColor,
  }) {
    final color = Theme.of(context).textSelectionTheme.selectionColor!;
    final iColor = iconColor ?? color;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: iColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: iColor, size: 18),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.montserrat(
                  color: titleColor ?? color,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(Icons.chevron_right,
                color: iColor.withValues(alpha: 0.35), size: 16),
          ],
        ),
      ),
    );
  }

  Widget _socialIconDrawer(
      BuildContext context, IconData icon, VoidCallback onTap) {
    final color = Theme.of(context).textSelectionTheme.selectionColor!;
    return IconButton(
      icon: FaIcon(icon, size: 14),
      onPressed: onTap,
      color: color.withValues(alpha: 0.6),
      padding: const EdgeInsets.all(8),
      constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
    );
  }

  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          deleteAlert(context, 'Deseja realmente sair?', () {
            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          });
        }
      },
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBarWidget(
          onTap: () {
            scaffoldKey.currentState!.openDrawer();
          },
          image: loginController.imgcondo.value,
        ),
	        drawer: Drawer(
	          backgroundColor:
	              Theme.of(context).colorScheme.secondary.withValues(alpha: 0.92),
	          child: Column(
	            children: [
	              // Header
		              Container(
		                width: double.infinity,
		                padding: const EdgeInsets.fromLTRB(20, 56, 20, 24),
		                color: Theme.of(context)
		                    .primaryColor
		                    .withValues(alpha: 0.88),
		                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    getImageWidget(),
                    const SizedBox(height: 12),
                    Text(
                      '${loginController.nome.value} ${loginController.sobrenome.value}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        color: Theme.of(context)
                            .textSelectionTheme
                            .selectionColor!,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      loginController.emailUsu.value,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        color: Theme.of(context)
                            .textSelectionTheme
                            .selectionColor!
                            .withValues(alpha: 0.7),
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${loginController.logradouro.value} | ${loginController.tipoun.value}',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        color: Theme.of(context)
                            .textSelectionTheme
                            .selectionColor!
                            .withValues(alpha: 0.6),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              // Menu items
              Expanded(
                child: ListView(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  children: [
                    if (loginController.idadm.value != '0')
                      _drawerItem(
                        context: context,
                        icon: Icons.paid_outlined,
                        title: 'Boleto 2ª Via',
                        onTap: () => Get.toNamed('/boleto'),
                      ),
                    if (loginController.haveListOfCondo.value)
                      _drawerItem(
                        context: context,
                        icon: Icons.home_outlined,
                        title: 'Unidades',
                        onTap: () {
                          loginController.idcond.value = '';
                          loginController.hasMoreEmail(
                              loginController.emailUsu.value);
                          Get.toNamed('/listOfCondo');
                        },
                      ),
                    _drawerItem(
                      context: context,
                      icon: Icons.account_circle_outlined,
                      title: 'Perfil',
                      onTap: () => Get.toNamed('/perfil'),
                    ),
                    _drawerItem(
                      context: context,
                      icon: Icons.lock_outline,
                      title: 'Senha',
                      onTap: () => Get.toNamed('/senha'),
                    ),
                    _drawerItem(
                      context: context,
                      icon: Icons.info_outline_rounded,
                      title: 'Sobre',
                      onTap: () => Get.toNamed('/sobre'),
                    ),
                    _drawerItem(
                      context: context,
                      icon: Icons.menu_book,
                      title: 'Tutoriais',
                      onTap: () => Get.toNamed('/Tutoriais'),
                    ),
                    _drawerItem(
                      context: context,
                      icon: Icons.gavel_outlined,
                      title: 'Termos de Uso',
                      onTap: () => Get.toNamed('/webview', arguments: {
                        'url': 'https://www.condosocio.com.br/termo.html',
                        'titulo': 'Termos de Uso',
                      }),
                    ),
                    _drawerItem(
                      context: context,
                      icon: Icons.verified_user_outlined,
                      title: 'Política de Privacidade',
                      onTap: () => Get.toNamed('/webview', arguments: {
                        'url': 'https://www.condosocio.com.br/privacidade.html',
                        'titulo': 'Política de Privacidade',
                      }),
                    ),
                    _drawerItem(
                      context: context,
                      icon: Icons.star_border_outlined,
                      title: 'Avalie o app',
                      onTap: () => homePageController.launched =
                          homePageController
                              .launchInBrowser('http://onelink.to/r8p97m'),
                    ),
                    const SizedBox(height: 8),
                    Divider(
                      color: Theme.of(context)
                          .textSelectionTheme
                          .selectionColor!
                          .withValues(alpha: 0.15),
                      height: 1,
                    ),
                    const SizedBox(height: 8),
                    _drawerItem(
                      context: context,
                      icon: Icons.exit_to_app,
                      title: 'Sair',
                      onTap: logoutUser,
                      iconColor: Colors.redAccent,
                      titleColor: Colors.redAccent,
                    ),
                  ],
                ),
              ),
              // Footer
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Theme.of(context)
                          .textSelectionTheme
                          .selectionColor!
                          .withValues(alpha: 0.1),
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Image.asset('images/condosocio_logo.png', width: 70),
                    const SizedBox(height: 6),
                    Text(
                      'Versão $_version',
                      style: GoogleFonts.montserrat(
                        color: Theme.of(context)
                            .textSelectionTheme
                            .selectionColor!
                            .withValues(alpha: 0.5),
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _socialIconDrawer(
                            context,
                            FontAwesomeIcons.globe,
                            () => homePageController.launched =
                                homePageController.launchInBrowser(
                                    'https://www.condosocio.com.br')),
                        _socialIconDrawer(
                            context,
                            FontAwesomeIcons.facebook,
                            () => homePageController.launched =
                                homePageController.launchInBrowser(
                                    'https://www.facebook.com/condosocio')),
                        _socialIconDrawer(
                            context,
                            FontAwesomeIcons.youtube,
                            () => homePageController.launched =
                                homePageController.launchInBrowser(
                                    'https://www.youtube.com/channel/UCLPOsAW7jbawmz7nB3UeDvg')),
                        _socialIconDrawer(
                            context,
                            FontAwesomeIcons.instagram,
                            () => homePageController.launched =
                                homePageController.launchInBrowser(
                                    'https://www.instagram.com/condosocioapp')),
                        _socialIconDrawer(
                            context,
                            FontAwesomeIcons.whatsapp,
                            () => homePageController.launched =
                                homePageController.launchInBrowser(
                                    'https://api.whatsapp.com/send?phone=5591981220670')),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Obx(() {
          const barHeight = 62.0;
          const buttonSize = 70.0;
          const floatLift = 20.0;
          final bottomPad = MediaQuery.of(context).padding.bottom;
          final barMarginBottom = bottomPad > 0 ? bottomPad : 12.0;
          final totalHeight = barMarginBottom + barHeight + floatLift + 4;

          return SizedBox(
            height: totalHeight,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(16, 0, 16, barMarginBottom),
                    height: barHeight,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorDark,
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _navItem(context, 0, Icons.people_outline_rounded, 'Usuários'),
                        _navItem(context, 1, Icons.lock_outline_rounded, 'Senha'),
                        const SizedBox(width: buttonSize),
                        _navItem(context, 3, Icons.play_circle_outline_rounded, 'CondoPlay'),
                        _navItem(context, 4, Icons.card_travel_outlined, 'Convites'),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: barMarginBottom + barHeight / 2 - buttonSize / 2 + floatLift / 2,
                  child: _centerMenuButton(context, buttonSize),
                ),
              ],
            ),
          );
        }),
        // body: bottomNavigationList[loginController.selectedIndex.value],

        body: Center(child: HomeBottomTab()),
      ),
    );
  }
}

class _ZoomButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  const _ZoomButton({required this.child, required this.onTap});

  @override
  State<_ZoomButton> createState() => _ZoomButtonState();
}

class _ZoomButtonState extends State<_ZoomButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 140),
      lowerBound: 0.0,
      upperBound: 1.0,
    );
    _scale = Tween<double>(begin: 1.0, end: 0.88).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) {
        _ctrl.reverse();
        widget.onTap();
      },
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(scale: _scale, child: widget.child),
    );
  }
}
