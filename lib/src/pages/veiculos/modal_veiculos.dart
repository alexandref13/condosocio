import 'package:condosocio/src/components/utils/alert_button_pressed.dart';
import 'package:condosocio/src/components/utils/delete_alert.dart';
import 'package:condosocio/src/components/utils/edge_alert_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/veiculos/veiculos_controller.dart';

void veiculosModalBottomSheet(
  context,
  String idvei,
  String marca,
  String modelo,
  String cor,
  String ano,
  String placa,
  String desde,
  String contagem,
  String qtdVagas,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).colorScheme.secondary,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (BuildContext bc) {
      final VeiculosController veiculosController =
          Get.put(VeiculosController());
      final Color textColor =
          Theme.of(context).textSelectionTheme.selectionColor ?? Colors.white;

      return SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white38,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
              _VehicleHeader(
                marca: marca,
                modelo: modelo,
                placa: placa,
                textColor: textColor,
              ),
              const SizedBox(height: 16),
              Divider(color: Colors.blueGrey.shade300, height: 1),
              const SizedBox(height: 12),
              _VehicleInfoRow(
                icon: Icons.palette_outlined,
                label: 'Cor',
                value: cor,
                textColor: textColor,
              ),
              _VehicleInfoRow(
                icon: Icons.calendar_today_outlined,
                label: 'Ano',
                value: ano,
                textColor: textColor,
              ),
              _VehicleInfoRow(
                icon: Icons.history_outlined,
                label: 'Desde',
                value: desde,
                textColor: textColor,
              ),
              _VehicleInfoRow(
                icon: Icons.local_parking_outlined,
                label: 'Vagas',
                value: '$contagem/$qtdVagas',
                textColor: textColor,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).colorScheme.error,
                    ),
                  ),
                  onPressed: () {
                    veiculosController.idvei.value = idvei;
                    deleteAlert(
                      context,
                      'Deseja excluir veículo?',
                      () {
                        veiculosController.deleteVeiculo().then((value) {
                          if (value == 1) {
                            veiculosController.getVeiculos();
                            showToast(
                              context,
                              'Parabéns! Veículo excluído com sucesso.',
                              '',
                            );
                            Get.back();
                            Get.back();
                          } else {
                            onAlertButtonPressed(
                              context,
                              'Algo deu errado\n Tente novamente',
                              '/home',
                              'images/error.png',
                            );
                          }
                        });
                      },
                    );
                  },
                  child: Text(
                    'Excluir',
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
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
}

class _VehicleHeader extends StatelessWidget {
  final String marca;
  final String modelo;
  final String placa;
  final Color textColor;

  const _VehicleHeader({
    required this.marca,
    required this.modelo,
    required this.placa,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 84,
          height: 84,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColorDark.withValues(alpha: 0.18),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Icon(
            Icons.directions_car_outlined,
            size: 42,
            color: textColor,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          '$marca $modelo',
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: textColor.withValues(alpha: 0.65),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).primaryColorDark.withValues(alpha: 0.22),
            border: Border.all(
              color: textColor.withValues(alpha: 0.18),
            ),
          ),
          child: Text(
            placa,
            style: GoogleFonts.montserrat(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              letterSpacing: 4,
              color: textColor,
            ),
          ),
        ),
      ],
    );
  }
}

class _VehicleInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color textColor;

  const _VehicleInfoRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: textColor.withValues(alpha: 0.78),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: textColor.withValues(alpha: 0.78),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: GoogleFonts.montserrat(
                fontSize: 12,
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
