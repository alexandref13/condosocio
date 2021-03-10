import 'dart:convert';
import 'package:condosocio/src/services/alvo_tv/mapa_alvo_tv.dart';
import 'package:condosocio/src/services/alvo_tv/api_alvo_tv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AlvoTv extends StatefulWidget {
  @override
  _AlvoTvState createState() => _AlvoTvState();
}

class _AlvoTvState extends State<AlvoTv> {
  var videos = List<MapaAlvoTv>();
  bool isLoading = true;

  _getVideos() {
    ApiAlvoTv.getVideos().then((response) {
      setState(() {
        Iterable lista = json.decode(response.body);
        videos = lista.map((model) => MapaAlvoTv.fromJson(model)).toList();
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getVideos();
  }

  Future<void> _launched;

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Alvo Tv'),
        ),
        body: isLoading
            ? Container(
                height: MediaQuery.of(context).size.height,
                color: Theme.of(context).primaryColor,
                child: Center(
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: CircularProgressIndicator(
                      strokeWidth: 4,
                      valueColor:
                          AlwaysStoppedAnimation(Theme.of(context).accentColor),
                    ),
                  ),
                ),
              )
            : _listaVideos());
  }

  _listaVideos() {
    return Container(
      padding: EdgeInsets.all(8),
      child: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
                itemCount: videos.length,
                itemBuilder: (context, index) {
                  String video = videos[index].html;
                  var idVideo = video.split("/");
                  var id = idVideo[4];

                  String description = videos[index].descricao;
                  var cutDescription = description.split('<a');
                  var descricao = cutDescription[0];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        videos[index].publi == "<h1></h1>"
                            ? Container()
                            : Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Theme.of(context).accentColor,
                                ),
                                margin: EdgeInsets.only(bottom: 8),
                                child: Html(
                                  data: videos[index].publi,
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
                              videos[index].titulo,
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
                        RaisedButton(
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
                          onPressed: () => setState(
                            () {
                              _launched = _launchInBrowser(
                                  "https://www.youtube.com/embed/$id");
                            },
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
}
