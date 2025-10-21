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
        backgroundColor: Color.fromARGB(255, 116, 16, 247),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 116, 16, 247),
          title: Text(
            'Unidades',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: Theme.of(context).textSelectionTheme.selectionColor!,
            ),
          ),
          centerTitle: true,
        ),
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
                            loginController.idcond.value = condo.idcond;
                            loginController.tipousu.value = condo.tipousu;
                            loginController.nomeusu.value = condo.nomeusu;
                            loginController.sobrenomeusu.value =
                                condo.sobrenomeusu;

                            var sendTags = {
                              'idusu': loginController.newId.value,
                              'nome': loginController.nomeusu.value,
                              'sobrenome': loginController.idcond.value,
                            };
                            OneSignal.User.addTags(sendTags).then((_) {
                              print("Successfully sent tags: $sendTags");
                            }).catchError((error) {
                              print(
                                  "Auth Encountered an error sending tags: $error");
                            });
                            loginController.newLogin(condo.idusu);
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            color: Color.fromARGB(199, 14, 17, 196),
                            child: ListTile(
                              leading: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        'https://www.condosocio.com.br/acond/downloads/logocondo/${condo.imglogo}'),
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
