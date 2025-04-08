// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frotalog_gestor_v2/app/features/detail%20screen/presenter/bloc/details_screen_controller.dart';
import 'package:frotalog_gestor_v2/app/features/detail%20screen/presenter/bloc/details_screen_state.dart';

import 'package:frotalog_gestor_v2/app/shared/components/custom_app_bar.dart';
import 'package:frotalog_gestor_v2/app/shared/components/custom_loading.dart';
import 'package:frotalog_gestor_v2/app/shared/components/frota_call_card.dart';
import 'package:frotalog_gestor_v2/app/shared/components/frota_config_card.dart';
import 'package:frotalog_gestor_v2/app/shared/components/frota_details_card.dart';
import 'package:frotalog_gestor_v2/app/shared/mocks/vehicle_model.dart';

class DetailsPage extends StatefulWidget {
  final VehicleModel vehicle;
  const DetailsPage({
    super.key,
    required this.vehicle,
  });

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late DetailsScreenController detailsScreenController;

  @override
  void initState() {
    detailsScreenController = context.read<DetailsScreenController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsScreenController, DetailsScreenState>(builder: (context, state) {
      return Scaffold(
          appBar: const CustomAppBar(
            showBackButton: true, // Mostra o botão de voltar
            showLogoutButton: true, // Mostra o botão de logout
          ),
          body: switch (state) {
            DetailsScreenLoading() || DetailsScreenInitialState() => CustomLoadingWidget(),
            DetailsScreenErrorState() => Center(
                child: Container(
                  child: Text('Error'),
                ),
              ),
            DetailsScreenSuccessState() => Padding(
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
                        padding: const EdgeInsets.only(bottom: 8.0), // Ajusta o bottom do card
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
                            // Exibe o FrotaConfigCard como um Dialog
                            showDialog(
                              context: context,
                              barrierDismissible: false, // Desabilita cliques fora da modal
                              builder: (dialogContext) => FrotaConfigCard(
                                isLoading: state is DetailsScreenLoading,
                                onPressed: () async {
                                  // Chama a lógica de pareamento Bluetooth ao clicar no botão dentro do FrotaConfigCard
                                  await detailsScreenController.startBluetoothPairing();
                                },
                              ),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                            side: const BorderSide(color: Colors.blue), // Linha de borda azul
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
                            // Exibe o FrotaCallCard como uma modal
                            showDialog(
                              context: context,
                              barrierDismissible: false, // Desabilita cliques fora da modal
                              builder: (dialogContext) => FrotaCallCard(
                                onSend: () {
                                  // Lógica para enviar os dados ao backend
                                  print('Chamado enviado ao backend!');
                                  Navigator.of(dialogContext).pop(); // Fecha a modal após enviar
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
          });
    });
  }
}
