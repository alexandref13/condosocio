import 'package:condosocio/src/controllers/alvo_tv_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

Widget listaVideos(context) {
  AlvoTvController alvoTv = Get.put(AlvoTvController());
  return Container(
    padding: EdgeInsets.all(8),
    child: ListView(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
              itemCount: alvoTv.videos.length,
              itemBuilder: (context, index) {
                String video = alvoTv.videos[index].html;
                var idVideo = video.split("/");
                var id = idVideo[4];

                String description = alvoTv.videos[index].descricao;
                var cutDescription = description.split('<a');
                var descricao = cutDescription[0];
                return Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      alvoTv.videos[index].publi == "<h1></h1>"
                          ? Container()
                          : Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Theme.of(context).accentColor,
                              ),
                              margin: EdgeInsets.only(bottom: 8),
                              child: Html(
                                data: alvoTv.videos[index].publi,
                                style: {
                                  "h1": Style(
                                    fontFamily: 'Poppins',
                                    fontSize: FontSize(18),
                                    letterSpacing: 3,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
                                  ),
                                },
                              ),
                            ),
                      Container(
                          padding: EdgeInsets.only(left: 8, bottom: 5),
                          child: Text(
                            alvoTv.videos[index].titulo,
                            style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor),
                          )
                          // child: Text(
                          //   videos[index].titulo,
                          // ),
                          ),
                      Container(
                        padding: EdgeInsets.only(left: 8, bottom: 8),
                        child: Text(
                          descricao,
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor),
                        ),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              return Theme.of(context).primaryColor;
                            },
                          ),
                        ),
                        onPressed: () {
                          alvoTv.launched = alvoTv.launchInBrowser(
                              "https://www.youtube.com/embed/$id");
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.network(
                              'https://img.youtube.com/vi/$id/0.jpg',
                            ),
                            Center(
                              child: Image.asset(
                                'images/youtube_play.png',
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ],
    ),
  );
}