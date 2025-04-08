import 'package:flutter_blue_plus/flutter_blue_plus.dart';

sealed class DetailsScreenState {
  final List<BluetoothDevice>? devices;
  final String? message;
  DetailsScreenState({required this.devices, required this.message});
}

final class DetailsScreenInitialState extends DetailsScreenState {
  DetailsScreenInitialState({required super.devices, required super.message});
}

final class DetailsScreenLoading extends DetailsScreenState {
  DetailsScreenLoading({required super.devices, required super.message});
}

final class DetailsScreenErrorState extends DetailsScreenState {
  DetailsScreenErrorState({required super.devices, required super.message});
}

final class DetailsScreenSuccessState extends DetailsScreenState {
  DetailsScreenSuccessState({required super.devices, required super.message});
}
