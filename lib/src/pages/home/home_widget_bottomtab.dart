import 'package:carousel_slider/carousel_slider.dart';
import 'package:condosocio/src/controllers/acessos/visualizar_acessos_controller.dart';
import 'package:condosocio/src/controllers/convites/convites_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/esperaacessos/visualizar_acessos_espera_controller.dart';
import '../../controllers/home_page_controller.dart';
import '../../controllers/login_controller.dart';

class HomeBottomTab extends StatefulWidget {
  @override
  _HomeBottomTabState createState() => _HomeBottomTabState();
}

enum Availability { loading, available, unavailable }

class _HomeBottomTabState extends State<HomeBottomTab> {
  ConvitesController convitesController = Get.put(ConvitesController());
  VisualizarAcessosController visualizarAcessosController =
      Get.put(VisualizarAcessosController());
  VisualizarAcessosEsperaController visualizarAcessosEsperaController =
      Get.put(VisualizarAcessosEsperaController());
  final LoginController loginController = Get.put(LoginController());
  final HomePageController homePageController = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: FutureBuilder<List<String>>(
            future: HomePageController.getBannersHome(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return CarouselSlider(
                  options: CarouselOptions(
                    enlargeCenterPage: true,
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    reverse: false,
                    autoPlayAnimationDuration: Duration(milliseconds: 500),
                    autoPlayInterval: Duration(seconds: 5),
                  ),
                  items: snapshot.data!
                      .map(
                        (e) => ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              Image.network(
                                e,
                                height: 200,
                                fit: BoxFit.cover,
                              )
                            ],
                          ),
                        ),
                      )
                      .toList(),
                );
              }
            },
          ),
        ),
        Expanded(
          child: Container(
            child: CustomScrollView(
              primary: false,
              slivers: <Widget>[
                SliverPadding(
                  padding: const EdgeInsets.all(20),
                  sliver: SliverGrid.count(
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    crossAxisCount: 4,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          convitesController.page.value = 1;
                          Get.toNamed('/convites');
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).colorScheme.secondary,
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  spreadRadius: 3,
                                  blurRadius: 1,
                                  offset: Offset(
                                      0, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Icon(
                                    Icons.contact_mail_outlined,
                                    size: 35,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor!,
                                  ),
                                ),
                                Text(
                                  "Convites",
                                  style: GoogleFonts.montserrat(
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor!,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            )),
                      ),
                      GestureDetector(
                        onTap: () {
                          visualizarAcessosEsperaController.getAcessosEspera();
                          visualizarAcessosController.getAcessos();
                          Get.toNamed('/visualizarAcessos');
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).colorScheme.secondary,
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  spreadRadius: 3,
                                  blurRadius: 1,
                                  offset: Offset(
                                      0, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Icon(
                                    Icons.swap_horiz,
                                    size: 40,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor!,
                                  ),
                                ),
                                Text(
                                  "Acessos",
                                  style: GoogleFonts.montserrat(
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor!,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            )),
                      ),
                      loginController.condofacial.value == "SIM"
                          ? GestureDetector(
                              onTap: () {
                                Get.toNamed('/facial');
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        spreadRadius: 3,
                                        blurRadius: 1,
                                        offset: Offset(
                                            0, 2), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: Icon(
                                          Icons.face_5_sharp,
                                          size: 35,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor!,
                                        ),
                                      ),
                                      Text(
                                        "Facial",
                                        style: GoogleFonts.montserrat(
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor!,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ],
                                  )),
                            )
                          : GestureDetector(
                              onTap: () {
                                //Get.toNamed('/perfil');
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withOpacity(0.5),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        spreadRadius: 3,
                                        blurRadius: 1,
                                        offset: Offset(
                                            0, 2), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: Icon(
                                          Icons.face_5_sharp,
                                          size: 35,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor!
                                              .withOpacity(0.5),
                                        ),
                                      ),
                                      Text(
                                        "Facial",
                                        style: GoogleFonts.montserrat(
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor!
                                              .withOpacity(0.5),
                                          fontSize: 11,
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                      loginController.dep.value == '0'
                          ? GestureDetector(
                              onTap: () {
                                Get.toNamed('/veiculos');
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        spreadRadius: 3,
                                        blurRadius: 1,
                                        offset: Offset(
                                            0, 2), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: Icon(
                                          Icons.directions_car_outlined,
                                          size: 40,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor!,
                                        ),
                                      ),
                                      Text(
                                        "Veículos",
                                        style: GoogleFonts.montserrat(
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor!,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ],
                                  )),
                            )
                          : GestureDetector(
                              onTap: () {
                                //Get.toNamed('/veiculos');
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withOpacity(0.5),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        spreadRadius: 3,
                                        blurRadius: 1,
                                        offset: Offset(
                                            0, 2), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: Icon(
                                          Icons.directions_car_outlined,
                                          size: 40,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor!
                                              .withOpacity(0.5),
                                        ),
                                      ),
                                      Text(
                                        "Veículos",
                                        style: GoogleFonts.montserrat(
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor!
                                              .withOpacity(0.5),
                                          fontSize: 11,
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed('/reserva');
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).colorScheme.secondary,
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  spreadRadius: 3,
                                  blurRadius: 1,
                                  offset: Offset(
                                      0, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Icon(
                                    Icons.date_range_outlined,
                                    size: 35,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor!,
                                  ),
                                ),
                                Text(
                                  "Reservas",
                                  style: GoogleFonts.montserrat(
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor!,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            )),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed('/ocorrencias');
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).colorScheme.secondary,
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  spreadRadius: 3,
                                  blurRadius: 1,
                                  offset: Offset(
                                      0, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Icon(
                                    Icons.report_problem_outlined,
                                    size: 35,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor!,
                                  ),
                                ),
                                Text(
                                  "Ocorrências",
                                  style: GoogleFonts.montserrat(
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor!,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            )),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed('/documentos');
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).colorScheme.secondary,
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  spreadRadius: 3,
                                  blurRadius: 1,
                                  offset: Offset(
                                      0, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Icon(
                                    Icons.file_copy_outlined,
                                    size: 35,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor!,
                                  ),
                                ),
                                Text(
                                  "Documentos",
                                  style: GoogleFonts.montserrat(
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor!,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            )),
                      ),
                      loginController.dep.value == '0'
                          ? GestureDetector(
                              onTap: () {
                                Get.toNamed('/dependentes');
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        spreadRadius: 3,
                                        blurRadius: 1,
                                        offset: Offset(
                                            0, 2), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: Icon(
                                          Icons.group_outlined,
                                          size: 40,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor!,
                                        ),
                                      ),
                                      Text(
                                        "Usuários",
                                        style: GoogleFonts.montserrat(
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor!,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ],
                                  )),
                            )
                          : GestureDetector(
                              onTap: () {
                                //Get.toNamed('/dependentes');
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withOpacity(0.5),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        spreadRadius: 3,
                                        blurRadius: 1,
                                        offset: Offset(
                                            0, 2), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: Icon(
                                          Icons.group_outlined,
                                          size: 40,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor!
                                              .withOpacity(0.5),
                                        ),
                                      ),
                                      Text(
                                        "Usuários",
                                        style: GoogleFonts.montserrat(
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor!
                                              .withOpacity(0.5),
                                          fontSize: 11,
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed('/avisos');
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).colorScheme.secondary,
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  spreadRadius: 3,
                                  blurRadius: 1,
                                  offset: Offset(
                                      0, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Icon(
                                    Icons.comment_outlined,
                                    size: 35,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor!,
                                  ),
                                ),
                                Text(
                                  "Avisos",
                                  style: GoogleFonts.montserrat(
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor!,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            )),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed('/comunicados');
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).colorScheme.secondary,
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  spreadRadius: 3,
                                  blurRadius: 1,
                                  offset: Offset(
                                      0, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Icon(
                                    Icons.campaign_outlined,
                                    size: 40,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor!,
                                  ),
                                ),
                                Text(
                                  "Comunicados",
                                  style: GoogleFonts.montserrat(
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor!,
                                    fontSize: 11,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  softWrap: false,
                                ),
                              ],
                            )),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed('/alvoTv');
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).colorScheme.secondary,
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  spreadRadius: 3,
                                  blurRadius: 1,
                                  offset: Offset(
                                      0, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Icon(
                                    Icons.live_tv_outlined,
                                    size: 35,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor!,
                                  ),
                                ),
                                Text(
                                  "CondoPlay",
                                  style: GoogleFonts.montserrat(
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor!,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            )),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed('/ouvidoria');
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).colorScheme.secondary,
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  spreadRadius: 3,
                                  blurRadius: 1,
                                  offset: Offset(
                                      0, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Icon(
                                    Icons.question_answer_outlined,
                                    size: 35,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor!,
                                  ),
                                ),
                                Text(
                                  "Ouvidoria",
                                  style: GoogleFonts.montserrat(
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor!,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            )),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed('/enquetes');
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).colorScheme.secondary,
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  spreadRadius: 3,
                                  blurRadius: 1,
                                  offset: Offset(
                                      0, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Icon(
                                    Icons.ballot_outlined,
                                    size: 35,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor!,
                                  ),
                                ),
                                Text(
                                  "Enquetes",
                                  style: GoogleFonts.montserrat(
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor!,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            )),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed('/acheAqui');
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).colorScheme.secondary,
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  spreadRadius: 3,
                                  blurRadius: 1,
                                  offset: Offset(
                                      0, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Icon(
                                    Icons.shopping_cart_outlined,
                                    size: 35,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor!,
                                  ),
                                ),
                                Text(
                                  "Ache Aqui",
                                  style: GoogleFonts.montserrat(
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor!,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            )),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed('/encomendas');
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).colorScheme.secondary,
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  spreadRadius: 3,
                                  blurRadius: 1,
                                  offset: Offset(
                                      0, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: Icon(
                                    Icons.local_shipping_outlined,
                                    size: 35,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor!,
                                  ),
                                ),
                                Text(
                                  "Encomendas",
                                  style: GoogleFonts.montserrat(
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor!,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            )),
                      ),
                      GestureDetector(
                        onTap: () {
                          homePageController.launched =
                              homePageController.launchInBrowser(
                            'https://api.whatsapp.com/send?phone=5591981220670',
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).colorScheme.secondary,
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).colorScheme.secondary,
                                spreadRadius: 3,
                                blurRadius: 1,
                                offset:
                                    Offset(0, 2), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment
                                .center, // Define o alinhamento transversal como center
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                /*child: Badge(
                                  label: Text('Breve'),
                                  textColor: Colors.black87,
                                  backgroundColor: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor!,*/
                                child: Icon(
                                  Icons.help_outline_rounded,
                                  size: 35,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor!,
                                ),
                              ),
                              //),
                              Center(
                                child: Text(
                                  "Central de Ajuda",
                                  style: GoogleFonts.montserrat(
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor!,
                                    fontSize: 11,
                                  ),
                                  textAlign: TextAlign.center,
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
          ),
        ),
      ],
    );
  }
}
