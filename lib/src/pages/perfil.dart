import 'dart:io';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:edge_alert/edge_alert.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:condosocio/src/components/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class Perfil extends StatefulWidget {
  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  LoginController loginController = Get.put(LoginController());

  TextEditingController name = new TextEditingController();
  TextEditingController gender = new TextEditingController();
  TextEditingController date = new TextEditingController();
  TextEditingController phone = new TextEditingController();

  final uri = Uri.parse("http://focuseg.com.br/flutter/upload_imagem.php");
  File _selectedFile;
  final _picker = ImagePicker();

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
                  margin: EdgeInsets.only(left: 40),
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
          //Navigator.pushNamed(context, '/Home');
        },
        child: loginController.imgperfil.value == ''
            ? Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 40),
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
              )
            : Container(
                child: Column(
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 40),
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
                        )),
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

  Future uploadImage() async {
    var request = http.MultipartRequest('POST', uri);
    request.fields['idusu'] = loginController.id.value;
    var pic = await http.MultipartFile.fromPath("image", _selectedFile.path);
    request.files.add(pic);
    var response = await request.send();

    if (response.statusCode == 200) {
      Navigator.of(context).pop();
      EdgeAlert.show(context,
          title: 'Imagem do perfil alterada',
          gravity: EdgeAlert.BOTTOM,
          backgroundColor: Colors.green,
          icon: Icons.check);
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

  void _configurandoModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            margin: EdgeInsets.only(bottom: 30),
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
                  color: Colors.blueGrey,
                ),
                ListTile(
                    leading: new Icon(
                      Icons.camera_alt,
                      color: Colors.blueGrey,
                    ),
                    title: new Text('Câmera'),
                    trailing: new Icon(
                      Icons.arrow_right,
                      color: Colors.blueGrey,
                    ),
                    onTap: () => {getImage(ImageSource.camera)}),
                Divider(
                  height: 20,
                  color: Colors.blueGrey,
                ),
                ListTile(
                    leading:
                        new Icon(Icons.collections, color: Colors.blueGrey),
                    title: new Text('Galeria de Fotos'),
                    trailing:
                        new Icon(Icons.arrow_right, color: Colors.blueGrey),
                    onTap: () => {getImage(ImageSource.gallery)}),
                Divider(
                  height: 20,
                  color: Colors.blueGrey,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            return Colors.blueGrey;
                          },
                        ),
                        shape:
                            MaterialStateProperty.resolveWith<OutlinedBorder>(
                          (Set<MaterialState> states) {
                            return RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            );
                          },
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Cancelar",
                        style: GoogleFonts.montserrat(
                            color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  //Mudar para os campos que terão no condosocio, por enquanto usando backend da focus
  bool isLoading = false;
  DateTime data = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Perfil',
            style: GoogleFonts.montserrat(fontSize: 20),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(8),
            height: MediaQuery.of(context).size.height * .95,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  children: [
                    getImageWidget(),
                    SizedBox(
                      height: 3,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2),
                      child: Text(
                        'Alterar foto de perfil',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: Text(
                    'Nome :',
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                customTextField(
                  context,
                  null,
                  '${loginController.nome.value}',
                  false,
                  1,
                  true,
                  name,
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: Text(
                    'Gênero :',
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                customTextField(
                  context,
                  null,
                  'Masculino',
                  false,
                  1,
                  true,
                  gender,
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: Text(
                    'Data de nascimento:',
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                GestureDetector(
                  onTap: () {},
                  child: customTextField(
                    context,
                    null,
                    (DateFormat("dd/MM/yyyy").format(data)),
                    false,
                    1,
                    false,
                    date,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: Text(
                    'Celular :',
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                customTextField(
                  context,
                  null,
                  '(91) 989999999',
                  false,
                  1,
                  true,
                  phone,
                ),
                SizedBox(
                  height: 10,
                ),
                ButtonTheme(
                  height: 50.0,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          return Theme.of(context).accentColor;
                        },
                      ),
                      elevation: MaterialStateProperty.resolveWith<double>(
                          (Set<MaterialState> states) {
                        return 3;
                      }),
                      shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                        (Set<MaterialState> states) {
                          return RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          );
                        },
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        isLoading = true;
                      });
                    },
                    child: isLoading
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            ),
                          )
                        : Text(
                            "ENVIAR",
                            style: GoogleFonts.montserrat(
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                                fontSize: 16),
                          ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
