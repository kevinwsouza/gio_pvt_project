import 'package:flutter/material.dart';

class FrotaConfigCard extends StatelessWidget {
  final VoidCallback onPressed; // Callback para a ação do botão

  const FrotaConfigCard({super.key, required this.onPressed});

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
            const Divider(), // Linha entre os switches
            const ListTile(
              title: Text('Bloqueio ignição habilitado'),
              trailing: Switch(value: true, onChanged: null),
            ),
            const Divider(), // Linha entre os switches
            const ListTile(
              title: Text('Veículo desbloqueado'),
              trailing: Switch(value: true, onChanged: null),
            ),
            const Divider(), // Linha entre os switches
            const ListTile(
              title: Text('Alarme habilitado'),
              trailing: Switch(value: true, onChanged: null),
            ),
            const Divider(),
            // Texto acima do botão
            const Padding(
              padding: EdgeInsets.only(
                  top: 16.0, bottom: 8.0), // Aumenta o espaçamento
              child: Text(
                'Desativar bloqueio de motorista por bluetooth',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black, // Texto preto
                ),
              ),
            ),
            // Botão de ação
            ElevatedButton(
              onPressed: onPressed, // Ação definida na tela
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Row(
                children: [
                  // Espaço vazio para empurrar o texto para o centro
                  const Spacer(),
                  // Texto centralizado
                  const Text(
                    'Desativar bloqueio',
                    style: TextStyle(
                      color: Colors.white, // Texto branco
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Espaço vazio para empurrar o ícone para o lado direito
                  const Spacer(),
                  // Ícone alinhado à direita
                  const Icon(Icons.bluetooth, color: Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
