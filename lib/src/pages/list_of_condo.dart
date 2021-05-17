import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ListOfCondo extends StatelessWidget {
  const ListOfCondo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginController loginController = Get.put(LoginController());
    return Scaffold(
        appBar: AppBar(),
        body: Obx(() {
          return loginController.isLoading.value
              ? CircularProgressIndicatorWidget()
              : Container(
                  child: ListView.builder(
                    itemCount: loginController.listOfCondo.length,
                    itemBuilder: (_, i) {
                      var condo = loginController.listOfCondo[i];
                      return GestureDetector(
                        onTap: () {
                          loginController.unidade.value = condo.tipoun;
                          loginController.newLogin(context, condo.idusu);
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          color: Theme.of(context).accentColor,
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
                                        .selectionColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            subtitle: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.0),
                              child: Text(
                                  '${condo.logradouro} | ${condo.tipoun}',
                                  style: TextStyle(fontSize: 12)),
                            ),
                            trailing: Icon(
                              Icons.arrow_right,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                              size: 30,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
        }));
  }
}
