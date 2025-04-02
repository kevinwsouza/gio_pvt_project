import 'dart:async';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:frotalog_gestor_v2/app/features/detail%20screen/presenter/bloc/details_screen_state.dart';
import '../../../../utils/ecubit.dart'; // Import necessário para StreamSubscription

class DetailsScreenController extends ECubit<DetailsScreenState> {
  StreamSubscription? _scanSubscription;
  bool _isScanning = false; // Variável para controlar o estado de escaneamento

  //construtor coloca dessa forma na controller
  DetailsScreenController() : super(DetailsScreenInitialState());

  Future<void> startBluetoothPairing() async {
    if (_isScanning) {
      emit(DetailsScreenErrorState(message: 'Já está em andamento um escaneamento de dispositivos.'));
      return;
    }

    _isScanning = true; // Marca como escaneando
    emit(DetailsScreenLoading()); // Emite estado de carregamento

    try {
      // Verifica se o Bluetooth está ligado
      bool isOn = await FlutterBluePlus.adapterState.first == BluetoothAdapterState.on;
      if (!isOn) {
        emit(DetailsScreenErrorState(message: 'Bluetooth está desligado. Por favor, ligue o Bluetooth.'));
        _isScanning = false; // Libera o estado de escaneamento
        return;
      }

      // Inicia o escaneamento de dispositivos
      emit(DetailsScreenLoading(message: 'Escaneando dispositivos...'));
      FlutterBluePlus.startScan(timeout: const Duration(seconds: 5)); // Corrigido: chamado como método estático

      // Escuta os dispositivos encontrados
      _scanSubscription = FlutterBluePlus.scanResults.listen((results) {
        for (ScanResult r in results) {
          final deviceName = r.device.platformName.isNotEmpty ? r.device.platformName : 'Dispositivo sem nome';
          print('Dispositivo encontrado: $deviceName (${r.device.remoteId})');
        }
      });

      // Para o escaneamento após 5 segundos
      await Future.delayed(const Duration(seconds: 5));
      FlutterBluePlus.stopScan(); // Corrigido: chamado como método estático

      emit(DetailsScreenSuccessState(message: 'Pareamento concluído com sucesso! Dispositivos encontrados.'));
    } catch (e) {
      emit(DetailsScreenErrorState(message: 'Erro ao parear: $e'));
    } finally {
      _scanSubscription?.cancel(); // Cancela o listener
      _isScanning = false; // Libera o estado de escaneamento
    }
  }

  @override
  Future<void> close() {
    _scanSubscription?.cancel(); // Cancela o listener ao fechar o controller
    return super.close();
  }
}
