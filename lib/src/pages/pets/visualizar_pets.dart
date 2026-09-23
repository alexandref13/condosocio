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

      if (!isSearching && list.isEmpty) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final textColor =
                Theme.of(context).textSelectionTheme.selectionColor!;
            return Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: constraints.maxWidth * 0.72,
                        maxHeight: constraints.maxHeight * 0.48,
                      ),
                      child: Image.asset(
                        'images/semregistro.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withValues(alpha: 0.42),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.10),
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Nenhum pet cadastrado',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: textColor,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Quando houver pets cadastrados na sua unidade, eles aparecerão aqui.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              height: 1.45,
                              color: textColor.withValues(alpha: 0.78),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }

      return Column(
        children: [
          const SizedBox(height: 20),
          boxSearch(
            context,
            petsController.search.value,
            petsController.onSearchTextChanged,
            "Pesquise por Nome...",
          ),
          Expanded(
            child: list.isEmpty
                ? LayoutBuilder(
                    builder: (context, constraints) {
                      final textColor =
                          Theme.of(context).textSelectionTheme.selectionColor!;
                      return Center(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: constraints.maxWidth * 0.72,
                                  maxHeight: constraints.maxHeight * 0.48,
                                ),
                                child: Image.asset(
                                  'images/semregistro.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 18,
                                  vertical: 16,
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondary
                                      .withValues(alpha: 0.42),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.10),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      'Nenhum pet encontrado',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.montserrat(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: textColor,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Tente buscar por outro nome de pet.',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        height: 1.45,
                                        color: textColor.withValues(alpha: 0.78),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    itemCount: list.length,
                    itemBuilder: (_, i) {
                      final pet = list[i];
                      final imageUrl = (pet.imgpet.trim().isEmpty)
                          ? null
                          : 'https://www.condosocio.com.br/acond/downloads/fotospets/${pet.imgpet}';
                      final textColor = Theme.of(context).textSelectionTheme.selectionColor!;

                      return GestureDetector(
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
                            petsController.idpet.value,
                            assinaturaAtiva: pet.assinaturaAtiva,
                            assinaturaAquisicao: pet.assinaturaAquisicao,
                            assinaturaVigencia: pet.assinaturaVigencia,
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: const [
                              BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 3)),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: Row(
                              children: [
                                // Foto circular
                                ClipOval(
                                  child: SizedBox(
                                    width: 64,
                                    height: 64,
                                    child: imageUrl == null
                                        ? Container(
                                            color: Theme.of(context).primaryColorDark,
                                            alignment: Alignment.center,
                                            child: Icon(Icons.pets, size: 32, color: textColor),
                                          )
                                        : Image.network(
                                            imageUrl,
                                            fit: BoxFit.cover,
                                            loadingBuilder: (_, child, progress) =>
                                                progress == null
                                                    ? child
                                                    : Container(
                                                        color: Theme.of(context).primaryColorDark,
                                                        alignment: Alignment.center,
                                                        child: const CircularProgressIndicator(
                                                          strokeWidth: 2,
                                                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                                        ),
                                                      ),
                                            errorBuilder: (_, __, ___) => Container(
                                              color: Theme.of(context).primaryColorDark,
                                              alignment: Alignment.center,
                                              child: Icon(Icons.pets, size: 32, color: textColor),
                                            ),
                                          ),
                                  ),
                                ),
                                const SizedBox(width: 14),
                                // Informações
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        pet.nome,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: textColor,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        pet.tipo.isEmpty ? '—' : pet.tipo,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          color: textColor.withValues(alpha: 0.8),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(Icons.chevron_right, color: textColor.withValues(alpha: 0.5)),
                              ],
                            ),
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
