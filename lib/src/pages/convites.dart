import 'package:condosocio/src/components/convites/convite_widget.dart';
import 'package:condosocio/src/components/convites/visualizar_convite_widget.dart';
import 'package:condosocio/src/components/convites/convites_convidados_widget.dart';
import 'package:condosocio/src/controllers/acessos/acessos_controller.dart';
import 'package:condosocio/src/controllers/convites/convites_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:condosocio/src/components/condo_nav_bar.dart';

class Convite extends StatefulWidget {
  @override
  State<Convite> createState() => _ConviteState();
}

class _ConviteState extends State<Convite> with SingleTickerProviderStateMixin {
  final AcessosController acessosController = Get.put(AcessosController());
  final ConvitesController convitesController = Get.put(ConvitesController());
  late TabController _tabController;
  Worker? _tabWorker;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      convitesController.selectedTabIndex.value = _tabController.index;
      if (_tabController.index == 1 && !_tabController.indexIsChanging) {
        if (!convitesController.hasLoadedConvites.value) {
          convitesController.getConvites();
        }
      }
    });
    _tabWorker = ever<int>(convitesController.selectedTabIndex, (index) {
      if (_tabController.index != index) {
        _tabController.animateTo(index);
      }
    });
  }

  @override
  void dispose() {
    _tabWorker?.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offNamedUntil('home', (route) => false);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.offNamedUntil('home', (route) => false);
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          title: Text(
            'Convites',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: Theme.of(context).textSelectionTheme.selectionColor!,
            ),
          ),
          bottom: TabBar(
            controller: _tabController,
            indicatorColor:
                Theme.of(context).textSelectionTheme.selectionColor!,
            indicatorPadding: EdgeInsets.all(-4),
            indicatorSize: TabBarIndicatorSize.tab,
            dividerColor: Theme.of(context)
                .textSelectionTheme
                .selectionColor!
                .withValues(alpha: 0),
            tabs: <Widget>[
              Text(
                'Adicionar',
                style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color:
                        Theme.of(context).textSelectionTheme.selectionColor!),
              ),
              Text(
                'Visualizar',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  color: Theme.of(context).textSelectionTheme.selectionColor!,
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const CondoNavBar(activeIndex: 4),
        body: Obx(() {
          return TabBarView(
            controller: _tabController,
            children: [
              convitesController.page.value == 1
                  ? ConviteWidget()
                  : ConvitesConvidadosWidget(),
              VisualizarConvite()
            ],
          );
        }),
      ),
    );
  }
}
