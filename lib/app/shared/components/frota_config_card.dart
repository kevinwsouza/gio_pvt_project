import 'package:flutter/material.dart';

class FrotaConfigCard extends StatelessWidget {
  const FrotaConfigCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0), // Bordas arredondadas
      ),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(16.0), // Bordas arredondadas
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Botão de fechar
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.blue),
                onPressed: () {
                  Navigator.of(context).pop(); // Fecha a modal
                },
              ),
            ),
            // Switches de configuração
            const ListTile(
              title: Text('Identificação do motorista habilitado'),
              trailing: Switch(value: true, onChanged: null),
            ),
            const ListTile(
              title: Text('Bloqueio ignição habilitado'),
              trailing: Switch(value: true, onChanged: null),
            ),
            const ListTile(
              title: Text('Veículo desbloqueado'),
              trailing: Switch(value: true, onChanged: null),
            ),
            const ListTile(
              title: Text('Alarme habilitado'),
              trailing: Switch(value: true, onChanged: null),
            ),
            const Divider(),
            // Botão de ação
            ElevatedButton.icon(
              onPressed: () {
                // Ação para desativar bloqueio
              },
              icon: const Icon(Icons.bluetooth, color: Colors.white),
              label: const Text('Desativar bloqueio'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}