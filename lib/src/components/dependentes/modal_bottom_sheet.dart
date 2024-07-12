import 'package:condosocio/src/components/utils/alert_button_pressed.dart';
import 'package:condosocio/src/components/utils/delete_alert.dart';
import 'package:condosocio/src/components/utils/edge_alert_widget.dart';
import 'package:condosocio/src/components/utils/whatsapp_send.dart';
import 'package:condosocio/src/controllers/dependentes_controller.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:flutter/material.dart';

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
    String idep,
    String condominio_facial,
    String ctlnotificacao) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        DependentesController dependentesController =
            Get.put(DependentesController());

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
                                      Icons.person_outline,
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor!,
                                      size: 40,
                                    ),
                                  ),
                                ],
                              ),
                              width: 70,
                              height: 70,
                            )
                          : Material(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              borderRadius: BorderRadius.circular(5),
                              color: Theme.of(context).primaryColor,
                              elevation: 10,
                              child: Container(
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
                                width: 45,
                                height: 80,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        'https://www.condosocio.com.br/acond/downloads/fotosperfil/$img'),
                                  ),
                                ),
                              ),
                            ),
                      title: Text(
                        '$nome $sobrenome\n($tipousuario)',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor!,
                        ),
                      ),
                      subtitle: Text(
                        tipousuario == 'Morador' ? email : cel,
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor!,
                        ),
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
                                      Theme.of(context).primaryColorDark,
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
                                            showToast(
                                              context,
                                              'Parabéns! Face resetada com sucesso.',
                                              '',
                                            );
                                            Get.back();
                                            Get.back();
                                          } else {
                                            onAlertButtonPressed(
                                                context,
                                                'Algo deu errado\n Tente novamente',
                                                '/home',
                                                'images/error.png');
                                          }
                                        },
                                      );
                                    },
                                  );
                                },
                                child: Text(
                                  "Resetar Face ",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
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
                                          Theme.of(context).primaryColorDark,
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
                                                'Olá! o Sr(a) ${loginController.nome.value} enviou este link para a liberação de acesso na portaria do condomínio ${loginController.nomeCondo.value}, preencha os campos os campos abertos e insira uma foto de perfil sem utilizacão de óculos ou máscaras . Grato! https://www.condosocio.com.br/paginas/acesso_prestador.php?chave=${value['idusu']}';

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
                                                'images/error.png');
                                          }
                                        },
                                      );
                                    },
                                    child: Text(
                                      "Enviar Via Whatsapp",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
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
                                          Theme.of(context).primaryColorDark,
                                        )),
                                    onPressed: () {
                                      dependentesController
                                          .reenviarEmail(email)
                                          .then((value) {
                                        dependentesController.getDependentes();
                                        showToast(
                                          context,
                                          'Parabéns! ' + value,
                                          '',
                                        );
                                        Get.back();
                                      });
                                    },
                                    child: Text(
                                      "Reenviar E-mail",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
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
                                  Theme.of(context).primaryColorDark,
                                )),
                            onPressed: () {
                              dependentesController
                                  .ativarNotificacoes(idep, ctlnotificacao)
                                  .then((value) {
                                dependentesController.getDependentes();

                                if (ctlnotificacao == "0") {
                                  showToast(
                                    context,
                                    'As Notificações Foram Ativadas para o Usuário!',
                                    '',
                                  );
                                  Get.back();
                                } else {
                                  showToast(
                                    context,
                                    'As Notificações Foram Desativadas para o Usuário!',
                                    '',
                                  );
                                  Get.back();
                                }
                              });
                            },
                            child: ctlnotificacao == "0"
                                ? Text(
                                    "Ativar Notificações",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  )
                                : Text(
                                    "Desativar Notificações",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ))),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  condominio_facial != 'SIM'
                      ? status == 'Normal'
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
                                          Theme.of(context).primaryColorDark,
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
                                          color: Colors.white, fontSize: 16),
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
                                          Theme.of(context).primaryColorDark,
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
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  )),
                            )
                      : Container(),
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
                                Theme.of(context).colorScheme.error,
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
                                      showToast(
                                        context,
                                        'Parabéns! Usuário excluído com sucesso.',
                                        '',
                                      );
                                      Get.back();
                                      Get.back();
                                    } else {
                                      onAlertButtonPressed(
                                          context,
                                          'Algo deu errado\n Tente novamente',
                                          '/home',
                                          'images/error.png');
                                    }
                                  },
                                );
                              },
                            );
                          },
                          child: Text(
                            "Excluir",
                            style: TextStyle(color: Colors.white, fontSize: 16),
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
