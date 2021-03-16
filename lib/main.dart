import 'package:condosocio/src/components/senha.dart';
import 'package:condosocio/src/pages/acessos/acessos.dart';
import 'package:condosocio/src/pages/alvo_tv.dart';
import 'package:condosocio/src/pages/comunicados.dart';
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
import 'package:condosocio/src/pages/ocorrencias.dart';
import 'package:condosocio/src/pages/ouvidoria/ouvidoria.dart';
import 'package:condosocio/src/pages/ouvidoria/detalhes_ouvidoria.dart';
import 'package:condosocio/src/pages/perfil.dart';
import 'package:condosocio/src/pages/sobre.dart';
import 'package:condosocio/src/pages/acessos/visualizar_acessos.dart';
import 'package:condosocio/src/pages/visualizar_ocorrencias.dart';
import 'package:condosocio/src/pages/ouvidoria/visualizar_ouvidoria.dart';
import 'package:condosocio/src/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: [
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
        GetPage(name: '/acessos', page: () => Acessos()),
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
      ],
    );
  }
}
