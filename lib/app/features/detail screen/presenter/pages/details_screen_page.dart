import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:frotalog_gestor_v2/app/features/detail%20screen/presenter/bloc/details_screen_controller.dart';
import 'package:frotalog_gestor_v2/app/features/detail%20screen/presenter/bloc/details_screen_state.dart';
import '../../../../shared/components/custom_app_bar.dart';
import '../../../../shared/components/frota_call_card.dart';
import '../../../../shared/components/frota_config_card.dart';
import '../../../../shared/components/frota_details_card.dart';
import '../../../../shared/mocks/vehicle_model.dart';
import '../widgets/bluetooth_list_dialog.dart';

class DetailsScreenPage extends StatefulWidget {
  final VehicleModel vehicle;

  const DetailsScreenPage({super.key, required this.vehicle});

  @override
  State<DetailsScreenPage> createState() => _DetailsScreenPageState();
}

class _DetailsScreenPageState extends State<DetailsScreenPage> {
  late DetailsScreenController _controller;
  

  Future<void> _connectToDevice(BluetoothDevice device) async {
  try {
    // Exibe um indicador de carregamento enquanto conecta
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    print('Conectando ao dispositivo: ${device.platformName}');
    await device.connect();

    // Fecha o indicador de carregamento
    if (mounted) Navigator.of(context).pop();

    // Exibe uma mensagem de sucesso
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Conectado ao dispositivo: ${device.platformName}')),
    );
  } catch (e) {
    // Fecha o indicador de carregamento em caso de erro
    if (mounted) Navigator.of(context).pop();

    // Exibe uma mensagem de erro
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Erro ao conectar: $e')),
    );
  }
}

  @override
  void initState() {
    super.initState();
    _controller = DetailsScreenController();
  }

  @override
  void dispose() {
    _controller.close(); // Cancela o listener ao destruir o widget
    super.dispose();
  }

  void _startBluetoothPairing(BuildContext context) {
    print('Método _startBluetoothPairing chamado.');
    _controller.startBluetoothPairing(); // Inicia o pareamento Bluetooth
  }

  @override
Widget build(BuildContext context) {
  return BlocBuilder<DetailsScreenController, DetailsScreenState>(
    bloc: _controller,
    builder: (context, state) {
      // Exibe a SnackBar para estados de sucesso ou erro
      if (state is DetailsScreenSuccessState) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          // Exibe a lista de dispositivos encontrados
          if (state.devices != null && state.devices!.isNotEmpty) {
            showDialog(
              context: context,
              barrierDismissible: true,
              builder: (dialogContext) => BluetoothListDialog(
                devices: state.devices!,
                onConnect: (device) {
                  Navigator.of(dialogContext).pop(); // Fecha a lista antes de conectar
                  _controller.connectToDevice(device); // Conecta ao dispositivo
                },
              ),
            );
          } else {
            // Exibe uma mensagem se nenhum dispositivo foi encontrado
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Nenhum dispositivo encontrado.')),
            );
          }
        });
      }

      if (state is DetailsScreenErrorState) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        });
      }

      return Stack(
        children: [
          // Tela principal (tela de detalhes)
          Scaffold(
            appBar: const CustomAppBar(
              showBackButton: true,
              showLogoutButton: true,
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
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: FrotaCardDetails(
                        title: widget.vehicle.title,
                        status: widget.vehicle.status,
                        driver: 'Motorista Carlos Saldanha',
                        address: widget.vehicle.address,
                        lastCommunication: widget.vehicle.lastCommunication,
                        odometer: '${widget.vehicle.odometer} km',
                        horimeter: '${widget.vehicle.horimeter} h',
                        rpm: '${widget.vehicle.rpm}',
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  // Botões
                  Column(
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (dialogContext) => FrotaConfigCard(
                              onPressed: () {
                                Navigator.of(dialogContext).pop();
                                _startBluetoothPairing(context);
                              },
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          side: const BorderSide(color: Colors.blue),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: const Text(
                          'Configurações',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (dialogContext) => FrotaCallCard(
                              onSend: () {
                                print('Chamado enviado ao backend!');
                                Navigator.of(dialogContext).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Chamado enviado com sucesso!')),
                                );
                              },
                            ),
                          );
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
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Indicador de carregamento global
          if (state is DetailsScreenLoading)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5), // Fundo semitransparente
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
        ],
      );
    },
  );
}
}