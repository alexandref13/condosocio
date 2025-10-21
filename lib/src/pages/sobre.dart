import 'package:flutter/material.dart';
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
                        width: 40,
                        height: 80,
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: Text(
                        'O CondoSócio é a plataforma digital que facilita a vida de quem administra e mora em condomínio. Uma rede de gestão colaborativa completa para os síndicos, administradores e moradores, além de integrar outros sistemas condominiais. Saiba quais os serviços que estão disponíveis pra você.',
                        style: GoogleFonts.montserrat(
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor!,
                            fontSize: 12),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(width: 1, color: Colors.black45))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          sobreLista(
                            context,
                            "Acessos",
                            'Visualize os acessos autorizados em convite. Autorize a saída de funcionários ou materiais',
                            "visualizarAcessos",
                            Icons.swap_horiz,
                          ),
                          sobreLista(
                            context,
                            "Avisos",
                            'Você receberá os avisos em tempo real e será alertado ainda por meio de notificação push (alerta) e por e-mail.',
                            "avisos",
                            Icons.mark_chat_read,
                          ),
                          sobreLista(
                            context,
                            "CondoPlay",
                            "Videos toda a semana pra você ficar super antenado com as questões dos condomínios.",
                            "alvoTv",
                            Icons.live_tv_outlined,
                          ),
                          sobreLista(
                            context,
                            "Convites",
                            "Autorize a entrada de visitantes: convidados, prestadores de serviços eventuais e app de mobilidade.",
                            "convites",
                            Icons.receipt_outlined,
                          ),
                          sobreLista(
                            context,
                            "Encomendas",
                            "Receba notificações das encomendas que chegam na administração do condominio",
                            "Encomendas",
                            Icons.local_shipping_outlined,
                          ),
                          sobreLista(
                            context,
                            "Reservas",
                            "Visualize e faça reservas de eventos e dos espaços comuns.",
                            "reserva",
                            Icons.calendar_today_outlined,
                          ),
                          sobreLista(
                            context,
                            "Comunicados",
                            "Baixe os comunicados do seu condomínio.",
                            "comunicados",
                            Icons.notification_add,
                          ),
                          sobreLista(
                            context,
                            "Documentos",
                            "Tenha sempre em mãos os documentos do seu condomínio.",
                            "documentos",
                            Icons.file_copy,
                          ),
                          sobreLista(
                            context,
                            "Enquetes",
                            "Participe das enquetes e dê a sua opinião",
                            "enquetes",
                            Icons.comment_outlined,
                          ),
                          sobreLista(
                            context,
                            "Ocorrências",
                            "Registre ocorrências, sugestões, reclamações que ocorram em seu condomínio",
                            "ocorrencias",
                            Icons.event_note_outlined,
                          ),
                          sobreLista(
                            context,
                            "Ache Aqui",
                            "Busque por produtos e serviços e avalie as prestadoras de serviço",
                            "acheAqui",
                            Icons.shopping_cart,
                          ),
                          sobreLista(
                            context,
                            "Ouvidoria",
                            "Fale diretamente com a administração do seu condomínio a qualquer hora",
                            "ouvidoria",
                            Icons.question_answer_outlined,
                          ),
                          sobreLista(
                            context,
                            "Pets",
                            "Cadastre o seu pet e tenha mais segurança e controle no condomínio",
                            "pets",
                            Icons.pets,
                          ),
                        ],
                      ),
                    ),
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
          size: 32,
          color: Colors.white,
        ),
        title: Text(title,
            style: GoogleFonts.montserrat(
                color: Theme.of(context).textSelectionTheme.selectionColor!,
                fontSize: 14,
                fontWeight: FontWeight.w500)),
        subtitle: Text(
          description,
          style: GoogleFonts.montserrat(
              color: Theme.of(context).textSelectionTheme.selectionColor!,
              fontWeight: FontWeight.w300,
              fontSize: 12),
        ),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          color: Theme.of(context).textSelectionTheme.selectionColor!,
          size: 35,
        ),
      ),
    );
  }
}
