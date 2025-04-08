import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:frotalog_gestor_v2/app/shared/log_utils.dart';
import 'package:go_router/go_router.dart';

class BluetoothListDialog extends StatefulWidget {
  final List<BluetoothDevice> devices;
  final Function(BluetoothDevice) onConnect;

  const BluetoothListDialog({
    super.key,
    required this.devices,
    required this.onConnect,
  });

  @override
  State<BluetoothListDialog> createState() => _BluetoothListDialogState();
}

class _BluetoothListDialogState extends State<BluetoothListDialog> {
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
                  'Dispositivos Encontrados',
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
            // Lista de dispositivos
            widget.devices.isEmpty
                ? const Text(
                    'Nenhum dispositivo encontrado.',
                    style: TextStyle(fontSize: 16.0, color: Colors.black54),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: widget.devices.length,
                      itemBuilder: (context, index) {
                        final device = widget.devices[index];
                        return ListTile(
                          title: Text(
                            device.platformName.isNotEmpty ? device.platformName : 'Dispositivo sem nome',
                          ),
                          subtitle: Text(device.remoteId.toString()),
                          trailing: ElevatedButton(
                            onPressed: () async {
                              widget.onConnect(device);
                            },
                            child: const Text('Conectar'),
                          ),
                        );
                      },
                    ),
                  ),
            const SizedBox(height: 16.0),
            // Botão de fechar
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha a modal
              },
              child: const Text('Fechar'),
            ),
          ],
        ),
      ),
    );
  }
}
