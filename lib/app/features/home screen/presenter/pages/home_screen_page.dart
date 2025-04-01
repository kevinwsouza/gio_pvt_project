import 'package:flutter/material.dart';
import 'package:frotalog_gestor_v2/app/shared/components/custom_app_bar.dart';
import 'package:frotalog_gestor_v2/app/shared/mocks/vehicle_model.dart';

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
  List<Vehicle> _filteredItems = []; // Lista filtrada
  List<Vehicle> _allItems = []; // Lista completa
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
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _buildFleetNavigator(), // Aba "Frota" com navegação interna
          _buildMapScreen(), // Aba "Mapa"
          _buildRemoteScreen(), // Aba "Remoto"
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          bottom: 30.0,
          left: 16.0,
          right: 16.0,
        ), // Espaçamento para "flutuar"
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
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.directions_car),
                label: 'Frota',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.map),
                label: 'Mapa',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_remote),
                label: 'Remoto',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFleetNavigator() {
    return Navigator(
      onGenerateRoute: (settings) {
        if (settings.name == '/details') {
          final vehicle = settings.arguments as Vehicle;
          return MaterialPageRoute(
            builder: (context) => DetailsScreenPage(vehicle: vehicle),
          );
        }
        return MaterialPageRoute(
          builder: (context) => _buildFleetScreen(),
        );
      },
    );
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
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 16.0), // Ajusta o espaçamento interno
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
                              '/details',
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