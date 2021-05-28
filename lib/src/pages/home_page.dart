import 'package:condosocio/src/components/home_page_app_bar/app_bar_widget.dart';
import 'package:condosocio/src/components/utils/delete_alert.dart';
import 'package:condosocio/src/components/utils/edge_alert_widget.dart';
import 'package:condosocio/src/controllers/home_page_controller.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:condosocio/src/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:condosocio/src/components/home_widget_bottomtab.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:edge_alert/edge_alert.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final LoginController loginController = Get.put(LoginController());
  final ThemeController themeController = Get.put(ThemeController());
  final HomePageController homePageController = Get.put(HomePageController());

  int selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  final _picker = ImagePicker();
  File _selectedFile;

  final uri = Uri.parse("https://condosocio.com.br/flutter/upload_imagem.php");

  Future<void> logoutUser() async {
    await GetStorage.init();

    final box = GetStorage();
    box.erase();

    loginController.email.value.text = '';
    loginController.password.value.text = '';
    themeController.setTheme('admin');
    Get.offAllNamed('/login');
  }

  Future uploadImage() async {
    var request = http.MultipartRequest('POST', uri);
    request.fields['idusu'] = loginController.id.value;
    var pic = await http.MultipartFile.fromPath("image", _selectedFile.path);
    print(" meu arquivo => ${_selectedFile.path}");
    request.files.add(pic);
    var response = await request.send();
    print(response.request);

    if (response.statusCode == 200) {
      Navigator.of(context).pop();
      edgeAlertWidget(context, 'Imagem do perfil alterada');
    } else if (response.statusCode == 404) {
      loginController.imgperfil.value = '';
    } else {
      Navigator.of(context).pop();
      EdgeAlert.show(context,
          title: 'Imagem não enviada',
          gravity: EdgeAlert.BOTTOM,
          backgroundColor: Colors.red,
          icon: Icons.highlight_off);
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
                    color: Colors.red[900],
                  )),
            ],
          ),
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(
              image: new FileImage(_selectedFile),
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
                              .selectionColor,
                        ),
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).accentColor,
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
                              .selectionColor,
                        ),
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).accentColor,
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
                        'https://condosocio.com.br/acond/downloads/fotosperfil/${loginController.imgperfil.value}'),
                  ),
                ),
              ),
      );
    }
  }

  getImage(ImageSource source) async {
    this.setState(() {});
    PickedFile image = await _picker.getImage(source: source);
    if (image != null) {
      File cropped = await ImageCropper.cropImage(
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
        }
      });
    }
  }

  void _configurandoModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            color: Theme.of(context).accentColor,
            padding: EdgeInsets.only(bottom: 30),
            child: Wrap(
              children: <Widget>[
                ListTile(
                    title: Center(
                        child: Text(
                  "Alterar Imagem",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600, fontSize: 18),
                ))),
                Divider(
                  height: 20,
                  color: Theme.of(context).textSelectionTheme.selectionColor,
                ),
                ListTile(
                    leading: new Icon(
                      Icons.camera_alt,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                    ),
                    title: new Text('Câmera'),
                    trailing: new Icon(
                      Icons.arrow_right,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                    ),
                    onTap: () => {getImage(ImageSource.camera)}),
                Divider(
                  height: 20,
                  color: Theme.of(context).textSelectionTheme.selectionColor,
                ),
                ListTile(
                    leading: new Icon(Icons.collections,
                        color: Theme.of(context)
                            .textSelectionTheme
                            .selectionColor),
                    title: new Text('Galeria de Fotos'),
                    trailing: new Icon(Icons.arrow_right,
                        color: Theme.of(context)
                            .textSelectionTheme
                            .selectionColor),
                    onTap: () => {getImage(ImageSource.gallery)}),
                Divider(
                  height: 20,
                  color: Theme.of(context).textSelectionTheme.selectionColor,
                ),
                SizedBox(
                  height: 15,
                )
              ],
            ),
          );
        });
  }

  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        deleteAlert(context, 'Deseja realmente sair?', () {
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        });
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          key: scaffoldKey,
          appBar: AppBarWidget(
            context: context,
            onTap: () {
              scaffoldKey.currentState.openDrawer();
            },
            image: loginController.imgcondo.value,
          ),
          drawer: Drawer(
            child: Container(
              color: Theme.of(context).accentColor,
              child: ListView(
                children: <Widget>[
                  DrawerHeader(
                      padding: EdgeInsets.all(0),
                      child: Container(
                        padding: EdgeInsets.only(top: 15),
                        color: Theme.of(context).primaryColor,
                        child: Column(
                          children: <Widget>[
                            getImageWidget(),
                            Container(
                              child: Text(
                                '${loginController.nome.value}',
                                style: GoogleFonts.montserrat(
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 2),
                              child: Text(
                                '${loginController.emailUsu.value}',
                                style: GoogleFonts.montserrat(
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 2),
                              child: Text(
                                '${loginController.tipo.value} | ${loginController.unidade.value}',
                                style: GoogleFonts.montserrat(
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                  Column(
                    children: <Widget>[
                      Container(
                        child: ListTile(
                          contentPadding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                          dense: true,
                          title: Text(
                            'Unidades',
                            style: GoogleFonts.montserrat(
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                              fontSize: 14,
                            ),
                          ),
                          leading: Icon(
                            Feather.home,
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                            size: 22,
                          ),
                          onTap: () {
                            loginController.hasMoreEmail(
                              loginController.emailUsu.value,
                            );
                            Get.toNamed('/listOfCondo');
                          },
                        ),
                      ),
                      Divider(
                        height: 5,
                        color: Theme.of(context).primaryColor,
                      ),
                      loginController.dep.value == '0'
                          ? Container(
                              child: ListTile(
                                contentPadding:
                                    EdgeInsets.fromLTRB(15, 0, 10, 0),
                                dense: true,
                                title: Text(
                                  'Dependentes',
                                  style: GoogleFonts.montserrat(
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
                                    fontSize: 14,
                                  ),
                                ),
                                leading: Icon(
                                  Feather.users,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor,
                                  size: 22,
                                ),
                                onTap: () {
                                  Get.toNamed('/dependentes');
                                },
                              ),
                            )
                          : Container(),
                      Divider(
                        height: 5,
                        color: Theme.of(context).primaryColor,
                      ),
                      Container(
                        child: ListTile(
                          contentPadding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                          dense: true,
                          title: Text(
                            'Perfil',
                            style: GoogleFonts.montserrat(
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                              fontSize: 14,
                            ),
                          ),
                          leading: Icon(
                            Icons.person_outline,
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                            size: 22,
                          ),
                          onTap: () {
                            Get.toNamed('/perfil');
                          },
                        ),
                      ),
                      Divider(
                        height: 5,
                        color: Theme.of(context).primaryColor,
                      ),
                      Container(
                        child: ListTile(
                          contentPadding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                          dense: true,
                          title: Text(
                            'Senha',
                            style: GoogleFonts.montserrat(
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                              fontSize: 14,
                            ),
                          ),
                          leading: Icon(
                            FontAwesome.info_circle,
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                            size: 22,
                          ),
                          onTap: () {
                            Get.toNamed('/senha');
                          },
                        ),
                      ),
                      Divider(
                        height: 5,
                        color: Theme.of(context).primaryColor,
                      ),
                      Container(
                        child: ListTile(
                          contentPadding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                          dense: true,
                          title: Text(
                            'Sobre',
                            style: GoogleFonts.montserrat(
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                              fontSize: 14,
                            ),
                          ),
                          leading: Icon(
                            Icons.help,
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                            size: 22,
                          ),
                          onTap: () {
                            Get.toNamed('/sobre');
                          },
                        ),
                      ),
                      Divider(
                        height: 5,
                        color: Theme.of(context).primaryColor,
                      ),
                      Container(
                        child: ListTile(
                          contentPadding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                          dense: true,
                          title: Text(
                            'Termos de Uso',
                            style: GoogleFonts.montserrat(
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                              fontSize: 14,
                            ),
                          ),
                          leading: Icon(
                            FontAwesome.check_square_o,
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                            size: 22,
                          ),
                          onTap: () {
                            homePageController.launched =
                                homePageController.launchInBrowser(
                                    'https://condosocio.com.br/termo.html');
                          },
                        ),
                      ),
                      Divider(
                        height: 5,
                        color: Theme.of(context).primaryColor,
                      ),
                      Container(
                        child: ListTile(
                          contentPadding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                          dense: true,
                          title: Text(
                            'Política de Privacidade',
                            style: GoogleFonts.montserrat(
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                              fontSize: 14,
                            ),
                          ),
                          leading: Icon(
                            FontAwesome.shield,
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                            size: 22,
                          ),
                          onTap: () {
                            homePageController.launched =
                                homePageController.launchInBrowser(
                                    'https://condosocio.com.br/privacidade.html');
                          },
                        ),
                      ),
                      Divider(
                        height: 5,
                        color: Theme.of(context).primaryColor,
                      ),
                      Container(
                        child: ListTile(
                          contentPadding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                          dense: true,
                          title: Text(
                            'Avalie o app',
                            style: GoogleFonts.montserrat(
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                              fontSize: 14,
                            ),
                          ),
                          leading: Icon(
                            Feather.star,
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                            size: 22,
                          ),
                          onTap: () {
                            homePageController.launched = homePageController
                                .launchInBrowser('http://onelink.to/r8p97m');
                          },
                        ),
                      ),
                      Divider(
                        height: 5,
                        color: Theme.of(context).primaryColor,
                      ),
                      Container(
                        child: ListTile(
                          contentPadding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                          dense: true,
                          title: Text(
                            'Ajuda',
                            style: GoogleFonts.montserrat(
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                              fontSize: 14,
                            ),
                          ),
                          leading: Icon(
                            FontAwesome.question_circle,
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                            size: 22,
                          ),
                          onTap: () {
                            homePageController.launched =
                                homePageController.launchInBrowser(
                              'https://api.whatsapp.com/send?phone=5591981220670',
                            );
                          },
                        ),
                      ),
                      Divider(
                        height: 5,
                        color: Theme.of(context).primaryColor,
                      ),
                      Container(
                        child: ListTile(
                          contentPadding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                          dense: true,
                          title: Text(
                            'Sair',
                            style: GoogleFonts.montserrat(
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                              fontSize: 14,
                            ),
                          ),
                          leading: Icon(
                            Icons.exit_to_app,
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                            size: 22,
                          ),
                          onTap: () {
                            logoutUser();
                          },
                        ),
                      ),
                      Divider(
                        height: 15,
                        color: Theme.of(context).primaryColor,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          body: Center(child: HomeBottomTab()),
        ),
      ),
    );
  }
}
