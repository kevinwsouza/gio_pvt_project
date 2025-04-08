import 'package:flutter/material.dart';

class FrotaConfigCard extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;

  const FrotaConfigCard({
    super.key,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Stack(
        children: [
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.lightBlue),
                )
              : Container(),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.blue),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                const ListTile(
                  title: Text('Identificação do motorista habilitado'),
                  trailing: Switch(value: true, onChanged: null),
                ),
                const Divider(),
                const ListTile(
                  title: Text('Bloqueio ignição habilitado'),
                  trailing: Switch(value: true, onChanged: null),
                ),
                const Divider(),
                const ListTile(
                  title: Text('Veículo desbloqueado'),
                  trailing: Switch(value: true, onChanged: null),
                ),
                const Divider(),
                const ListTile(
                  title: Text('Alarme habilitado'),
                  trailing: Switch(value: true, onChanged: null),
                ),
                const Divider(),
                const Padding(
                  padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
                  child: Text(
                    'Desativar bloqueio de motorista por bluetooth',
                    style: TextStyle(fontSize: 14.0, color: Colors.black),
                  ),
                ),
                ElevatedButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Spacer(),
                      const Text(
                        'Desativar bloqueio',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.bluetooth, color: Colors.white),
                    ],
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
