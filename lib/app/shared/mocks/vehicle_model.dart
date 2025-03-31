class Vehicle {
  final String title;
  final String status;
  final String address;
  final String lastCommunication;
  final int odometer; // Hodômetro
  final double averageSpeed; // Velocidade média

  Vehicle({
    required this.title,
    required this.status,
    required this.address,
    required this.lastCommunication,
    required this.odometer,
    required this.averageSpeed,
  });
}