import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Sobre extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Container(
              color: Theme.of(context).primaryColor,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Image.asset(
                        'images/condosocio_logo.png',
                        fit: BoxFit.contain,
                        width: 50,
                        height: 100,
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: Text(
                        'O CondoSócio é uma rede de gestão colaborativa completa para os síndicos, administradores, além de formar uma rede social para os condôminos. Você pode fazer reservas dos espaços comuns, dar acesso à convidado(s), votar em enquetes, visualizar comunicados, recomendar serviços, agendar eventos e muito mais.',
                        style: GoogleFonts.montserrat(
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                            fontSize: 15),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 14),
                      child: Text(
                        'Serviços',
                        style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor),
                      ),
                    ),
                    Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 1, color: Colors.black45))),
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            sobreLista(
                                context,
                                "Galeria",
                                "Aqui você vai ver as imagens dos eventos dos condomínios.",
                                "galeria",
                                FontAwesome.picture_o),
                            sobreLista(
                                context,
                                "Alvo Tv",
                                "Videos toda a semana pra você ficar super antenado com as questões dos condomínios.",
                                "alvotv",
                                FontAwesome.tv),
                            sobreLista(
                                context,
                                "Controle de Acessos",
                                "Autorize a entrada de visitantes (convidados ou prestadores eventuais) ou autorize a saída de funcionários ou materiais",
                                "acessos",
                                FontAwesome.arrows_h),
                            sobreLista(
                                context,
                                "Reservas",
                                "Visualize e faça reservas de eventos e dos espaços comuns.",
                                "reservas",
                                FontAwesome.calendar),
                            sobreLista(
                                context,
                                "Comunicados",
                                "Aqui você vai ver os comunicados dos eventos dos condomínios.",
                                "comunicados",
                                FontAwesome.comment),
                            sobreLista(
                                context,
                                "Documentos",
                                "Tenha sempre em mãos os documentos do seu condomínio. Regimento interno. Convenção, Atas, etc.",
                                "documentos",
                                FontAwesome.file),
                            sobreLista(
                                context,
                                "Enquetes",
                                "Participe das enquetes e dê a sua opinião",
                                "enquetes",
                                FontAwesome.comments),
                            sobreLista(
                                context,
                                "Ocorrências",
                                "Registre ocorrências, sugestões, reclamações que ocorram em seu condomínio",
                                "ocorrencias",
                                Icons.event_note),
                            sobreLista(
                                context,
                                "Ache Aqui",
                                "Busque por produtos e serviços e avalie",
                                "acheAqui",
                                FontAwesome.cart_plus),
                          ],
                        )),
                  ]),
            ),
          )),
    );
  }

  Widget sobreLista(
      context, String title, String description, String route, IconData icon) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.black))),
      child: ListTile(
        onTap: () {
          Get.toNamed('/$route');
        },
        leading: Icon(
          icon,
          size: 35,
          color: Colors.white,
        ),
        title: Text(title,
            style: GoogleFonts.montserrat(
                color: Theme.of(context).textSelectionTheme.selectionColor,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
        subtitle: Text(
          description,
          style: GoogleFonts.montserrat(
              color: Theme.of(context).textSelectionTheme.selectionColor,
              fontWeight: FontWeight.w300,
              fontSize: 13),
        ),
        trailing: Icon(
          Icons.arrow_right,
          color: Theme.of(context).textSelectionTheme.selectionColor,
          size: 35,
        ),
      ),
    );
  }
}
