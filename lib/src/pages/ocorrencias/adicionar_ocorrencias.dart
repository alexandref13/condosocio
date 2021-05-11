import 'package:condosocio/src/components/utils/custom_text_field.dart';
import 'package:condosocio/src/controllers/ocorrencias_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AdicionarOcorrencias extends StatefulWidget {
  const AdicionarOcorrencias({Key key}) : super(key: key);

  @override
  _AdicionarOcorrenciasState createState() => _AdicionarOcorrenciasState();
}

class _AdicionarOcorrenciasState extends State<AdicionarOcorrencias> {
  @override
  Widget build(BuildContext context) {
    OcorrenciasController ocorrenciasController =
        Get.put(OcorrenciasController());

    void _dropDownItemSelected(String novoItem) {
      ocorrenciasController.itemSelecionado.value = novoItem;
    }

    DateTime data = DateTime.now();
    TimeOfDay hora = TimeOfDay.now();

    return SingleChildScrollView(
      child: Obx(() {
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 5,
              ),
              Container(
                height: 40,
                padding: EdgeInsets.all(7),
                margin: EdgeInsets.all(7),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Theme.of(context).textSelectionTheme.selectionColor,
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
                  style: GoogleFonts.montserrat(fontSize: 16),
                  items: ocorrenciasController.tipos
                      .map((String dropDownStringItem) {
                    return DropdownMenuItem<String>(
                      value: dropDownStringItem,
                      child: Text(dropDownStringItem),
                    );
                  }).toList(),
                  onChanged: (String novoItemSelecionado) {
                    _dropDownItemSelected(novoItemSelecionado);
                    ocorrenciasController.itemSelecionado.value =
                        novoItemSelecionado;
                  },
                  value: ocorrenciasController.itemSelecionado.value,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                margin: EdgeInsets.all(7),
                child: customTextField(
                  context,
                  'Titulo',
                  null,
                  false,
                  1,
                  true,
                  ocorrenciasController.title.value,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: data,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2024),
                  ).then((value) => {
                        setState(() {
                          data = value;
                          ocorrenciasController.date.value.text =
                              (DateFormat("dd/MM/yyyy").format(value));
                        })
                      });
                },
                child: Container(
                  margin: EdgeInsets.all(7),
                  child: customTextField(
                    context,
                    null,
                    (DateFormat("dd/MM/yyyy").format(data)),
                    false,
                    1,
                    false,
                    ocorrenciasController.date.value,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  showTimePicker(
                      context: context,
                      initialTime: hora,
                      builder: (BuildContext context, Widget child) {
                        return MediaQuery(
                            data: MediaQuery.of(context)
                                .copyWith(alwaysUse24HourFormat: true),
                            child: child);
                      }).then((value) => {
                        setState(() {
                          hora = value;
                          ocorrenciasController.hour.value.text =
                              value.format(context);
                        })
                      });
                },
                child: Container(
                  margin: EdgeInsets.all(7),
                  child: customTextField(
                    context,
                    null,
                    hora.format(context),
                    false,
                    1,
                    false,
                    ocorrenciasController.hour.value,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                margin: EdgeInsets.all(7),
                child: customTextField(
                  context,
                  'Descrição',
                  null,
                  true,
                  3,
                  true,
                  ocorrenciasController.description.value,
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: ButtonTheme(
                    height: 50.0,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            return Theme.of(context)
                                .textSelectionTheme
                                .selectionColor;
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
                      onPressed: () {},
                      child: Text(
                        "ANEXAR IMAGEM",
                        style: GoogleFonts.montserrat(
                            color: Theme.of(context).buttonColor, fontSize: 16),
                      ),
                    ),
                  )),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: ButtonTheme(
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
                    onPressed: () {},
                    child: ocorrenciasController.isLoading.value
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
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
