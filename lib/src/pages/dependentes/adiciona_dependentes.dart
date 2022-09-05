import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/controllers/dependentes_controller.dart';
import 'package:condosocio/src/controllers/perfil_controller.dart';
import 'package:email_validator/email_validator.dart';
import 'package:get/get.dart';
import 'package:condosocio/src/components/utils/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AdicionaDependentes extends StatefulWidget {
  @override
  _AdicionaDependentesState createState() => _AdicionaDependentesState();
}

class _AdicionaDependentesState extends State<AdicionaDependentes> {
  DependentesController dependentesController =
      Get.put(DependentesController());

  PerfilController perfilController = Get.put(PerfilController());
  bool _isVisible = true;
  bool _isCkeckAcesso = false;

  var startSelectedDate = DateTime.now();
  var startSelectedTime = TimeOfDay.now();
  var endSelectedDate = DateTime.now();
  var endSelectedTime = TimeOfDay.now();
  var startDate = TextEditingController();
  var startTime = TextEditingController();
  var endDate = TextEditingController();
  var endTime = TextEditingController();

  Future<TimeOfDay> selectTime(BuildContext context) {
    final now = DateTime.now();
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: now.hour, minute: now.minute),
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child);
      },
    );
  }

  Future<TimeOfDay> selectEndTime(BuildContext context) {
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 23, minute: 59),
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child);
      },
    );
  }

  Future<DateTime> selectDateTime(BuildContext context) => showDatePicker(
        context: context,
        initialDate: DateTime.now().add(Duration(seconds: 1)),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100),
      );

  Future<DateTime> selectDateOnEndTime(BuildContext context) => showDatePicker(
        context: context,
        initialDate: startSelectedDate,
        firstDate: startSelectedDate,
        lastDate: DateTime(2030),
      );

  void dropDownFavoriteSelected(String novoItem) {
    dependentesController.firstId.value = novoItem;
  }

  @override
  void initState() {
    var formatDate = dependentesController.endDate.value != ''
        ? DateTime.parse(dependentesController.endDate.value)
        : null;

    dependentesController.endDate.value != ''
        ? endSelectedDate = DateTime(
            formatDate.year,
            formatDate.month,
            formatDate.day,
            formatDate.hour,
            formatDate.minute,
          )
        : endSelectedDate = DateTime(
            startSelectedDate.year,
            startSelectedDate.month,
            startSelectedDate.day,
            23,
            59,
          );

    dependentesController.endDate.value != ''
        ? startSelectedDate = DateTime(
            formatDate.year,
            formatDate.month,
            formatDate.day,
            formatDate.hour,
            formatDate.minute,
          )
        : startSelectedDate = DateTime(
            startSelectedDate.year,
            startSelectedDate.month,
            startSelectedDate.day,
            startSelectedTime.hour,
            startSelectedTime.minute,
          );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return dependentesController.isLoading.value
          ? CircularProgressIndicatorWidget()
          : SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.all(8),
                height: MediaQuery.of(context).size.height * .95,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 7),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
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
                        iconEnabledColor:
                            Theme.of(context).textSelectionTheme.selectionColor,
                        dropdownColor: Theme.of(context).primaryColor,
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                        ),
                        items: dependentesController.tiposUsuarios
                            .map((String dropDownStringItem) {
                          return DropdownMenuItem<String>(
                            value: dropDownStringItem,
                            child: Text(dropDownStringItem),
                          );
                        }).toList(),
                        onChanged: (String novoItemSelecionado) {
                          dropDownFavoriteSelected(novoItemSelecionado);
                          dependentesController.tipoUsuario.value =
                              novoItemSelecionado;
                        },
                        value: dependentesController.tipoUsuario.value,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    if (dependentesController.tipoUsuario.value == "Morador")
                      Visibility(
                        visible: _isVisible,
                        child: customTextField(
                          context,
                          'Nome',
                          null,
                          false,
                          1,
                          true,
                          dependentesController.nome.value,
                        ),
                      ),
                    SizedBox(
                      height: 15,
                    ),
                    customTextField(
                      context,
                      'Sobrenome',
                      null,
                      false,
                      1,
                      true,
                      dependentesController.sobrenome.value,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 7),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
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
                        iconEnabledColor:
                            Theme.of(context).textSelectionTheme.selectionColor,
                        dropdownColor: Theme.of(context).primaryColor,
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                        ),
                        items: dependentesController.tipos
                            .map((String dropDownStringItem) {
                          return DropdownMenuItem<String>(
                            value: dropDownStringItem,
                            child: Text(dropDownStringItem),
                          );
                        }).toList(),
                        onChanged: (String novoItemSelecionado) {
                          dropDownFavoriteSelected(novoItemSelecionado);
                          dependentesController.itemSelecionado.value =
                              novoItemSelecionado;
                        },
                        value: dependentesController.itemSelecionado.value,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      //enabled: !dependentesController.isLoading.value,
                      style: GoogleFonts.montserrat(
                        color:
                            Theme.of(context).textSelectionTheme.selectionColor,
                      ),
                      decoration: InputDecoration(
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 15, horizontal: 15),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                              width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor)),
                        labelText: 'E-mail',
                        labelStyle: GoogleFonts.montserrat(
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                            fontSize: 14),
                        errorBorder: new OutlineInputBorder(
                            borderSide: new BorderSide(
                                color: Theme.of(context).accentColor)),
                        focusedErrorBorder: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.red[900])),
                        errorStyle: GoogleFonts.montserrat(
                            color: Theme.of(context).errorColor),
                      ),
                      keyboardType: TextInputType.emailAddress,

                      validator: (valueEmail) {
                        if (!EmailValidator.validate(valueEmail)) {
                          return 'Entre com e-mail válido!';
                        }
                        return null;
                      },
                      controller: dependentesController.email.value,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [perfilController.cellMaskFormatter],
                      controller: dependentesController.celular.value,
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        color:
                            Theme.of(context).textSelectionTheme.selectionColor,
                      ),
                      decoration: InputDecoration(
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                            width: 1,
                          ),
                        ),
                        labelText: 'Celular',
                        labelStyle: GoogleFonts.montserrat(
                          fontSize: 14,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                        ),
                        isDense: true,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                            width: 2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: <Widget>[
                        Spacer(),
                        Column(
                          children: [
                            Text(
                              'Acesso Livre (N/S)',
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            ValueBuilder<bool>(
                                initialValue: _isCkeckAcesso,
                                builder: (isChecked, updateFn) => Switch(
                                      value: isChecked,
                                      onChanged: (newValue) =>
                                          updateFn(newValue),
                                      activeColor:
                                          Theme.of(context).shadowColor,
                                    ),
                                onUpdate: (svalue) => _isCkeckAcesso = svalue),
                          ],
                        ),
                        Spacer(),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /*
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                startSelectedTime = await selectTime(context);
                                if (startSelectedTime == null) return;

                                setState(() {
                                  startSelectedDate = DateTime(
                                    startSelectedDate.year,
                                    startSelectedDate.month,
                                    startSelectedDate.day,
                                    startSelectedTime.hour,
                                    startSelectedTime.minute,
                                  );
                                });
                              },
                              child: customTextField(
                                context,
                                DateFormat("HH:mm").format(
                                  startSelectedDate,
                                ),
                                DateFormat("HH:mm").format(
                                  startSelectedDate,
                                ),
                                false,
                                1,
                                false,
                                startTime,
                              ),
                            ),
                          ],
                        ),*/
                        Column(
                          children: [Text('data')],
                        )
                      ],
                    ),
                    ButtonTheme(
                      height: 50.0,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              return Theme.of(context).accentColor;
                            },
                          ),
                          elevation: MaterialStateProperty.resolveWith<double>(
                              (Set<MaterialState> states) {
                            return 3;
                          }),
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
                          dependentesController.sendDependentes().then(
                            (value) {
                              if (value == 1) {
                                dependentesController.getDependentes();
                                confirmedButtonPressed(
                                  context,
                                  'Dependente foi incluido com sucesso!\n Mandamos um e-mail para a definição de senha',
                                );
                              } else if (value == 'invalid') {
                                onAlertButtonPressed(
                                    context, 'E-mail inválido!');
                              } else if (value == 'vazio') {
                                onAlertButtonPressed(context,
                                    'Todos os campos são obrigatórios');
                              } else if (value == 0) {
                                onAlertButtonPressed(
                                  context,
                                  'Houve algum problema!',
                                );
                              } else if (value == 4) {
                                onAlertButtonPressed(
                                  context,
                                  'Máximo de dependentes excedido.\nPor gentileza procure a administração do condomínio.!',
                                );
                              } else {
                                onAlertButtonPressed(
                                  context,
                                  'Este E-mail já foi cadastrado em sua Unidade',
                                );
                              }
                            },
                          );
                        },
                        child: Text(
                          'Incluir',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            );
    });
  }

  onAlertButtonPressed(context, String text) {
    Alert(
      image: Icon(
        Icons.highlight_off,
        color: Colors.yellowAccent,
        size: 60,
      ),
      style: AlertStyle(
        backgroundColor: Theme.of(context).textSelectionTheme.selectionColor,
        animationType: AnimationType.fromTop,
        isCloseButton: false,
        isOverlayTapDismiss: false,
        //descStyle: GoogleFonts.poppins(color: Colors.red,),
        animationDuration: Duration(milliseconds: 300),
        titleStyle: GoogleFonts.poppins(
          color: Theme.of(context).errorColor,
          fontSize: 16,
        ),
      ),
      context: context,
      title: text,
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          width: 80,
          color: Theme.of(context).errorColor,
        )
      ],
    ).show();
  }

  confirmedButtonPressed(
    context,
    String text,
  ) {
    Alert(
      image: Icon(
        Icons.check,
        color: Colors.green,
        size: 60,
      ),
      style: AlertStyle(
        backgroundColor: Theme.of(context).textSelectionTheme.selectionColor,
        animationType: AnimationType.fromTop,
        isCloseButton: false,
        isOverlayTapDismiss: false,
        animationDuration: Duration(milliseconds: 300),
        titleStyle: GoogleFonts.poppins(
          color: Theme.of(context).errorColor,
          fontSize: 16,
        ),
      ),
      context: context,
      title: text,
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          onPressed: () {
            DependentesController dependentesController =
                Get.put(DependentesController());
            dependentesController.itemSelecionado.value = 'Selecione o tipo';
            dependentesController.nome.value.text = '';
            dependentesController.sobrenome.value.text = '';
            dependentesController.email.value.text = '';
            dependentesController.itemSelecionado.value = 'Selecione o gênero';
            dependentesController.celular.value.text = '';

            Navigator.of(context).pop();
          },
          width: 80,
          color: Colors.green,
        )
      ],
    ).show();
  }
}
