import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/components/utils/edge_alert_widget.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../components/utils/alert_button_pressed.dart';
import '../../controllers/dependentes_controller.dart';
import '../../controllers/veiculos/veiculos_controller.dart';

class AdicionaVeiculos extends StatefulWidget {
  @override
  _AdicionaVeiculosState createState() => _AdicionaVeiculosState();
}

class _AdicionaVeiculosState extends State<AdicionaVeiculos> {
  VeiculosController veiculosController = Get.put(VeiculosController());
  DependentesController dependentesController =
      Get.put(DependentesController());
  final LoginController loginController = Get.put(LoginController());
  DateTime data = DateTime.now();

  void dropDownMarcaSelected(String novoItem) {
    veiculosController.firstId.value = novoItem;
  }

  @override
  void initState() {
    veiculosController.isMarca.value = false;

    super.initState();
  }

  @override
  void dispose() {
    // Coloque aqui o código que precisa ser executado ao sair do widget
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return veiculosController.isLoading.value
          ? CircularProgressIndicatorWidget()
          : veiculosController.cont.value < veiculosController.qtdVag.value
              ? SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    padding: EdgeInsets.only(bottom: 10, top: 20),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      //crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
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
                                child: ButtonTheme(
                                  height: 50.0,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                          return Theme.of(context).primaryColor;
                                        },
                                      ),
                                      elevation: MaterialStateProperty
                                          .resolveWith<double>(
                                        (Set<MaterialState> states) {
                                          return 0;
                                        },
                                      ),
                                      shape: MaterialStateProperty.resolveWith<
                                          OutlinedBorder>(
                                        (Set<MaterialState> states) {
                                          return RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          );
                                        },
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: DropdownButton<String>(
                                      autofocus: false,
                                      isExpanded: true,
                                      underline: Container(),
                                      icon: Icon(
                                        Icons.keyboard_arrow_down,
                                        size: 27,
                                      ),
                                      dropdownColor:
                                          Theme.of(context).primaryColor,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor),
                                      items:
                                          veiculosController.marcas.map((item) {
                                        return DropdownMenuItem(
                                          value: item['idmarca'].toString(),
                                          child: Text(item['nome']),
                                        );
                                      }).toList(),
                                      onChanged: (String novoItemSelecionado) {
                                        veiculosController.idmarca.value =
                                            novoItemSelecionado;

                                        veiculosController.getMarcas();
                                        veiculosController.getModelos();
                                      },
                                      value: veiculosController.idmarca.value,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              veiculosController.isMarca.value
                                  ? Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 7),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor,
                                          width: 1,
                                        ),
                                      ),
                                      child: ButtonTheme(
                                        height: 50.0,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty
                                                    .resolveWith<Color>(
                                              (Set<MaterialState> states) {
                                                return Theme.of(context)
                                                    .primaryColor;
                                              },
                                            ),
                                            elevation: MaterialStateProperty
                                                .resolveWith<double>(
                                              (Set<MaterialState> states) {
                                                return 0;
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
                                          onPressed: () {},
                                          child: DropdownButton<String>(
                                            autofocus: false,
                                            isExpanded: true,
                                            underline: Container(),
                                            icon: Icon(
                                              Icons.keyboard_arrow_down,
                                              size: 27,
                                            ),
                                            dropdownColor:
                                                Theme.of(context).primaryColor,
                                            style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                color: Theme.of(context)
                                                    .textSelectionTheme
                                                    .selectionColor),
                                            items: veiculosController.modelos
                                                .map((item) {
                                              return DropdownMenuItem(
                                                value:
                                                    item['idmodelo'].toString(),
                                                child: Text(item['nome']),
                                              );
                                            }).toList(),
                                            onChanged:
                                                (String novoItemSelecionado) {
                                              veiculosController.idmodelo
                                                  .value = novoItemSelecionado;
                                              veiculosController.getModelos();
                                            },
                                            value: veiculosController
                                                .idmodelo.value,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(),
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
                                child: ButtonTheme(
                                  height: 50.0,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                          return Theme.of(context).primaryColor;
                                        },
                                      ),
                                      elevation: MaterialStateProperty
                                          .resolveWith<double>(
                                        (Set<MaterialState> states) {
                                          return 0;
                                        },
                                      ),
                                      shape: MaterialStateProperty.resolveWith<
                                          OutlinedBorder>(
                                        (Set<MaterialState> states) {
                                          return RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          );
                                        },
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: DropdownButton<String>(
                                      autofocus: false,
                                      isExpanded: true,
                                      underline: Container(),
                                      icon: Icon(
                                        Icons.keyboard_arrow_down,
                                        size: 27,
                                      ),
                                      dropdownColor:
                                          Theme.of(context).primaryColor,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor),
                                      items: veiculosController.cores
                                          .map((String dropDownStringItem) {
                                        return DropdownMenuItem<String>(
                                          value: dropDownStringItem,
                                          child: Text(
                                              dropDownStringItem.toUpperCase()),
                                        );
                                      }).toList(),
                                      onChanged: (String novoItemSelecionado) {
                                        veiculosController.corSelecionada
                                            .value = novoItemSelecionado;
                                      },
                                      value: veiculosController
                                          .corSelecionada.value,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextField(
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  veiculosController.birthDateMaskFormatter
                                ],
                                controller: veiculosController.ano.value,
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
                                  labelText: 'ANO',
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
                                height: 15,
                              ),
                              TextField(
                                textCapitalization:
                                    TextCapitalization.characters,
                                keyboardType: TextInputType.text,
                                inputFormatters: [veiculosController.placaMask],
                                controller: veiculosController.placa.value,
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
                                  labelText: 'PLACA',
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
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding:
                              EdgeInsets.only(bottom: 20, left: 10, right: 10),
                          child: ButtonTheme(
                            height: 50.0,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    return Theme.of(context)
                                        .colorScheme
                                        .secondary;
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
                                veiculosController.sendVeiculos().then((value) {
                                  if (value == 1) {
                                    edgeAlertWidget(context, 'Parabéns!',
                                        'Veículo cadastrado com sucesso.');
                                  } else if (value == 4) {
                                    onAlertButtonPressed(
                                        context,
                                        'Número vagas de garagem excedida!\nFale com a administração do seu condomínio',
                                        null);
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
                )
              : Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 100, 10, 20),
                      child: Text(
                        'Número de vagas excedidas!',
                        style: GoogleFonts.montserrat(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      child: Text(
                        ' Exclua algum veículo ou procure a administração do seu condomínio.',
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Flexible(
                      child: Container(
                        padding: EdgeInsets.only(bottom: 120),
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width * .70,
                        child: Image.asset(
                          'images/vagas.png',
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ],
                );
    });
  }
}
