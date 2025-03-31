import 'package:frotalog_gestor_v2/app/shared/mocks/vehicle_model.dart';

class VehicleService {
  // Simula a chamada da API para obter os veículos
  Future<List<Vehicle>> fetchVehicles() async {
    // Simula um atraso para imitar uma chamada de API
    await Future.delayed(const Duration(seconds: 1));

    // Dados mockados
    return [
      Vehicle(
        title: 'MBB121 / IZFOA08',
        status: 'Em movimento, 45 km/h',
        address: 'Rua João Moreira Maciel, Bairro Humaitá, Porto Alegre - RS',
        lastCommunication: 'há 1 min',
        odometer: 123456, // Hodômetro em km
        horimeter: 8940, // Horímetro em horas
        rpm: 3000, // RPM
      ),
      Vehicle(
        title: 'ABC123 / XYZ987',
        status: 'Parado',
        address: 'Rua das Flores, Bairro Centro, São Paulo - SP',
        lastCommunication: 'há 5 min',
        odometer: 98765,
        horimeter: 4500,
        rpm: 0,
      ),
      Vehicle(
        title: 'DEF456 / LMN654',
        status: 'Em manutenção',
        address: 'Av. Brasil, Bairro Industrial, Curitiba - PR',
        lastCommunication: 'há 10 min',
        odometer: 45678,
        horimeter: 3200,
        rpm: 0,
      ),
      Vehicle(
        title: 'GHI789 / OPQ321',
        status: 'Em movimento, 80 km/h',
        address: 'Rua XV de Novembro, Bairro Centro, Florianópolis - SC',
        lastCommunication: 'há 2 min',
        odometer: 234567,
        horimeter: 12000,
        rpm: 2500,
      ),
      Vehicle(
        title: 'JKL012 / RST890',
        status: 'Parado',
        address: 'Rua das Palmeiras, Bairro Jardim, Belo Horizonte - MG',
        lastCommunication: 'há 20 min',
        odometer: 34567,
        horimeter: 1500,
        rpm: 0,
      ),
      Vehicle(
        title: 'MNO345 / UVW678',
        status: 'Em movimento, 50 km/h',
        address: 'Av. Paulista, Bairro Bela Vista, São Paulo - SP',
        lastCommunication: 'há 3 min',
        odometer: 56789,
        horimeter: 6000,
        rpm: 2000,
      ),
    ];
  }
}