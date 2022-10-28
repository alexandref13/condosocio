import 'package:condosocio/src/components/utils/alertInvite.dart';
import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/components/utils/edge_alert_widget.dart';
import 'package:condosocio/src/controllers/dependentes_controller.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:condosocio/src/controllers/perfil_controller.dart';
import 'package:email_validator/email_validator.dart';
import 'package:get/get.dart';
import 'package:condosocio/src/components/utils/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../components/utils/alert_button_pressed.dart';
import '../../components/utils/whatsapp_send.dart';

class AdicionaDependentes extends StatefulWidget {
  @override
  _AdicionaDependentesState createState() => _AdicionaDependentesState();
}

class _AdicionaDependentesState extends State<AdicionaDependentes> {
  DependentesController dependentesController =
      Get.put(DependentesController());
  final LoginController loginController = Get.put(LoginController());
  PerfilController perfilController = Get.put(PerfilController());
  bool _isVisible = true;

  var startSelectedDate = DateTime.now();
  var startSelectedTime = TimeOfDay.now();
  var endSelectedDate = DateTime.now();
  var endSelectedTime = TimeOfDay.now();
  var startDate = TextEditingController();
  var startTime = TextEditingController();
  var endDate = TextEditingController();
  var endTime = TextEditingController();

  Future<TimeOfDay> selectTime(BuildContext context) {
    //final now = DateTime.now();
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 08, minute: 00),
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
      initialTime: TimeOfDay(hour: 18, minute: 00),
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
    dependentesController.endDate.value != ''
        ? endSelectedDate = DateTime(
            formatDate.year,
            formatDate.month,
            formatDate.day,
            formatDate.hour,
            formatDate.minute,
          )
        : endSelectedDate = DateTime(
            endSelectedDate.year,
            endSelectedDate.month,
            endSelectedDate.day,
            endSelectedTime.hour,
            endSelectedTime.minute,
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
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.only(bottom: 10, top: 50),
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
                              iconEnabledColor: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                              dropdownColor: Theme.of(context).primaryColor,
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                              ),
                              items: loginController.condofacial.value == 'SIM'
                                  ? dependentesController.tiposUsuarios
                                      .map((String dropDownStringItem) {
                                      return DropdownMenuItem<String>(
                                        value: dropDownStringItem,
                                        child: Text(dropDownStringItem),
                                      );
                                    }).toList()
                                  : dependentesController.tiposUsuarios2
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
                              iconEnabledColor: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
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
                              value:
                                  dependentesController.itemSelecionado.value,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              perfilController.cellMaskFormatter
                            ],
                            controller: dependentesController.celular.value,
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
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
                              labelText: 'Celular / Whatsapp',
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
                        ],
                      ),
                    ),
                    if (dependentesController.tipoUsuario.value == "Morador")
                      Visibility(
                        visible: _isVisible,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 7, horizontal: 7),
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            //enabled: !dependentesController.isLoading.value,
                            style: GoogleFonts.montserrat(
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
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
                                  borderSide:
                                      new BorderSide(color: Colors.red[900])),
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
                        ),
                      ),
                    if (dependentesController.tipoUsuario.value != "Morador")
                      Visibility(
                        visible: _isVisible,
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                    initialValue:
                                        dependentesController.isChecked.value,
                                    builder: (isChecked, updateFn) => Switch(
                                          value: isChecked,
                                          onChanged: (newValue) =>
                                              updateFn(newValue),
                                          activeColor:
                                              Theme.of(context).shadowColor,
                                        ),
                                    onUpdate: (svalue) => dependentesController
                                        .isChecked.value = svalue),
                              ],
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                    if (dependentesController.tipoUsuario.value != "Morador" &&
                        dependentesController.isChecked.value == false)
                      Visibility(
                        visible: _isVisible,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 15),
                              child: Text(
                                'Entrada',
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  bottom: 20, left: 10, right: 10),
                              child: GestureDetector(
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
                                  null,
                                  DateFormat("HH:mm").format(
                                    startSelectedDate,
                                  ),
                                  false,
                                  1,
                                  false,
                                  startDate,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (dependentesController.tipoUsuario.value != "Morador" &&
                        dependentesController.isChecked.value == false)
                      Visibility(
                        visible: _isVisible,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 15),
                              child: Text(
                                'Saída',
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  bottom: 20, left: 10, right: 10),
                              child: GestureDetector(
                                onTap: () async {
                                  endSelectedTime =
                                      await selectEndTime(context);
                                  if (endSelectedTime == null) return;

                                  setState(() {
                                    endSelectedDate = DateTime(
                                      endSelectedDate.year,
                                      endSelectedDate.month,
                                      endSelectedDate.day,
                                      endSelectedTime.hour,
                                      endSelectedTime.minute,
                                    );
                                  });
                                },
                                child: customTextField(
                                  context,
                                  null,
                                  (DateFormat("HH:mm").format(
                                    endSelectedDate,
                                  )),
                                  false,
                                  1,
                                  false,
                                  endTime,
                                ),
                              ),
                            ),
                          ],
                        ),
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
                          onPressed: () {
                            dependentesController.startDate.value =
                                "${startSelectedDate.hour.toString()}:00";
                            dependentesController.endDate.value =
                                "${endSelectedDate.hour.toString()}:00";

                            dependentesController
                                .sendDependentes()
                                .then((value) {
                              if (value == 1) {
                                confirmedInviteAlert(
                                    context,
                                    dependentesController.tipoUsuario.value ==
                                            "Morador"
                                        ? 'O morador foi incluído com sucesso! Enviamos agora um e-mail para que ele possa definir a sua senha e ter acesso ao CondoSócio'
                                        : 'O prestador de serviço foi incluído com sucesso! Envie agora via whatsapp o link para o cadastro e efetivação do acesso junto a portaria do seu condomínio.',
                                    dependentesController.tipoUsuario.value ==
                                            "Morador"
                                        ? 'images/banneremail.png'
                                        : 'images/bannerwhatprestador.png',
                                    dependentesController.tipoUsuario.value ==
                                            "Morador"
                                        ? 'Fechar'
                                        : 'Enviar',
                                    dependentesController.tipoUsuario.value ==
                                            "Morador"
                                        ? () {
                                            Get.back();
                                            Get.back();
                                          }
                                        : () {
                                            dependentesController
                                                .sendWhatsApp(
                                                    dependentesController
                                                        .celular.value.text)
                                                .then(
                                              (value) {
                                                if (value != 0) {
                                                  String message =
                                                      'Olá! o Sr(a) ${loginController.nome.value} enviou este link para a liberação de acesso na portaria do condomínio ${loginController.nomeCondo.value}, preencha os campos os campos abertos e insira uma foto de perfil sem utilizacão de óculos ou máscaras . Grato! https://condosocio.com.br/paginas/acesso_prestador?chave=${value['idusu']}';

                                                  var celular =
                                                      dependentesController
                                                          .celular.value.text
                                                          .replaceAll("(", "")
                                                          .replaceAll(")", "")
                                                          .replaceAll("-", "")
                                                          .replaceAll(" ", "");

                                                  whatsAppSend(
                                                    context,
                                                    "55$celular",
                                                    Uri.encodeFull(
                                                      message,
                                                    ),
                                                  );
                                                  Get.back();
                                                  Get.back();
                                                } else {
                                                  onAlertButtonPressed(
                                                      context,
                                                      'Algo deu errado\n Tente novamente',
                                                      '/home');
                                                }
                                              },
                                            );
                                          });
                                /*edgeAlertWidget(context, 'Parabéns!',
                                    'Usuário cadastrado com sucesso.');*/
                                // } else if (value == 4) {
                                // onAlertButtonPressed(
                                // context,
                                //'Número máximo de usuários excedido!\nFale com a adminstração do condomínio',
                                // null);
                              } else if (value == 3) {
                                onAlertButtonPressed(
                                    context, 'Usuário já cadastrado!', null);
                              } else if (value == "vazio") {
                                onAlertButtonPressed(
                                    context, 'Algum campo vazio!', null);
                              } else if (value == 'invalido') {
                                onAlertButtonPressed(
                                    context, 'E-mail inválido!', null);
                              } else {
                                onAlertButtonPressed(
                                    context,
                                    'Houve algum problema!Tente novamente',
                                    null);
                              }
                            });
                          },
                          child: Text(
                            'Enviar',
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
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

  /*confirmedButtonPressed(
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
  }*/
}
