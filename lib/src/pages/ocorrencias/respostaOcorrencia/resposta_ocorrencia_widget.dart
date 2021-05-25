import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RespostaOcorrenciaWidget extends StatelessWidget {
  const RespostaOcorrenciaWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginController loginController = Get.put(LoginController());
    var adm = 0;
    var user = 1;

    return Scaffold(
      body: Column(
        children: [
          Container(
            alignment: adm == 0 ? Alignment(1, 0) : Alignment(-1, 0),
            padding: EdgeInsets.only(top: 5, bottom: 10),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * .75,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Colors.green[600],
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              loginController.imgperfil.value == ''
                                  ? Container(
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: 40, bottom: 5),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color:
                                                  Theme.of(context).accentColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: AssetImage('images/user.png'),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                              left: 40,
                                              bottom: 5,
                                            ),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color:
                                                  Theme.of(context).accentColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              'https://condosocio.com.br/acond/downloads/fotosperfil/${loginController.imgperfil.value}'),
                                        ),
                                      ),
                                    ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * .5,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      loginController.nome.value,
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        color: Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text(
                                          loginController.tipo.value,
                                          style: GoogleFonts.montserrat(
                                            fontSize: 10,
                                            color: Theme.of(context)
                                                .textSelectionTheme
                                                .selectionColor,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        ' - 02/08/2021 22:53',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 10,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Quando abre a primeira vez, clica na data de hj com marcação . Ele não deveria abrir a outra página pra incluir e sim abrir o item abaixo',
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: user == 0 ? Alignment(1, 0) : Alignment(-1, 0),
            padding: EdgeInsets.only(top: 5),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * .75,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Theme.of(context).accentColor,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              Container(
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                        left: 40,
                                        bottom: 5,
                                      ),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Theme.of(context).accentColor,
                                      ),
                                    ),
                                  ],
                                ),
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        'https://www.condosocio.com.br/acond/downloads/logocondo/${loginController.imgcondo.value}'),
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * .5,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      'ADM',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        color: Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(
                                      '02/08/2021 22:53',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 10,
                                        color: Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Quando abre a primeira vez, clica na data de hj com marcação . Ele não deveria abrir a outra página pra incluir e sim abrir o item abaixo',
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        color: Theme.of(context).accentColor,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).textSelectionTheme.selectionColor,
          ),
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  textCapitalization: TextCapitalization.sentences,
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    color: Theme.of(context).accentColor,
                  ),
                  decoration: InputDecoration(
                    fillColor: Theme.of(context).accentColor,
                    hintText: 'Envie uma resposta',
                    hintStyle: GoogleFonts.montserrat(
                      fontSize: 12,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                iconSize: 25.0,
                color: Theme.of(context).accentColor,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
