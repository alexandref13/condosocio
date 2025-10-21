import 'dart:io';
import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/components/utils/confirmed_button_pressed.dart';
import 'package:condosocio/src/controllers/pets_controller.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:condosocio/src/components/utils/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../../components/utils/alert_button_pressed.dart';

class AdicionaPets extends StatefulWidget {
  @override
  _AdicionaPetsState createState() => _AdicionaPetsState();
}

class _AdicionaPetsState extends State<AdicionaPets> {
  PetsController petsController = Get.put(PetsController());
  final LoginController loginController = Get.put(LoginController());

  bool _isVisible = true;

  var startSelectedDate = DateTime.now();
  var startSelectedTime = TimeOfDay.now();
  var endSelectedDate = DateTime.now();
  var endSelectedTime = TimeOfDay.now();
  var startDate = TextEditingController();
  var startTime = TextEditingController();
  var endDate = TextEditingController();
  var endTime = TextEditingController();

  final picker = ImagePicker();
  File? selectedFile;
  bool _sending = false; // no seu State

  void dropDownFavoriteSelected(String novoItem) {
    petsController.firstId.value = novoItem;
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> getImage(ImageSource source) async {
    final image = await picker.pickImage(source: source);
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
            toolbarTitle: 'Imagem para o Pet',
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

      if (cropped != null) {
        setState(() {
          selectedFile = File(cropped.path); // ✅ usa a foto cortada
          if (Get.isBottomSheetOpen == true) {
            print('[getImage] closing bottom sheet with Get.back()');
            Get.back();
          }
        });
      }
    }
  }

  ModalBottomSheet() {
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
                  "Anexar Imagem",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Theme.of(context).textSelectionTheme.selectionColor!,
                  ),
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
                  title: new Text(
                    'Câmera',
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor!,
                    ),
                  ),
                  trailing: new Icon(
                    Icons.arrow_right,
                    color: Theme.of(context).textSelectionTheme.selectionColor!,
                  ),
                  onTap: () async {
                    Navigator.pop(context); // fecha o bottom sheet
                    await getImage(
                        ImageSource.camera); // depois abre picker/cropper
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
                  title: new Text(
                    'Galeria',
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor!,
                    ),
                  ),
                  trailing: new Icon(Icons.arrow_right,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor!),
                  onTap: () async {
                    Navigator.pop(context);
                    await getImage(ImageSource.gallery);
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
    return Obx(() {
      return petsController.isLoading.value
          ? CircularProgressIndicatorWidget()
          : SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.only(bottom: 10, top: 20),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 7),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor!,
                                width: 1,
                              ),
                            ),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              underline: Container(),
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                size: 27,
                              ),
                              iconEnabledColor: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor!,
                              dropdownColor: Theme.of(context).primaryColor,
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor!,
                              ),
                              items: petsController.tipo
                                  .map((String dropDownStringItem) {
                                return DropdownMenuItem<String>(
                                  value: dropDownStringItem,
                                  child: Text(dropDownStringItem),
                                );
                              }).toList(),
                              onChanged: (String? novoItemTipo) {
                                dropDownFavoriteSelected(novoItemTipo!);
                                petsController.tipos.value = novoItemTipo;
                              },
                              value: petsController.tipos.value,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Visibility(
                            visible: _isVisible,
                            child: customTextField(
                              context,
                              '',
                              'Nome do Pet',
                              false,
                              1,
                              50,
                              true,
                              petsController.nome.value,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          customTextField(
                            context,
                            '',
                            'Raça',
                            false,
                            1,
                            100,
                            true,
                            petsController.raca.value,
                          ),
                          Obx(() => Row(
                                children: [
                                  // Tema local só pra este checkbox (opcional, deixa mais consistente)
                                  Theme(
                                    data: Theme.of(context).copyWith(
                                      checkboxTheme: CheckboxThemeData(
                                        // borda branca em qualquer estado
                                        side: const BorderSide(
                                            color: Colors.white, width: 2),
                                        // cor do check
                                        checkColor:
                                            const MaterialStatePropertyAll<
                                                Color>(Colors.white),
                                        // preenchimento: primário quando marcado, transparente quando desmarcado
                                        fillColor: MaterialStateProperty
                                            .resolveWith<Color?>((states) {
                                          if (states.contains(
                                              MaterialState.selected)) {
                                            return Theme.of(context)
                                                .primaryColor;
                                          }
                                          return Colors.transparent;
                                        }),
                                      ),
                                    ),
                                    child: Checkbox(
                                      // se quiser “modo erro” como no sample:
                                      // isError: true, // (opcional – tingiria com a cor de erro)
                                      value: petsController.semRaca.value,
                                      onChanged: (bool? value) {
                                        petsController.semRaca.value =
                                            value ?? false;
                                        if (petsController.semRaca.value) {
                                          petsController.raca.value.text =
                                              'Sem raça definida';
                                        } else {
                                          petsController.raca.value.clear();
                                        }
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Sem raça definida',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              )),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 7),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor!,
                                width: 1,
                              ),
                            ),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              underline: Container(),
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                size: 27,
                              ),
                              iconEnabledColor: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor!,
                              dropdownColor: Theme.of(context).primaryColor,
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor!,
                              ),
                              items: petsController.sex
                                  .map((String dropDownStringItem) {
                                return DropdownMenuItem<String>(
                                  value: dropDownStringItem,
                                  child: Text(dropDownStringItem),
                                );
                              }).toList(),
                              onChanged: (String? novoItemSexo) {
                                dropDownFavoriteSelected(novoItemSexo!);
                                petsController.sexo.value = novoItemSexo;
                              },
                              value: petsController.sexo.value,
                            ),
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          Obx(
                            () => petsController.noBirthdate.value
                                ? const SizedBox
                                    .shrink() // não mostra nada quando marcado
                                : TextField(
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      petsController.birthDateMaskFormatter
                                    ],
                                    controller: petsController.birthdate.value,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor!,
                                    ),
                                    decoration: InputDecoration(
                                      labelText: 'Data de aniversário',
                                      labelStyle: GoogleFonts.montserrat(
                                        fontSize: 14,
                                        color: Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor!,
                                      ),
                                      isDense: true,
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor!,
                                          width: 2,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor!,
                                          width: 1,
                                        ),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor!,
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                          /* Obx(() => Row(
                                children: [
                                  // Tema local só pra este checkbox (opcional, deixa mais consistente)
                                  Theme(
                                    data: Theme.of(context).copyWith(
                                      checkboxTheme: CheckboxThemeData(
                                        // borda branca em qualquer estado
                                        side: const BorderSide(
                                            color: Colors.white, width: 2),
                                        // cor do check
                                        checkColor:
                                            const MaterialStatePropertyAll<
                                                Color>(Colors.white),
                                        // preenchimento: primário quando marcado, transparente quando desmarcado
                                        fillColor: MaterialStateProperty
                                            .resolveWith<Color?>((states) {
                                          if (states.contains(
                                              MaterialState.selected)) {
                                            return Theme.of(context)
                                                .primaryColor;
                                          }
                                          return Colors.transparent;
                                        }),
                                      ),
                                    ),
                                    child: Checkbox(
                                      value: petsController.noBirthdate.value,
                                      onChanged: (v) {
                                        petsController.noBirthdate.value =
                                            v ?? false;
                                        if (v == true) {
                                          petsController.birthdate.value
                                              .clear(); // limpa ao ocultar
                                        }
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Sem data de aniversário',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              )),*/
                          SizedBox(
                            height: 15,
                          ),
                          selectedFile != null
                              ? Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle, // deixa redondo
                                    image: DecorationImage(
                                      image: FileImage(selectedFile!),
                                      fit: BoxFit
                                          .cover, // preenche bem o círculo
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26, // cor da sombra
                                        blurRadius: 4, // espalhamento
                                        offset:
                                            Offset(0, 8), // deslocamento (x,y)
                                      ),
                                    ],
                                  ),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          selectedFile = null;
                                        });
                                      },
                                      icon: Icon(
                                        Icons.close,
                                        size: 20,
                                        color: Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor!,
                                      ),
                                    ),
                                  ),
                                )
                              : Column(
                                  children: [
                                    SizedBox(height: 20),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: ElevatedButton.icon(
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty
                                              .resolveWith<Color>(
                                            (states) => Theme.of(context)
                                                .textSelectionTheme
                                                .selectionColor!,
                                          ),
                                          elevation:
                                              MaterialStateProperty.all(3),
                                          shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                          ),
                                        ),
                                        onPressed: () {
                                          ModalBottomSheet();
                                        },
                                        icon: Icon(
                                          Icons.pets,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          size: 20,
                                        ),
                                        label: Text(
                                          "Escolha uma foto do seu pet",
                                          style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(bottom: 20, left: 10, right: 10),
                      child: ButtonTheme(
                        height: 50.0,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                return Theme.of(context).colorScheme.secondary;
                              },
                            ),
                            shape: MaterialStateProperty.resolveWith<
                                OutlinedBorder>(
                              (Set<MaterialState> states) {
                                return RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                );
                              },
                            ),
                          ),
                          onPressed: _sending
                              ? null // desabilita botão durante envio
                              : () async {
                                  // validação rápida no cliente
                                  if (!petsController.isValidForm()) {
                                    onAlertButtonPressed(
                                      context,
                                      'Campo obrigatório vazio',
                                      '',
                                      'images/error.png',
                                    );
                                    return;
                                  }

                                  setState(() => _sending = true);
                                  try {
                                    final path = selectedFile?.path ?? '';
                                    final result = await petsController.sendPets(
                                        path); // deve retornar "1", "0" ou "vazio"

                                    // Normaliza só por segurança
                                    switch (result.trim()) {
                                      case 'vazio':
                                        onAlertButtonPressed(
                                          context,
                                          'Campo obrigatório vazio',
                                          '',
                                          'images/error.png',
                                        );
                                        break;

                                      case '1':
                                        confirmedButtonPressed(
                                          context,
                                          'Seu pet foi cadastrado com sucesso!',
                                          'home', // ajuste a rota que você quer abrir depois
                                        );
                                        // opcional: limpar estado local
                                        setState(() {
                                          selectedFile = null;
                                        });
                                        break;

                                      default: // "0" ou qualquer outra coisa
                                        onAlertButtonPressed(
                                          context,
                                          'Houve algum problema!\nTente novamente',
                                          '',
                                          'images/error.png',
                                        );
                                    }
                                  } catch (e) {
                                    onAlertButtonPressed(
                                      context,
                                      'Erro inesperado: $e',
                                      '',
                                      'images/error.png',
                                    );
                                  } finally {
                                    if (mounted)
                                      setState(() => _sending = false);
                                  }
                                },
                          child: _sending
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child:
                                      CircularProgressIndicator(strokeWidth: 2),
                                )
                              : Text(
                                  'Adicionar',
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor!,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
    });
  }
}
