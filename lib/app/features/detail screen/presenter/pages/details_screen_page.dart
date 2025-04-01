import 'package:flutter/material.dart';
import '../../../../shared/components/custom_app_bar.dart';
import '../../../../shared/components/frota_details_card.dart';
import '../../../../shared/mocks/vehicle_model.dart';

class DetailsScreenPage extends StatelessWidget {
  final Vehicle vehicle;

  const DetailsScreenPage({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            // Substituir o card pelo componente FrotaCardDetails
            Expanded(
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
            const SizedBox(height: 20.0),
            // Botões
            Column(
              children: [
                OutlinedButton(
                  onPressed: () {
                    // Ação para configurações
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
    );
  }
}