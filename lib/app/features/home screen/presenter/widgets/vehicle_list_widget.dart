import 'package:flutter/material.dart';
import 'package:frotalog_gestor_v2/app/shared/components/frota_card.dart';
import 'package:frotalog_gestor_v2/app/shared/mocks/vehicle_model.dart';

import 'package:frotalog_gestor_v2/app/shared/mocks/vehicle_service.dart';
import 'package:frotalog_gestor_v2/app/shared/routes/home_routes.dart';
import 'package:go_router/go_router.dart';

class VehicleListWidget extends StatefulWidget {
  const VehicleListWidget({super.key});

  @override
  State<VehicleListWidget> createState() => _VehicleListWidgetState();
}

class _VehicleListWidgetState extends State<VehicleListWidget> {
  final TextEditingController _searchController = TextEditingController();
  final VehicleService _vehicleService = VehicleService(); // Instância do serviço
  List<VehicleModel> _filteredItems = []; // Lista filtrada
  List<VehicleModel> _allItems = [];

  @override
  void initState() {
    super.initState();
    _fetchVehicles(); // Busca os veículos ao iniciar
  }

  Future<void> _fetchVehicles() async {
    final vehicles = await _vehicleService.fetchVehicles(); // Chama o serviço
    setState(() {
      _allItems = vehicles;
      _filteredItems = vehicles; // Inicialmente, todos os itens são exibidos
    });
  }

  void _filterItems(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredItems = _allItems; // Mostra todos os itens se a busca estiver vazia
      } else {
        _filteredItems = _allItems
            .where((item) => item.title.toLowerCase().contains(query.toLowerCase()))
            .toList(); // Filtra os itens que contêm o texto digitado
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Campo de busca
          TextField(
            controller: _searchController,
            onChanged: _filterItems, // Chama o filtro ao digitar
            decoration: InputDecoration(
              hintText: 'Pesquisar veículo por placa',
              suffixIcon: const Icon(Icons.search, color: Colors.blue), // Ícone azul no final
              filled: true, // Preenche o fundo do campo
              fillColor: const Color(0xFFEEEEEE), // Cinza um pouco mais escuro para o fundo
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide.none, // Remove a borda
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0), // Ajusta o espaçamento interno
            ),
          ),
          const SizedBox(height: 16),
          // Lista de cards
          Expanded(
            child: _filteredItems.isEmpty
                ? const Center(
                    child: Text(
                      'Nenhum veículo encontrado',
                      style: TextStyle(fontSize: 16.0, color: Colors.black54),
                    ),
                  )
                : ListView.builder(
                    itemCount: _filteredItems.length,
                    itemBuilder: (context, index) {
                      final vehicle = _filteredItems[index];
                      return GestureDetector(
                        onTap: () {
                          context.push(HomeRoutes.details, extra: vehicle);
                        },
                        child: FrotaCard(
                          title: vehicle.title,
                          status: vehicle.status,
                          address: vehicle.address,
                          lastCommunication: vehicle.lastCommunication,
                          icon: Icons.local_shipping,
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
