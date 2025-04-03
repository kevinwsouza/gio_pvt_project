// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int currentIndex;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
  });

  @override
  State<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed, // Centraliza os ícones e textos
      currentIndex: widget.currentIndex, // Define o índice selecionado
      // Chama a função ao tocar em uma aba
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
    );
  }
}
