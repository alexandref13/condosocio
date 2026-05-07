import 'package:condosocio/src/controllers/dependentes_controller.dart';
import 'package:condosocio/src/pages/dependentes/adiciona_dependentes.dart';
import 'package:condosocio/src/pages/dependentes/visualizar_dependentes.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:condosocio/src/components/condo_nav_bar.dart';

class Dependentes extends StatefulWidget {
  @override
  _DependentesState createState() => _DependentesState();
}

class _DependentesState extends State<Dependentes> {
  DependentesController dependentesController =
      Get.put(DependentesController());

  Widget _infoItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 3, right: 8),
            child:
                Icon(Icons.check_circle_rounded, size: 16, color: Colors.white),
          ),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.montserrat(
                fontSize: 13,
                height: 1.45,
                color: Colors.white.withValues(alpha: 0.9),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Usuários',
              style: GoogleFonts.montserrat(
                fontSize: 16,
                color: Theme.of(context).textSelectionTheme.selectionColor!,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: Icon(
                  Icons.info_outline,
                  color: Theme.of(context).textSelectionTheme.selectionColor!,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (dialogContext) {
                      return Dialog(
                        backgroundColor: Colors.transparent,
                        insetPadding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 24),
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Sobre os Usuários',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor!,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () =>
                                        Navigator.of(dialogContext).pop(),
                                    icon: const Icon(Icons.close,
                                        color: Colors.white, size: 20),
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 14),
                              _infoItem(
                                'Moradores recebem e-mail para criar senha e acessar o CondoSócio.',
                              ),
                              _infoItem(
                                'Cadastre apenas pessoas que residem com você no condomínio.',
                              ),
                              _infoItem(
                                'Para cadastro facial, o morador acessa o app com seu próprio login.',
                              ),
                              _infoItem(
                                'Prestadores: após o cadastro, envie o link de documentos via WhatsApp.',
                              ),
                              _infoItem(
                                'O descumprimento das regras sujeita a penalidades conforme o regulamento.',
                              ),
                              const SizedBox(height: 10),
                              Divider(
                                color: Colors.white.withValues(alpha: 0.15),
                                thickness: 1,
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Tornar Dependente em Titular',
                                style: GoogleFonts.montserrat(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor!,
                                ),
                              ),
                              const SizedBox(height: 8),
                              _infoItem(
                                'Ao tornar um dependente em titular, ele passa a ter acesso completo à unidade, pode por exemplo: criar convites, gerenciar usuários, cadastrar veículos e acessar todas as funcionalidades do app. Essa ação é reversível',
                              ),
                              const SizedBox(height: 8),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () =>
                                      Navigator.of(dialogContext).pop(),
                                  child: Text(
                                    'Fechar',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              )
            ],
            bottom: TabBar(
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
                  'Visualizar',
                  style: GoogleFonts.montserrat(
                      fontSize: 14,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor!),
                ),
                Text(
                  'Adicionar',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: Theme.of(context).textSelectionTheme.selectionColor!,
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: const CondoNavBar(activeIndex: 0),
          body: TabBarView(
              children: [VisualizarDependentes(), AdicionaDependentes()]),
        ),
      ),
    );
  }
}
