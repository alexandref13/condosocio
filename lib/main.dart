import 'package:condosocio/src/components/acessos_saidas/detalhes_acessos_saida.dart';
import 'package:condosocio/src/components/acessos_saidas/visualizar_acessos_saidas.dart';
import 'package:condosocio/src/components/convites/whatsapp_convites_widget.dart';
import 'package:condosocio/src/pages/dependentes/ajuda_dependentes.dart';
import 'package:condosocio/src/pages/dependentes/dependentes.dart';
import 'package:condosocio/src/pages/enquetes.dart';
import 'package:condosocio/src/pages/senha.dart';
import 'package:condosocio/src/pages/alvo_tv.dart';
import 'package:condosocio/src/pages/comunicados.dart';
import 'package:condosocio/src/pages/convites.dart';
import 'package:condosocio/src/pages/detalhes.dart';
import 'package:condosocio/src/pages/documento.dart';
import 'package:condosocio/src/pages/documentos_pages/ata_documentos.dart';
import 'package:condosocio/src/pages/documentos_pages/contratos_documentos.dart';
import 'package:condosocio/src/pages/documentos_pages/convencao_documentos.dart';
import 'package:condosocio/src/pages/documentos_pages/editais_documentos.dart';
import 'package:condosocio/src/pages/documentos_pages/outros_documentos.dart';
import 'package:condosocio/src/pages/documentos_pages/prestacao_documentos.dart';
import 'package:condosocio/src/pages/documentos_pages/regulamento_documentos.dart';
import 'package:condosocio/src/pages/home_page.dart';
import 'package:condosocio/src/pages/login.dart';
import 'package:condosocio/src/pages/ocorrencias/ocorrencias.dart';
import 'package:condosocio/src/pages/ouvidoria/ouvidoria.dart';
import 'package:condosocio/src/pages/ouvidoria/detalhes_ouvidoria.dart';
import 'package:condosocio/src/pages/perfil.dart';
import 'package:condosocio/src/pages/reserva.dart';
import 'package:condosocio/src/pages/sobre.dart';
import 'package:condosocio/src/pages/acessos/visualizar_acessos.dart';
import 'package:condosocio/src/pages/ocorrencias/visualizar_ocorrencias.dart';
import 'package:condosocio/src/pages/ouvidoria/visualizar_ouvidoria.dart';
import 'package:condosocio/src/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'src/components/convites/detalhe_convite_widget.dart';
import 'src/pages/list_of_condo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: [
        RefreshLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [Locale('pt')],
      theme: admin,
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/login', page: () => Login()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/senha', page: () => Senha()),
        GetPage(name: '/perfil', page: () => Perfil()),
        GetPage(name: '/comunicados', page: () => Comunicados()),
        GetPage(name: '/detalhes', page: () => DetalhesComunicados()),
        GetPage(name: '/sobre', page: () => Sobre()),
        GetPage(name: '/ouvidoria', page: () => Ouvidoria()),
        GetPage(name: '/ocorrencias', page: () => Ocorrencias()),
        // GetPage(name: '/acessos', page: () => Acessos()),
        GetPage(name: '/alvoTv', page: () => AlvoTv()),
        GetPage(name: '/visualizarAcessos', page: () => VisualizarAcessos()),
        GetPage(
            name: '/visualizarOcorrencias',
            page: () => VisualizarOcorrencias()),
        GetPage(
            name: '/visualizarOuvidoria', page: () => VisualizarOuvidoria()),
        GetPage(name: '/detalhesOuvidoria', page: () => DetalhesOuvidoria()),
        GetPage(name: '/documentos', page: () => Documentos()),
        GetPage(name: '/ataDocumentos', page: () => Ata()),
        GetPage(name: '/contratosDocumentos', page: () => Contratos()),
        GetPage(name: '/convencaoDocumentos', page: () => Convencao()),
        GetPage(name: '/editaisDocumentos', page: () => Editais()),
        GetPage(name: '/outrosDocumentos', page: () => Outros()),
        GetPage(name: '/prestacaoDocumentos', page: () => Prestacao()),
        GetPage(name: '/regulamentoDocumentos', page: () => Regulamento()),
        GetPage(name: '/reserva', page: () => Reserva()),
        GetPage(name: '/listOfCondo', page: () => ListOfCondo()),
        GetPage(name: '/convites', page: () => Convite()),
        GetPage(name: '/enquetes', page: () => Enquetes()),
        GetPage(name: '/detalhesConvite', page: () => DetalheConviteWidget()),
        GetPage(name: '/whatsAppConvite', page: () => WhatsAppConvitesWidget()),
        GetPage(name: '/dependentes', page: () => Dependentes()),
        GetPage(name: '/ajudaDependentes', page: () => AjudaDependentes()),
        GetPage(
            name: '/visualizarAcessosSaidas',
            page: () => VisualizarAcessosSaidas()),
        GetPage(
            name: '/detalhesAcessosSaida', page: () => DetalhesAcessosSaida()),
      ],
    );
  }
}
