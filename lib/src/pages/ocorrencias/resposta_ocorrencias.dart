import 'package:condosocio/src/components/utils/alert_button_pressed.dart';
import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:condosocio/src/controllers/ocorrencias/resposta_ocorrencias_controller.dart';
import 'package:condosocio/src/controllers/ocorrencias/visualizar_ocorrencias_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RespostaOcorrencias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoginController loginController = Get.put(LoginController());
    RespostaOcorrenciasController respostaOcorrenciasController =
        Get.put(RespostaOcorrenciasController());
    VisualizarOcorrenciasController ocorrenciasController =
        Get.put(VisualizarOcorrenciasController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          ocorrenciasController.titulo.value,
          style: GoogleFonts.montserrat(
            fontSize: 16,
            color: Theme.of(context).textSelectionTheme.selectionColor!,
          ),
        ),
      ),
      body: Obx(() {
        return respostaOcorrenciasController.isLoading.value
            ? CircularProgressIndicatorWidget()
            : Container(
                child: Column(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 1,
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor!,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10,
                        ),
                        margin: EdgeInsets.symmetric(
                          horizontal: 6,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'TIPO: ',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor!,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  ocorrenciasController.tipo.value,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor!,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  Text(
                                    'OCORRIDO EM: ',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor!,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    ' ${ocorrenciasController.dataoco.value} às ${ocorrenciasController.houroco.value}h',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor!,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  Text(
                                    'STATUS: ',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor!,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    ocorrenciasController.status.value == '0'
                                        ? 'Pendente'
                                        : 'Resolvida',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor!,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ocorrenciasController.imagem.value != ''
                                ? Container(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Get.toNamed('/fotoOcorrencia');
                                          },
                                          child: Container(
                                            padding: EdgeInsets.only(top: 10),
                                            child: Hero(
                                              transitionOnUserGestures: true,
                                              tag: 'FotoOcorrencia',
                                              child: Image(
                                                image: NetworkImage(
                                                  'https://www.condosocio.com.br/acond/downloads/ocorrencias/${ocorrenciasController.imagem.value}',
                                                ),
                                                width: 45,
                                                height: 45,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Clique na imagem para ampliar',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 12,
                                            color: Theme.of(context)
                                                .textSelectionTheme
                                                .selectionColor!,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(),
                          ],
                        )),
                    Expanded(
                      child: ListView.builder(
                        itemCount:
                            respostaOcorrenciasController.resposta.length,
                        itemBuilder: (_, i) {
                          var resposta =
                              respostaOcorrenciasController.resposta[i];
                          return Column(
                            children: [
                              resposta.idraiz != ''
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
                                                loginController
                                                            .imgperfil.value ==
                                                        ''
                                                    ? Container(
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: 40,
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
                                                        width: 50,
                                                        height: 50,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          image:
                                                              DecorationImage(
                                                            image: NetworkImage(
                                                                'https://www.condosocio.com.br/acond/downloads/fotosperfil/${loginController.imgperfil.value}'),
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
                                                                .circular(15.0),
                                                      ),
                                                      color: Colors.green[600],
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            padding: EdgeInsets
                                                                .fromLTRB(
                                                                    7, 5, 7, 0),
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
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          .5,
                                                                      child:
                                                                          Text(
                                                                        loginController
                                                                            .nome
                                                                            .value,
                                                                        style: GoogleFonts
                                                                            .montserrat(
                                                                          fontSize:
                                                                              12,
                                                                          color: Theme.of(context)
                                                                              .textSelectionTheme
                                                                              .selectionColor!,
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
                                                                      color: Theme.of(
                                                                              context)
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
                                                                EdgeInsets.all(
                                                                    10),
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                .9,
                                                            child: Text(
                                                              ocorrenciasController
                                                                  .descricao
                                                                  .value,
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
                                                                    'https://www.condosocio.com.br/acond/downloads/fotosperfil/${loginController.imgperfil.value}'),
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
                                                                          width:
                                                                              MediaQuery.of(context).size.width * .5,
                                                                          child:
                                                                              Text(
                                                                            resposta.nomeusu,
                                                                            style:
                                                                                GoogleFonts.montserrat(
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
                                                                            fontSize:
                                                                                10,
                                                                            color:
                                                                                Theme.of(context).textSelectionTheme.selectionColor!,
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                    Container(
                                                                      child:
                                                                          Text(
                                                                        resposta
                                                                            .tipousu,
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
                                          padding: EdgeInsets.only(bottom: 10),
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
                                                          color:
                                                              Theme.of(context)
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
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                          '${resposta.data} ${resposta.hora}h',
                                                                          style:
                                                                              GoogleFonts.montserrat(
                                                                            fontSize:
                                                                                10,
                                                                            color:
                                                                                Theme.of(context).textSelectionTheme.selectionColor!,
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          child:
                                                                              Text(
                                                                            resposta.nomeusu,
                                                                            style:
                                                                                GoogleFonts.montserrat(
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
                                                                        style: GoogleFonts
                                                                            .montserrat(
                                                                          fontSize:
                                                                              10,
                                                                          color: Theme.of(context)
                                                                              .textSelectionTheme
                                                                              .selectionColor!,
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
                                                            margin:
                                                                EdgeInsets.only(
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
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        image: DecorationImage(
                                                          image: NetworkImage(
                                                              'https://www.condosocio.com.br/acond/downloads/logocondo/${loginController.imgcondo.value}'),
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
                    ),
                  ],
                ),
              );
      }),
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        color: Theme.of(context).primaryColor,
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
                  controller: respostaOcorrenciasController.texto.value,
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
                  respostaOcorrenciasController
                      .sendOcorrenciaResp()
                      .then((value) {
                    if (value == 0) {
                      onAlertButtonPressed(
                          context,
                          'Algo deu errado\n Tente novamente',
                          '/home',
                          'images/error.png');
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
