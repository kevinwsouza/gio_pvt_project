import 'package:flutter_blue_plus/flutter_blue_plus.dart';

sealed class DetailsScreenState {
  final List<BluetoothDevice>? devices; // Lista de dispositivos encontrada (opcional)

  DetailsScreenState({this.devices});
}

final class DetailsScreenInitialState extends DetailsScreenState {}

final class DetailsScreenLoading extends DetailsScreenState {
  final String? message;
  DetailsScreenLoading({this.message, super.devices}); // Usa super parameter para 'devices'
}

final class DetailsScreenErrorState extends DetailsScreenState {
  final String message;
  DetailsScreenErrorState({required this.message, super.devices}); // Usa super parameter para 'devices'
}

final class DetailsScreenSuccessState extends DetailsScreenState {
  final String message;
  DetailsScreenSuccessState({required this.message, super.devices}); // Usa super parameter para 'devices'
}