import 'dart:async';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:frotalog_gestor_v2/app/features/detail%20screen/presenter/bloc/details_screen_state.dart';
import 'package:frotalog_gestor_v2/app/shared/globals/permission_menager_bluetooth.dart';
import 'package:frotalog_gestor_v2/app/shared/log_utils.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../utils/ecubit.dart'; // Import necessário para StreamSubscription

class DetailsScreenController extends ECubit<DetailsScreenState> {
  StreamSubscription? _scanSubscription;
  bool _isScanning = false;
  final List<BluetoothDevice> _devices = [];
  // Variável para controlar o estado de escaneamento

  DetailsScreenController() : super(DetailsScreenInitialState(devices: [], message: '')) {
    emit(DetailsScreenSuccessState(devices: state.devices, message: state.message));
  }

  Future<bool> startBluetoothPairing() async {
    emit(DetailsScreenLoading(devices: state.devices, message: 'Iniciando pareamento Bluetooth...'));
    infoLog('Iniciando pareamento Bluetooth...');

    if (_isScanning) {
      emit(DetailsScreenLoading(
          devices: state.devices, message: 'Ja esta em andamento um escaneamento de dispositivos.'));
      return true;
    }

    bool permissionsGranted = await PermissionManagerBluetooth().requestPermissions();
    if (!permissionsGranted) {
      emit(DetailsScreenErrorState(devices: state.devices, message: 'Permissões necessárias não foram concedidas.'));
      return false;
    }

    try {
      _isScanning = true;
      _devices.clear();

      emit(DetailsScreenLoading(devices: state.devices, message: 'Verificando o estado do Bluetooth...'));

      // Verifica se o Bluetooth está ligado
      bool isOn = await FlutterBluePlus.adapterState.first == BluetoothAdapterState.on;
      if (!isOn) {
        emit(DetailsScreenErrorState(
            devices: state.devices, message: 'Bluetooth está desligado. Por favor, ligue o Bluetooth.'));
        _isScanning = false; // Libera o estado de escaneamento
        return false;
      }

      // Inicia o escaneamento de dispositivos
      emit(DetailsScreenLoading(devices: state.devices, message: 'Escaneando dispositivos...'));
      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));

      // Escuta os dispositivos encontrados
      _scanSubscription = FlutterBluePlus.scanResults.listen((results) {
        for (ScanResult r in results) {
          final deviceName = r.device.platformName.isNotEmpty ? r.device.platformName : 'Dispositivo sem nome';
          print('Dispositivo encontrado: $deviceName (${r.device.remoteId})');
          if (!_devices.contains(r.device)) {
            _devices.add(r.device);
          }
          emit(DetailsScreenSuccessState(message: 'Dispositos encontrados', devices: _devices));
        }
      });

      // Para o escaneamento após 5 segundos
      await Future.delayed(const Duration(seconds: 5));
      FlutterBluePlus.stopScan();

      emit(DetailsScreenSuccessState(
          devices: state.devices, message: 'Pareamento concluído com sucesso! Dispositivos encontrados.'));
      return true;
    } catch (e) {
      emit(DetailsScreenErrorState(devices: state.devices, message: 'Erro ao parear: $e'));
      return false;
    } finally {
      _scanSubscription?.cancel(); // Cancela o listener
      _isScanning = false;
      // Libera o estado de escaneamento
    }
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    try {
      infoLog('Conectando ao dispositivo: ${device.platformName}');
      await device.connect(); // Realiza a conexão com o dispositivo
      emit(DetailsScreenSuccessState(
          devices: state.devices, message: 'Conectado ao dispositivo: ${device.platformName}'));
    } catch (e) {
      emit(DetailsScreenErrorState(devices: state.devices, message: 'Erro ao conectar: $e'));
    }
  }

  @override
  Future<void> close() {
    _scanSubscription?.cancel(); // Cancela o listener ao fechar o controller
    return super.close();
  }
}
