import 'package:flutter/material.dart';

class FrotaCard extends StatelessWidget {
  final String title; // Título do card (ex: placa e modelo)
  final String status; // Status do veículo (ex: "Em movimento, 45 km/h")
  final String address; // Endereço do veículo
  final String lastCommunication; // Última comunicação (ex: "há 1 min")
  final IconData icon; // Ícone do veículo

  const FrotaCard({
    super.key,
    required this.title,
    required this.status,
    required this.address,
    required this.lastCommunication,
    this.icon = Icons.local_shipping, // Ícone padrão
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0), // Espaçamento entre os cards
      padding: const EdgeInsets.all(16.0), // Espaçamento interno
      decoration: BoxDecoration(
        color: const Color(0xFFE9EEEE), // Cor de fundo do card
        borderRadius: BorderRadius.circular(12.0), // Bordas arredondadas
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ícone do veículo
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white, // Fundo branco para o ícone
              borderRadius: BorderRadius.circular(8.0), // Bordas arredondadas
            ),
            child: Icon(
              icon,
              color: Colors.blue, // Cor do ícone
              size: 32.0, // Tamanho do ícone
            ),
          ),
          const SizedBox(width: 16.0), // Espaçamento entre o ícone e o texto
          // Informações do veículo
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Título
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8.0),
                // Status
                Text(
                  status,
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8.0),
                // Endereço
                Text(
                  address,
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8.0),
                // Última comunicação
                Text(
                  'Última comunicação $lastCommunication',
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}