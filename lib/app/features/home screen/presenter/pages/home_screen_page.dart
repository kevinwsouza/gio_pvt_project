import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frotalog_gestor_v2/app/features/home%20screen/presenter/bloc/home_screen_controller.dart';
import 'package:frotalog_gestor_v2/app/features/home%20screen/presenter/bloc/home_screen_state.dart';
import 'package:frotalog_gestor_v2/app/shared/components/custom_app_bar.dart';
import 'package:frotalog_gestor_v2/app/shared/mocks/vehicle_model.dart';
import 'package:frotalog_gestor_v2/app/shared/routes/home_routes.dart';

import '../../../../shared/components/frota_card.dart';
import '../../../../shared/mocks/vehicle_service.dart';

import '../../../detail screen/presenter/pages/details_screen_page.dart';

class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({super.key});

  @override
  State<HomeScreenPage> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
  final TextEditingController _searchController = TextEditingController();
  final VehicleService _vehicleService = VehicleService(); // Instância do serviço
  List<VehicleModel> _filteredItems = []; // Lista filtrada
  List<VehicleModel> _allItems = []; // Lista completa
  int _currentIndex = 0; // Índice da aba selecionada

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

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenController, HomeScreenState>(builder: (context, state) {
      return Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            // Aba "Frota" com navegação interna
            _currentIndex == 0 ? DetailsScreenPage(vehicle: VehicleModel.initial()) : _buildFleetScreen(),
            _buildMapScreen(), // Aba "Mapa"
            _buildRemoteScreen(), // Aba "Remoto"
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(
            bottom: 40.0,
            left: 16.0,
            right: 16.0,
          ), // Espaçamento externo para "flutuar"
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0), // Bordas arredondadas
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed, // Centraliza os ícones e textos
              currentIndex: _currentIndex, // Define o índice selecionado
              onTap: _onTabTapped, // Chama a função ao tocar em uma aba
              selectedItemColor: Colors.blue, // Cor do texto e ícone selecionados
              unselectedItemColor: Colors.black, // Cor do texto e ícone não selecionados
              backgroundColor: const Color(0xFFEEEEEE), // Mesma cor do campo de busca
              elevation: 0, // Remove a sombra padrão
              showSelectedLabels: true, // Mostra os rótulos selecionados
              showUnselectedLabels: true, // Mostra os rótulos não selecionados
              selectedLabelStyle: const TextStyle(
                fontSize: 12.0, // Tamanho do texto selecionado
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 12.0, // Tamanho do texto não selecionado
              ),
              items: const [
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(top: 20.0), // Ajusta o ícone verticalmente
                    child: Icon(Icons.directions_car, size: 24.0), // Ícone centralizado
                  ),
                  label: 'Frota',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(top: 20.0), // Ajusta o ícone verticalmente
                    child: Icon(Icons.map, size: 24.0), // Ícone centralizado
                  ),
                  label: 'Mapa',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(top: 20.0), // Ajusta o ícone verticalmente
                    child: Icon(Icons.settings_remote, size: 24.0), // Ícone centralizado
                  ),
                  label: 'Remoto',
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildFleetScreen() {
    return Scaffold(
      appBar: CustomAppBar(
        showBackButton: false,
        showLogoutButton: true,
      ),
      body: Padding(
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
                            Navigator.of(context).pushNamed(
                              HomeRoutes.details,
                              arguments: vehicle,
                            );
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
      ),
    );
  }

  Widget _buildMapScreen() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Conteúdo da aba Mapa'),
      ),
    );
  }

  Widget _buildRemoteScreen() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Remoto'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Conteúdo da aba Remoto'),
      ),
    );
  }
}
