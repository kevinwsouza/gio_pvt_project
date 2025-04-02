class VehicleModel {
  final String title;
  final String status;
  final String address;
  final String lastCommunication;
  final int odometer; // Hodômetro
  final int horimeter; // Horímetro
  final int rpm; // RPM

  VehicleModel({
    required this.title,
    required this.status,
    required this.address,
    required this.lastCommunication,
    required this.odometer,
    required this.horimeter,
    required this.rpm,
  });

  factory VehicleModel.initial() => VehicleModel(
        title: '',
        status: '',
        address: '',
        lastCommunication: '',
        odometer: 1,
        horimeter: 1,
        rpm: 1,
      );
}
