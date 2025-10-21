import 'package:condosocio/src/components/utils/box_search.dart';
import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/controllers/pets_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:condosocio/src/components/pets/modal_bottom_sheet.pets.dart';

class VisualizarPets extends StatelessWidget {
  const VisualizarPets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Reaproveita controller já registrado (ou registra se ainda não estiver)
    final PetsController petsController = Get.isRegistered<PetsController>()
        ? Get.find<PetsController>()
        : Get.put(PetsController());

    return Obx(() {
      if (petsController.isLoading.value) {
        return const CircularProgressIndicatorWidget();
      }

      final bool isSearching = petsController.search.value.text.isNotEmpty ||
          petsController.searchResult.isNotEmpty;

      final list =
          isSearching ? petsController.searchResult : petsController.pets;

      // CASO 1: sem busca e sem registros -> tela antiga com imagem
      if (!isSearching && list.isEmpty) {
        return Stack(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child:
                  Image.asset('images/semregistro.png', fit: BoxFit.fitWidth),
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 100),
                  Text(
                    'Sem registros',
                    style: GoogleFonts.montserrat(
                      fontSize: 14.0,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor!,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      }

      // CASOS 2 e 3: sempre mostra pesquisa + cabeçalho;
      // o corpo pode ser lista ou a mensagem central "Nenhum pet encontrado"
      return Column(
        children: [
          const SizedBox(height: 20),
          boxSearch(
            context,
            petsController.search.value,
            petsController.onSearchTextChanged,
            "Pesquise por Nome...",
          ),

          // Cabeçalho (3 colunas)
          Container(
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.secondary,
            child: Row(
              children: const [
                _HeaderCell('NOME', flex: 3),
                _HeaderCell('TIPO', flex: 2),
                _HeaderCell('RAÇA', flex: 3),
              ],
            ),
          ),

          // Corpo
          Expanded(
            child: list.isEmpty
                // CASO 2: buscando e sem resultados -> mensagem central
                ? Center(
                    child: Text(
                      'Nenhum pet encontrado',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.8,
                        color: Theme.of(context)
                            .textSelectionTheme
                            .selectionColor!,
                      ),
                    ),
                  )
                // CASO 3: há resultados -> lista normal
                : ListView.separated(
                    itemCount: list.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (_, i) {
                      final pet = list[i];
                      final String nome = pet.nome ?? '';
                      final String tipo = pet.tipo ?? '';
                      final String raca = pet.raca ?? '';

                      return InkWell(
                        onTap: () {
                          petsController.idpet.value = pet.idpet;

                          petsModalBottomSheet(
                              context,
                              pet.nome,
                              pet.tipo,
                              pet.raca,
                              pet.sexo,
                              pet.birthdate,
                              pet.imgpet,
                              petsController.idpet.value);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  nome,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor!,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  tipo,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor!,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  raca,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor!,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      );
    });
  }
}

// Helpers visuais para manter alinhamento
class _HeaderCell extends StatelessWidget {
  final String text;
  final int flex;
  const _HeaderCell(this.text, {this.flex = 1});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: GoogleFonts.montserrat(
          fontSize: 12.0,
          letterSpacing: 2,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).textSelectionTheme.selectionColor!,
        ),
      ),
    );
  }
}

class _Cell extends StatelessWidget {
  final Widget child;
  final int flex;
  const _Cell(this.child, {this.flex = 1});

  @override
  Widget build(BuildContext context) {
    return Expanded(flex: flex, child: child);
  }
}
