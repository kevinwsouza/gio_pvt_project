import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/components/custom_app_bar.dart';
import '../../../../shared/components/frota_config_card.dart';
import '../../../../shared/components/frota_details_card.dart';
import '../../../../shared/mocks/vehicle_model.dart';
import '../bloc/details_screen_controller.dart';
import '../bloc/details_screen_state.dart';

class DetailsScreenPage extends StatelessWidget {
  final Vehicle vehicle;

  const DetailsScreenPage({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return BlocListener<DetailsScreenController, DetailsScreenState>(
      listener: (context, state) {
        if (state is DetailsScreenLoading) {
          // Exibe um indicador de carregamento
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(),
                  if (state.message != null) ...[
                    const SizedBox(height: 16.0),
                    Text(state.message!),
                  ],
                ],
              ),
            ),
          );
        } else if (state is DetailsScreenSuccessState) {
          Navigator.of(context).pop(); // Fecha o indicador de carregamento
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is DetailsScreenErrorState) {
          Navigator.of(context).pop(); // Fecha o indicador de carregamento
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        appBar: const CustomAppBar(
          showBackButton: true, // Mostra o botão de voltar
          showLogoutButton: true, // Mostra o botão de logout
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Aba de informações e localização
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: const [
                      Text(
                        'Informações',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Divider(
                        color: Colors.blue,
                        thickness: 2.0,
                        height: 2.0,
                      ),
                    ],
                  ),
                  Column(
                    children: const [
                      Text(
                        'Localização',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Align(
                alignment: Alignment.centerRight, // Alinha o card à direita
                child: Padding(
                  padding: const EdgeInsets.only(
                      bottom: 8.0), // Ajusta o bottom do card
                  child: FrotaCardDetails(
                    title: vehicle.title,
                    status: vehicle.status,
                    driver: 'Motorista Carlos Saldanha',
                    address: vehicle.address,
                    lastCommunication: vehicle.lastCommunication,
                    odometer: '${vehicle.odometer} km',
                    horimeter: '${vehicle.horimeter} h',
                    rpm: '${vehicle.rpm}',
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              // Botões
              Column(
                children: [
                  OutlinedButton(
                    onPressed: () {
                      // Exibe a modal de configurações
                      showDialog(
                        context: context,
                        barrierDismissible:
                            false, // Desabilita cliques fora da modal
                        builder: (dialogContext) => BlocProvider.value(
                          value: context.read<DetailsScreenController>(),
                          child: FrotaConfigCard(
                            onPressed: () {
                              // Chama o pareamento Bluetooth
                              dialogContext
                                  .read<DetailsScreenController>()
                                  .startBluetoothPairing();
                            },
                          ),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      side: const BorderSide(
                          color: Colors.blue), // Linha de borda azul
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text(
                      'Configurações',
                      style: TextStyle(
                        color: Colors.blue, // Texto azul
                        fontWeight: FontWeight.bold, // Texto em negrito
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  ElevatedButton(
                    onPressed: () {
                      // Ação para abrir chamado
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text(
                      'Abrir chamado',
                      style: TextStyle(
                        color: Colors.white, // Texto branco
                        fontWeight: FontWeight.bold, // Texto em negrito
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
