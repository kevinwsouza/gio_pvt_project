import 'package:flutter/material.dart';

class OpenCallDialog extends StatelessWidget {
  const OpenCallDialog({super.key});

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
          children: [
            // Cabeçalho com o botão de fechar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Abrir Chamado',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop(); // Fecha a modal
                  },
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            // Campos do formulário
            const TextField(
              decoration: InputDecoration(
                labelText: 'Motivo',
                hintText: 'Motivo da solicitação',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Nome do contato',
                hintText: 'Contato para o chamado',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Telefone de contato',
                hintText: '(xx) xxxxx-xxxx',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            const TextField(
              decoration: InputDecoration(
                labelText: 'E-mail',
                hintText: 'E-mail de contato',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            // Botão de enviar
            ElevatedButton(
              onPressed: () {
                // Lógica para enviar o formulário
                Navigator.of(context).pop(); // Fecha a modal após enviar
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text(
                'Enviar',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}