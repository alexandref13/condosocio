import 'package:condosocio/src/components/utils/alert_button_pressed.dart';
import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:condosocio/src/controllers/ouvidoria/responda_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DetalhesOuvidoria extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RespondaController respondaController = Get.put(RespondaController());
    LoginController loginController = Get.put(LoginController());

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(
          'Ouvidoria',
          style: GoogleFonts.montserrat(
            fontSize: 16,
            color: Theme.of(context).textSelectionTheme.selectionColor!,
          ),
        ),
      ),
      body: Obx(
        () {
          return respondaController.isLoading.value
              ? CircularProgressIndicatorWidget()
              : Container(
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: respondaController.resposta.length,
                          itemBuilder: (_, i) {
                            var resposta = respondaController.resposta[i];

                            return Column(
                              children: [
                                resposta.idusuraiz != ''
                                    ? Container(
                                        alignment: Alignment(1, 0),
                                        padding:
                                            EdgeInsets.only(bottom: 10, top: 5),
                                        child: Column(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .92,
                                              child: Row(
                                                children: [
                                                  loginController.imgperfil
                                                              .value ==
                                                          ''
                                                      ? Container(
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            40,
                                                                        bottom:
                                                                            5),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .secondary,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          width: 60,
                                                          height: 60,
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            image:
                                                                DecorationImage(
                                                              image: AssetImage(
                                                                  'images/user.png'),
                                                            ),
                                                          ),
                                                        )
                                                      : Container(
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                margin:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left: 40,
                                                                  bottom: 5,
                                                                ),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .secondary,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          width: 50,
                                                          height: 50,
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            image:
                                                                DecorationImage(
                                                              image: NetworkImage(
                                                                  'https://alvocomtec.com.br/acond/downloads/fotosperfil/${loginController.imgperfil.value}'),
                                                            ),
                                                          ),
                                                        ),
                                                  Expanded(
                                                    child: Container(
                                                      padding: EdgeInsets.only(
                                                          left: 5),
                                                      child: Card(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15.0),
                                                        ),
                                                        color:
                                                            Colors.green[600],
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          7,
                                                                          5,
                                                                          7,
                                                                          0),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Container(
                                                                        width: MediaQuery.of(context).size.width *
                                                                            .5,
                                                                        child:
                                                                            Text(
                                                                          loginController
                                                                              .nome
                                                                              .value,
                                                                          style:
                                                                              GoogleFonts.montserrat(
                                                                            fontSize:
                                                                                12,
                                                                            color:
                                                                                Theme.of(context).textSelectionTheme.selectionColor!,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        '${resposta.dataraiz} ${resposta.horaraiz}',
                                                                        style: GoogleFonts
                                                                            .montserrat(
                                                                          fontSize:
                                                                              10,
                                                                          color: Theme.of(context)
                                                                              .textSelectionTheme
                                                                              .selectionColor!,
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  Container(
                                                                    child: Text(
                                                                      loginController
                                                                          .tipo
                                                                          .value,
                                                                      style: GoogleFonts
                                                                          .montserrat(
                                                                        fontSize:
                                                                            10,
                                                                        color: Theme.of(context)
                                                                            .textSelectionTheme
                                                                            .selectionColor!,
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(10),
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  .9,
                                                              child: Text(
                                                                resposta
                                                                    .msgraiz,
                                                                style: GoogleFonts
                                                                    .montserrat(
                                                                  fontSize: 12,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .textSelectionTheme
                                                                      .selectionColor!,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : resposta.idusu == loginController.id.value
                                        ? Container(
                                            alignment: Alignment(1, 0),
                                            padding: EdgeInsets.only(
                                                bottom: 10, top: 5),
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .92,
                                                  child: Row(
                                                    children: [
                                                      loginController.imgperfil
                                                                  .value ==
                                                              ''
                                                          ? Container(
                                                              child: Column(
                                                                children: [
                                                                  Container(
                                                                    margin: EdgeInsets.only(
                                                                        left:
                                                                            40,
                                                                        bottom:
                                                                            5),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      color: Theme.of(
                                                                              context)
                                                                          .colorScheme
                                                                          .secondary,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              width: 60,
                                                              height: 60,
                                                              decoration:
                                                                  BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                image:
                                                                    DecorationImage(
                                                                  image: AssetImage(
                                                                      'images/user.png'),
                                                                ),
                                                              ),
                                                            )
                                                          : Container(
                                                              child: Column(
                                                                children: [
                                                                  Container(
                                                                    margin:
                                                                        EdgeInsets
                                                                            .only(
                                                                      left: 40,
                                                                      bottom: 5,
                                                                    ),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      color: Theme.of(
                                                                              context)
                                                                          .colorScheme
                                                                          .secondary,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              width: 50,
                                                              height: 50,
                                                              decoration:
                                                                  BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                image:
                                                                    DecorationImage(
                                                                  image: NetworkImage(
                                                                      'https://alvocomtec.com.br/acond/downloads/fotosperfil/${loginController.imgperfil.value}'),
                                                                ),
                                                              ),
                                                            ),
                                                      Expanded(
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 5),
                                                          child: Card(
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15.0),
                                                            ),
                                                            color: Colors
                                                                .green[600],
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                  padding: EdgeInsets
                                                                      .fromLTRB(
                                                                          7,
                                                                          5,
                                                                          7,
                                                                          0),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Container(
                                                                            width:
                                                                                MediaQuery.of(context).size.width * .5,
                                                                            child:
                                                                                Text(
                                                                              resposta.nomeusu,
                                                                              style: GoogleFonts.montserrat(
                                                                                fontSize: 12,
                                                                                color: Theme.of(context).textSelectionTheme.selectionColor!,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            '${resposta.data} ${resposta.hora}',
                                                                            style:
                                                                                GoogleFonts.montserrat(
                                                                              fontSize: 10,
                                                                              color: Theme.of(context).textSelectionTheme.selectionColor!,
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                      Container(
                                                                        child:
                                                                            Text(
                                                                          resposta
                                                                              .tipousu,
                                                                          style:
                                                                              GoogleFonts.montserrat(
                                                                            fontSize:
                                                                                10,
                                                                            color:
                                                                                Theme.of(context).textSelectionTheme.selectionColor!,
                                                                          ),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              10),
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      .9,
                                                                  child: Text(
                                                                    resposta
                                                                        .texto,
                                                                    style: GoogleFonts
                                                                        .montserrat(
                                                                      fontSize:
                                                                          12,
                                                                      color: Theme.of(
                                                                              context)
                                                                          .textSelectionTheme
                                                                          .selectionColor!,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : Container(
                                            alignment: Alignment(-1, 0),
                                            padding:
                                                EdgeInsets.only(bottom: 10),
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .92,
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 5),
                                                          child: Card(
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15.0),
                                                            ),
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .secondary,
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              15),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(
                                                                            '${resposta.data} ${resposta.hora}h',
                                                                            style:
                                                                                GoogleFonts.montserrat(
                                                                              fontSize: 10,
                                                                              color: Theme.of(context).textSelectionTheme.selectionColor!,
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            child:
                                                                                Text(
                                                                              resposta.nomeusu,
                                                                              style: GoogleFonts.montserrat(
                                                                                fontSize: 12,
                                                                                color: Theme.of(context).textSelectionTheme.selectionColor!,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Container(
                                                                        child:
                                                                            Text(
                                                                          resposta
                                                                              .tipousu,
                                                                          style:
                                                                              GoogleFonts.montserrat(
                                                                            fontSize:
                                                                                10,
                                                                            color:
                                                                                Theme.of(context).textSelectionTheme.selectionColor!,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              10),
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      .9,
                                                                  child: Text(
                                                                    resposta
                                                                        .texto,
                                                                    style: GoogleFonts
                                                                        .montserrat(
                                                                      fontSize:
                                                                          12,
                                                                      color: Theme.of(
                                                                              context)
                                                                          .textSelectionTheme
                                                                          .selectionColor!,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                left: 40,
                                                                bottom: 5,
                                                              ),
                                                              decoration:
                                                                  BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .secondary,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        width: 40,
                                                        height: 40,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          image:
                                                              DecorationImage(
                                                            image: NetworkImage(
                                                                'https://www.alvocomtec.com.br/acond/downloads/logocondo/${loginController.imgcondo.value}'),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                              ],
                            );
                          },
                        ),
                      )
                    ],
                  ),
                );
        },
      ),
      bottomSheet: Container(
        color: Theme.of(context).primaryColor,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).textSelectionTheme.selectionColor!,
          ),
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: respondaController.texto.value,
                  textCapitalization: TextCapitalization.sentences,
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  decoration: InputDecoration(
                    fillColor: Theme.of(context).colorScheme.secondary,
                    hintText: 'Envie uma resposta',
                    hintStyle: GoogleFonts.montserrat(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                iconSize: 25.0,
                color: Theme.of(context).colorScheme.secondary,
                onPressed: () {
                  respondaController.sendRespondaOuvidoria().then((value) {
                    print('valor $value');
                    if (value == 0) {
                      onAlertButtonPressed(context,
                          'Algo deu errado\n Tente novamente', '/home', 'sim');
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
