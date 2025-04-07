import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../../../../shared/components/custom_app_bar.dart';
import '../../../../shared/components/frota_call_card.dart';
import '../../../../shared/components/frota_config_card.dart';
import '../../../../shared/components/frota_details_card.dart';
import '../../../../shared/globals/permission_menager_bluetooth.dart';
import '../../../../shared/mocks/vehicle_model.dart';

class DetailsScreenPage extends StatefulWidget {
  final VehicleModel vehicle;

  const DetailsScreenPage({super.key, required this.vehicle});

  @override
  State<DetailsScreenPage> createState() => _DetailsScreenPageState();
}

class _DetailsScreenPageState extends State<DetailsScreenPage> {
  // MARKER: Variáveis de estado do Bluetooth
  bool _isScanning = false;
  StreamSubscription? _scanSubscription;
  List<BluetoothDevice> _devices = []; // Lista de dispositivos encontrados

  // MARKER: Lógica do Bluetooth
  Future<void> _startBluetoothPairing(BuildContext context) async {
    print('Iniciando pareamento Bluetooth...');

    // Solicita permissões usando a classe global
    bool permissionsGranted = await PermissionManagerBluetooth().requestPermissions();

    if (!permissionsGranted) {
      if (!mounted) return; // Verifica se o widget ainda está montado
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Permissões necessárias não foram concedidas.')),
      );
      return;
    }

    if (_isScanning) {
      if (!mounted) return; // Verifica se o widget ainda está montado
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Já está em andamento um escaneamento de dispositivos.')),
      );
      return;
    }

    setState(() {
      _isScanning = true; // Marca como escaneando
      _devices.clear(); // Limpa a lista de dispositivos
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      // Verifica se o Bluetooth está ligado
      bool isOn = await FlutterBluePlus.adapterState.first == BluetoothAdapterState.on;
      if (!isOn) {
        if (!mounted) return; // Verifica se o widget ainda está montado
        Navigator.of(context).pop(); // Fecha o indicador de carregamento
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Bluetooth está desligado. Por favor, ligue o Bluetooth.')),
        );
        setState(() {
          _isScanning = false; // Libera o estado de escaneamento
        });
        return;
      }

      // Inicia o escaneamento de dispositivos
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Escaneando dispositivos...')),
      );
      FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));

      // Escuta os dispositivos encontrados
      _scanSubscription = FlutterBluePlus.scanResults.listen((results) {
        setState(() {
          _devices = results.map((r) => r.device).toList();
        });
      });

      // Para o escaneamento após 5 segundos
      await Future.delayed(const Duration(seconds: 5));
      FlutterBluePlus.stopScan();

      if (!mounted) return; // Verifica se o widget ainda está montado
      Navigator.of(context).pop(); // Fecha o indicador de carregamento
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Escaneamento concluído! Selecione um dispositivo para parear.')),
      );

      // Exibe a lista de dispositivos encontrados
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) => Dialog(
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
                        Navigator.of(dialogContext).pop(); // Fecha a modal
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                // Lista de dispositivos
                _devices.isEmpty
                    ? const Text(
                        'Nenhum dispositivo encontrado.',
                        style: TextStyle(fontSize: 16.0, color: Colors.black54),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: _devices.length,
                          itemBuilder: (context, index) {
                            final device = _devices[index];
                            return ListTile(
                              title: Text(
                                device.platformName.isNotEmpty ? device.platformName : 'Dispositivo sem nome',
                              ),
                              subtitle: Text(device.remoteId.toString()),
                              trailing: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(dialogContext).pop(); // Fecha a lista
                                  _connectToDevice(device); // Conecta ao dispositivo
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
                    Navigator.of(dialogContext).pop(); // Fecha a modal
                  },
                  child: const Text('Fechar'),
                ),
              ],
            ),
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return; // Verifica se o widget ainda está montado
      Navigator.of(context).pop(); // Fecha o indicador de carregamento
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao parear: $e')),
      );
    } finally {
      _scanSubscription?.cancel(); // Cancela o listener
      if (mounted) {
        setState(() {
          _isScanning = false; // Libera o estado de escaneamento
        });
      }
    }
  }

  // MARKER: Lógica de Conexão
  Future<void> _connectToDevice(BluetoothDevice device) async {
    try {
      print('Conectando ao dispositivo: ${device.platformName}');
      await device.connect();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Conectado ao dispositivo: ${device.platformName}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao conectar: $e')),
      );
    }
  }

  @override
  void dispose() {
    _scanSubscription?.cancel(); // Cancela o listener ao destruir o widget
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        showBackButton: true, // Mostra o botão de voltar
        showLogoutButton: true, // Mostra o botão de logout
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Aba de informações e localização
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: const [
                    Text(
                      'Informações',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Divider(
                      color: Colors.blue,
                      thickness: 2.0,
                      height: 2.0,
                    ),
                  ],
                ),
                Column(
                  children: const [
                    Text(
                      'Localização',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Align(
              alignment: Alignment.centerRight, // Alinha o card à direita
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0), // Ajusta o bottom do card
                child: FrotaCardDetails(
                  title: widget.vehicle.title,
                  status: widget.vehicle.status,
                  driver: 'Motorista Carlos Saldanha',
                  address: widget.vehicle.address,
                  lastCommunication: widget.vehicle.lastCommunication,
                  odometer: '${widget.vehicle.odometer} km',
                  horimeter: '${widget.vehicle.horimeter} h',
                  rpm: '${widget.vehicle.rpm}',
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            // Botões
            Column(
              children: [
                OutlinedButton(
                  onPressed: () {
                    // Exibe o FrotaConfigCard como um Dialog
                    showDialog(
                      context: context,
                      barrierDismissible: false, // Desabilita cliques fora da modal
                      builder: (dialogContext) => FrotaConfigCard(
                        onPressed: () {
                          // Chama a lógica de pareamento Bluetooth ao clicar no botão dentro do FrotaConfigCard
                          _startBluetoothPairing(dialogContext);
                        },
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    side: const BorderSide(color: Colors.blue), // Linha de borda azul
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    'Configurações',
                    style: TextStyle(
                      color: Colors.blue, // Texto azul
                      fontWeight: FontWeight.bold, // Texto em negrito
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: () {
                    // Exibe o FrotaCallCard como uma modal
                    showDialog(
                      context: context,
                      barrierDismissible: false, // Desabilita cliques fora da modal
                      builder: (dialogContext) => FrotaCallCard(
                        onSend: () {
                          // Lógica para enviar os dados ao backend
                          print('Chamado enviado ao backend!');
                          Navigator.of(dialogContext).pop(); // Fecha a modal após enviar
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Chamado enviado com sucesso!')),
                          );
                        },
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    'Abrir chamado',
                    style: TextStyle(
                      color: Colors.white, // Texto branco
                      fontWeight: FontWeight.bold, // Texto em negrito
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
