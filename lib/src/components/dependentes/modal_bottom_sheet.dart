import 'package:condosocio/src/components/utils/alert_button_pressed.dart';
import 'package:condosocio/src/components/utils/delete_alert.dart';
import 'package:condosocio/src/components/utils/edge_alert_widget.dart';
import 'package:condosocio/src/components/utils/whatsapp_send.dart';
import 'package:condosocio/src/controllers/convites/visualizar_convites_controller.dart';
import 'package:condosocio/src/controllers/dependentes_controller.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

void dependentesModalBottomSheet(
    context,
    String nome,
    String sobrenome,
    String status,
    String email,
    String img,
    String cel,
    String facial,
    String tipousuario,
    String idep) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        DependentesController dependentesController =
            Get.put(DependentesController());
        VisualizarConvitesController visualizarConvitesController =
            Get.put(VisualizarConvitesController());
        LoginController loginController = Get.put(LoginController());
        return Container(
          color: Theme.of(context).colorScheme.secondary,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: img == ''
                          ? Container(
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 10, top: 10),
                                    child: Icon(
                                      Feather.user,
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor,
                                      size: 40,
                                    ),
                                  ),
                                ],
                              ),
                              width: 70,
                              height: 70,
                            )
                          : Container(
                              child: Column(
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(left: 10),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      )),
                                ],
                              ),
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(
                                      'https://alvocomtec.com.br/acond/downloads/fotosperfil/$img'),
                                ),
                              ),
                            ),
                      title: Text(
                        '$nome $sobrenome\n($tipousuario)',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                      subtitle: Text(
                        tipousuario == 'Morador' ? email : cel,
                        style: TextStyle(fontSize: 14),
                      )),
                  Divider(
                    height: 20,
                    color: Colors.blueGrey,
                  ),
                  facial == '1'
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                                    elevation: MaterialStateProperty.all(0),
                                    backgroundColor: MaterialStateProperty.all(
                                      Theme.of(context).splashColor,
                                    )),
                                onPressed: () {
                                  deleteAlert(
                                    context,
                                    'Deseja resetar a face do usuário?',
                                    () {
                                      dependentesController.delFace().then(
                                        (value) {
                                          if (value == 1) {
                                            dependentesController
                                                .getDependentes();
                                            edgeAlertWidget(
                                              context,
                                              'Parabéns!',
                                              'Face resetada com sucesso.',
                                            );
                                            Get.back();
                                            Get.back();
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
                                  "Resetar Face ",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              )),
                        )
                      : tipousuario == "Prestador de Serviço"
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 50,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        )),
                                        elevation: MaterialStateProperty.all(0),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                          Theme.of(context).splashColor,
                                        )),
                                    onPressed: () {
                                      var celular = cel
                                          .replaceAll("+", "")
                                          .replaceAll("(", "")
                                          .replaceAll(")", "")
                                          .replaceAll("-", "")
                                          .replaceAll(" ", "");
                                      print(celular);
                                      dependentesController
                                          .sendWhatsApp(cel)
                                          .then(
                                        (value) {
                                          if (value != 0) {
                                            String message =
                                                'Olá! o Sr(a) ${loginController.nome.value} enviou este link para a liberação de acesso na portaria do condomínio ${loginController.nomeCondo.value}, preencha os campos os campos abertos e insira uma foto de perfil sem utilizacão de óculos ou máscaras . Grato! https://alvocomtec.com.br/paginas/acesso_prestador?chave=${value['idusu']}';

                                            whatsAppSend(
                                              context,
                                              "55$celular",
                                              Uri.encodeFull(
                                                message,
                                              ),
                                            );
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
                                    child: Text(
                                      "Enviar link via Whatsapp",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                  )),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 50,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        )),
                                        elevation: MaterialStateProperty.all(0),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                          Theme.of(context).splashColor,
                                        )),
                                    onPressed: () {
                                      dependentesController
                                          .reenviarEmail(email)
                                          .then((value) {
                                        dependentesController.getDependentes();
                                        edgeAlertWidget(
                                          context,
                                          'Parabéns!',
                                          value,
                                        );
                                        Get.back();
                                        Get.back();
                                      });
                                    },
                                    child: Text(
                                      "Reenviar e-mail",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                  )),
                            ),
                  SizedBox(
                    height: 15,
                  ),
                  status == 'Normal'
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                                    elevation: MaterialStateProperty.all(0),
                                    backgroundColor: MaterialStateProperty.all(
                                      Theme.of(context).splashColor,
                                    )),
                                onPressed: () {
                                  dependentesController
                                      .changeStatus('2')
                                      .then((value) {
                                    dependentesController.getDependentes();
                                    Get.back();
                                  });
                                },
                                child: Text(
                                  "Suspender",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              )),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                                    elevation: MaterialStateProperty.all(0),
                                    backgroundColor: MaterialStateProperty.all(
                                      Theme.of(context).splashColor,
                                    )),
                                onPressed: () {
                                  dependentesController
                                      .changeStatus('1')
                                      .then((value) {
                                    dependentesController.getDependentes();
                                    Get.back();
                                  });
                                },
                                child: Text(
                                  "Normalizar",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              )),
                        ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                              elevation: MaterialStateProperty.all(0),
                              backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).errorColor,
                              )),
                          onPressed: () {
                            deleteAlert(
                              context,
                              'Deseja excluir usuário?',
                              () {
                                dependentesController.deleteDependente().then(
                                  (value) {
                                    if (value == 1) {
                                      dependentesController.getDependentes();
                                      edgeAlertWidget(
                                        context,
                                        'Parabéns!',
                                        'Usuário excluído com sucesso.',
                                      );
                                      Get.back();
                                      Get.back();
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
                            "Excluir",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 15,
                  )
                ],
              ),
            ),
          ),
        );
      });
}
