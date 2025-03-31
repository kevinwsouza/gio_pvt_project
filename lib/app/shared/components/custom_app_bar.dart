import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showBackButton; // Controla o botão de voltar
  final bool showLogoutButton; // Controla o botão de logout

  const CustomAppBar({
    super.key,
    this.showBackButton = false,
    this.showLogoutButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true, // Centraliza o conteúdo do título
      title: Image.asset(
        'assets/frotalog_logo_1.png',
        width: 76, // Caminho do logo
        height: 12, // Altura do logo
      ),
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.blue,),
              onPressed: () {
                Navigator.of(context).pop(); // Volta para a tela anterior
              },
            )
          : null,
      actions: [
        if (showLogoutButton)
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.blue,),
            onPressed: () {
              context.go('/login'); // Navega para a tela de login
            },
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}