import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ListOfCondo extends StatelessWidget {
  const ListOfCondo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginController loginController = Get.put(LoginController());
    return Scaffold(
        appBar: AppBar(),
        body: Obx(() {
          return loginController.isLoading.value
              ? CircularProgressIndicatorWidget()
              : Container(
                  child: SmartRefresher(
                    controller: loginController.refreshController,
                    onRefresh: loginController.onRefresh,
                    onLoading: loginController.onLoading,
                    child: ListView.builder(
                      itemCount: loginController.listOfCondo.length,
                      itemBuilder: (_, i) {
                        var condo = loginController.listOfCondo[i];
                        return GestureDetector(
                          onTap: () {
                            loginController.tipoun.value = condo.tipoun;
                            loginController.logradouro.value = condo.logradouro;
                            loginController.newId.value = condo.idusu;
                            loginController.newLogin(condo.idusu);
                            loginController.idcond.value = condo.idcond;
                            loginController.tipousu.value = condo.tipousu;
                            loginController.nomeusu.value = condo.nomeusu;
                            loginController.sobrenomeusu.value =
                                condo.sobrenomeusu;

                            var sendTags = {
                              'idusu': loginController.newId.value,
                              'nome': loginController.nomeusu.value,
                              'sobrenome': loginController.sobrenomeusu.value,
                              'idcond': loginController.idcond.value,
                              'tipousuario': loginController.tipo.value,
                              'genero': loginController.genero.value,
                              'tipoun': loginController.tipoun.value,
                              'logradouro': loginController.logradouro.value,
                            };

                            OneSignal.shared
                                .sendTags(sendTags)
                                .then((response) {
                              print(
                                  "Successfully sent tags with response: $response");
                            }).catchError((error) {
                              print(
                                  "Encountered an error sending tags: $error");
                            });
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            color: Theme.of(context).colorScheme.secondary,
                            child: ListTile(
                              leading: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        'https://www.alvocomtec.com.br/acond/downloads/logocondo/${condo.imglogo}'),
                                  ),
                                ),
                              ),
                              title: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.0),
                                child: Text(
                                  condo.nomeCond,
                                  style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor!,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              subtitle: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.0),
                                child: Text(
                                    '${condo.logradouro} | ${condo.tipoun}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor!,
                                    )),
                              ),
                              trailing: Icon(
                                Icons.arrow_right,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor!,
                                size: 30,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
        }));
  }
}
