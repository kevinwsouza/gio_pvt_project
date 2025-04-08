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

  DetailsScreenController() : super(DetailsScreenInitialState());

  Future<bool> startBluetoothPairing() async {
  emit(DetailsScreenLoading());
  infoLog('Iniciando pareamento Bluetooth...');

  if (_isScanning) {
    emit(DetailsScreenLoading(message: 'Já está em andamento um escaneamento de dispositivos.'));
    return true;
  }

  bool permissionsGranted = await PermissionManagerBluetooth().requestPermissions();
  if (!permissionsGranted) {
    emit(DetailsScreenErrorState(message: 'Permissões não concedidas.'));
    return false;
  }

  try {
    _isScanning = true;
    _devices.clear();

    emit(DetailsScreenLoading(message: 'Verificando o estado do Bluetooth...'));

    // Verifica se o Bluetooth está ligado
    bool isOn = await FlutterBluePlus.adapterState.first == BluetoothAdapterState.on;
    if (!isOn) {
      emit(DetailsScreenErrorState(message: 'Bluetooth está desligado. Por favor, ligue o Bluetooth.'));
      _isScanning = false; // Libera o estado de escaneamento
      return false;
    }

    // Inicia o escaneamento de dispositivos
    emit(DetailsScreenLoading(message: 'Escaneando dispositivos...'));
    FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));

    // Escuta os dispositivos encontrados
    _scanSubscription = FlutterBluePlus.scanResults.listen((results) {
      for (ScanResult r in results) {
        final deviceName = r.device.platformName.isNotEmpty ? r.device.platformName : 'Dispositivo sem nome';
        print('Dispositivo encontrado: $deviceName (${r.device.remoteId})');
        if (!_devices.contains(r.device)) {
          _devices.add(r.device);
        }
      }
    });

    // Para o escaneamento após 5 segundos
    await Future.delayed(const Duration(seconds: 5));
    FlutterBluePlus.stopScan();

    // Verifica se dispositivos foram encontrados
    if (_devices.isNotEmpty) {
      emit(DetailsScreenSuccessState(
        message: 'Pareamento concluído com sucesso! Dispositivos encontrados.',
        devices: _devices,
      ));
    } else {
      emit(DetailsScreenErrorState(message: 'Nenhum dispositivo encontrado.'));
    }

    return true;
  } catch (e) {
    emit(DetailsScreenErrorState(message: 'Erro ao parear: $e'));
    return false;
  } finally {
    _scanSubscription?.cancel(); // Cancela o listener
    _isScanning = false;
  }
}

  Future<void> connectToDevice(BluetoothDevice device) async {
  try {
    // Emite o estado de carregamento
    emit(DetailsScreenLoading(message: 'Conectando ao dispositivo...'));

    infoLog('Conectando ao dispositivo: ${device.platformName}');
    await device.connect(); // Realiza a conexão com o dispositivo

    // Emite o estado de sucesso após a conexão
    emit(DetailsScreenSuccessState(
      message: 'Conectado ao dispositivo: ${device.platformName}',
      devices: _devices,
    ));
  } catch (e) {
    // Emite o estado de erro em caso de falha
    emit(DetailsScreenErrorState(
      message: 'Erro ao conectar: $e',
    ));
  }
}

  @override
  Future<void> close() {
    _scanSubscription?.cancel(); // Cancela o listener ao fechar o controller
    return super.close();
  }
}
