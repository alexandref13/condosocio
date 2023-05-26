import 'dart:io';
import 'package:condosocio/src/components/utils/alert_button_pressed.dart';
import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/components/utils/delete_alert.dart';
import 'package:condosocio/src/controllers/acessos/saida/visualizar_acessos_saida_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class DetalhesAcessosSaida extends StatefulWidget {
  const DetalhesAcessosSaida({Key? key}) : super(key: key);

  @override
  _DetalhesAcessosSaidaState createState() => _DetalhesAcessosSaidaState();
}

class _DetalhesAcessosSaidaState extends State<DetalhesAcessosSaida> {
  VisualizarAcessosSaidaController saidaController =
      Get.put(VisualizarAcessosSaidaController());

  final picker = ImagePicker();
  File? selectedFile;

  getImage(ImageSource source) async {
    this.setState(() {});
    // ignore: deprecated_member_use
    PickedFile? image = await picker.getImage(source: source);
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
            toolbarTitle: "Imagem Para Acesso de Saída",
            statusBarColor: Colors.deepOrange.shade900,
            backgroundColor: Colors.white,
          ));

      this.setState(() {
        selectedFile = File(image.path);
        selectedFile = cropped;
        if (cropped != null) {
          saidaController.editarFoto(selectedFile!.path);
        }
      });
    }
  }

  editarFotoModalSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            color: Theme.of(context).textSelectionTheme.selectionColor!,
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
                  color: Theme.of(context).textSelectionTheme.selectionColor!,
                ),
                ListTile(
                  leading: new Icon(
                    Icons.camera_alt,
                    color: Theme.of(context).textSelectionTheme.selectionColor!,
                  ),
                  title: new Text('Câmera'),
                  trailing: new Icon(
                    Icons.arrow_right,
                    color: Theme.of(context).textSelectionTheme.selectionColor!,
                  ),
                  onTap: () => {
                    getImage(ImageSource.camera),
                  },
                ),
                Divider(
                  height: 20,
                  color: Theme.of(context).textSelectionTheme.selectionColor!,
                ),
                ListTile(
                  leading: new Icon(Icons.collections,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor!),
                  title: new Text('Galeria de Fotos'),
                  trailing: new Icon(Icons.arrow_right,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor!),
                  onTap: () => {
                    getImage(
                      ImageSource.gallery,
                    ),
                  },
                ),
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

  @override
  Widget build(BuildContext context) {
    var day = saidaController.createDate.value.split(' ');
    var hour = day[1];

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Saída',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: Theme.of(context).textSelectionTheme.selectionColor!,
            ),
          ),
        ),
        body: Obx(() {
          return saidaController.isLoading.value
              ? CircularProgressIndicatorWidget()
              : SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                child: Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(bottom: 15),
                                        child: Text(
                                          'Criado',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .textSelectionTheme
                                                .selectionColor!,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.calendar_month,
                                            color: Theme.of(context)
                                                .textSelectionTheme
                                                .selectionColor!,
                                            size: 20,
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(left: 5),
                                            child: Text(
                                              day[0],
                                              style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                color: Theme.of(context)
                                                    .textSelectionTheme
                                                    .selectionColor!,
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  top: 30,
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.watch_later_outlined,
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor!,
                                      size: 20,
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 5),
                                      child: Text(
                                        hour,
                                        style: GoogleFonts.montserrat(
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor!,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                            vertical: 40,
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 1,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor!,
                              )),
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: Icon(Icons.person_outline),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          saidaController.name.value,
                                          style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .textSelectionTheme
                                                .selectionColor!,
                                          ),
                                        ),
                                        Text(
                                          saidaController.tipo.value,
                                          style: GoogleFonts.montserrat(
                                            fontSize: 13,
                                            color: Theme.of(context)
                                                .textSelectionTheme
                                                .selectionColor!,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        saidaController.image.value != ''
                            ? GestureDetector(
                                onTap: () {
                                  editarFotoModalSheet();
                                },
                                child: Container(
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: 170),
                                        child: Icon(
                                          Icons.edit,
                                          size: 20,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor!,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .error,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ],
                                  ),
                                  width: 200,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    image: new DecorationImage(
                                      image: NetworkImage(
                                        'https://www.alvocomtec.com.br/acond/downloads/autsaida/${saidaController.image.value}',
                                      ),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                        saidaController.outDate.value == ''
                            ? Container(
                                margin: EdgeInsets.symmetric(vertical: 40),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  border: Border(
                                    top: BorderSide(
                                      width: .5,
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor!,
                                    ),
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      ButtonTheme(
                                        height: 50.0,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty
                                                    .resolveWith<Color>(
                                              (Set<MaterialState> states) {
                                                return Theme.of(context)
                                                    .errorColor;
                                              },
                                            ),
                                            shape: MaterialStateProperty
                                                .resolveWith<OutlinedBorder>(
                                              (Set<MaterialState> states) {
                                                return RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                );
                                              },
                                            ),
                                          ),
                                          onPressed: () {
                                            deleteAlert(
                                              context,
                                              'Deseja excluir o acesso?',
                                              () {
                                                Get.back();
                                                saidaController
                                                    .deleteAcessosSaida()
                                                    .then(
                                                  (value) {
                                                    if (value == 1) {
                                                      Get.offNamedUntil(
                                                          '/visualizarAcessosSaidas',
                                                          ModalRoute.withName(
                                                              '/visualizarAcessosSaidas'));
                                                    } else {
                                                      onAlertButtonPressed(
                                                          context,
                                                          'Algo deu errado\n Tente novamente',
                                                          '/home',
                                                          'sim');
                                                    }
                                                  },
                                                );
                                              },
                                            );
                                          },
                                          child: Text(
                                            "Deletar",
                                            style: GoogleFonts.montserrat(
                                              color: Theme.of(context)
                                                  .textSelectionTheme
                                                  .selectionColor!,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                );
        }));
  }
}
