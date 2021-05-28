import 'package:condosocio/src/components/acessos_saidas/detalhes_acessos_saida.dart';
import 'package:condosocio/src/components/acessos_saidas/visualizar_acessos_saidas.dart';
import 'package:condosocio/src/components/convites/whatsapp_convites_widget.dart';
import 'package:condosocio/src/pages/acheAqui/ache_aqui.dart';
import 'package:condosocio/src/pages/acheAqui/ache_aqui_form.dart';
import 'package:condosocio/src/pages/acheAqui/empresa_ache_aqui.dart';
import 'package:condosocio/src/pages/acheAqui/lista_ache_aqui.dart';
import 'package:condosocio/src/pages/enquetes/enquetes.dart';
import 'package:condosocio/src/pages/enquetes/info_enquetes.dart';
import 'package:condosocio/src/pages/enquetes/votar_enquete.dart';
import 'package:condosocio/src/pages/ocorrencias/foto_ocorrencia_detalhe.dart';
import 'package:condosocio/src/pages/ocorrencias/resposta_ocorrencias.dart';
import 'package:condosocio/src/pages/reservas/calendario_reservas.dart';
import 'package:condosocio/src/components/reservas/termos_reservas.dart';
import 'package:condosocio/src/pages/dependentes/ajuda_dependentes.dart';
import 'package:condosocio/src/pages/dependentes/dependentes.dart';
import 'package:condosocio/src/pages/reservas/add_reservas.dart';
import 'package:condosocio/src/pages/reservas/detalhes_reservas.dart';
import 'package:condosocio/src/pages/senha.dart';
import 'package:condosocio/src/pages/alvo_tv.dart';
import 'package:condosocio/src/pages/comunicados/comunicados.dart';
import 'package:condosocio/src/pages/convites.dart';
import 'package:condosocio/src/pages/comunicados/detalhes_comunicados.dart';
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
import 'package:condosocio/src/pages/reservas/reserva.dart';
import 'package:condosocio/src/pages/sobre.dart';
import 'package:condosocio/src/pages/acessos/visualizar_acessos.dart';
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
        GetPage(name: '/alvoTv', page: () => AlvoTv()),
        GetPage(name: '/visualizarAcessos', page: () => VisualizarAcessos()),
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
        GetPage(name: '/detalhesConvite', page: () => DetalheConviteWidget()),
        GetPage(name: '/whatsAppConvite', page: () => WhatsAppConvitesWidget()),
        GetPage(name: '/dependentes', page: () => Dependentes()),
        GetPage(name: '/ajudaDependentes', page: () => AjudaDependentes()),
        GetPage(
            name: '/visualizarAcessosSaidas',
            page: () => VisualizarAcessosSaidas()),
        GetPage(
            name: '/detalhesAcessosSaida', page: () => DetalhesAcessosSaida()),
        GetPage(name: '/addReservas', page: () => AddReservas()),
        GetPage(name: '/calendario', page: () => TableCalendarWidget()),
        GetPage(name: '/termos', page: () => TermosReservas()),
        GetPage(name: '/detalheReservas', page: () => DetalhesReservas()),
        GetPage(name: '/respostaOcorrencia', page: () => RespostaOcorrencias()),
        GetPage(name: '/enquetes', page: () => Enquetes()),
        GetPage(name: '/votarEnquetes', page: () => VotarEnquete()),
        GetPage(name: '/infoEnquete', page: () => InfoEnquetes()),
        GetPage(name: '/fotoOcorrencia', page: () => FotoOcorrencia()),
        GetPage(name: '/acheAqui', page: () => AcheAqui()),
        GetPage(name: '/listaAcheAqui', page: () => ListaAcheAqui()),
        GetPage(name: '/acheAquiForm', page: () => AcheAquiForm()),
        GetPage(name: '/detalhesAcheAqui', page: () => EmpresaAcheAqui()),
      ],
    );
  }
}
