import 'package:flutter/material.dart';

class FrotaCardDetails extends StatelessWidget {
  final String title;
  final String status;
  final String driver;
  final String address;
  final String lastCommunication;
  final String odometer;
  final String horimeter;
  final String rpm;

  const FrotaCardDetails({
    super.key,
    required this.title,
    required this.status,
    required this.driver,
    required this.address,
    required this.lastCommunication,
    required this.odometer,
    required this.horimeter,
    required this.rpm,
  });

  @override
  Widget build(BuildContext context) {
    // Dividir o endereço em duas linhas
    final addressParts = address.split(','); // Divide o endereço pelo separador ","

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      color: const Color(0xFFE9EEEE),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.local_shipping, size: 32.0, color: Colors.blue),
                const SizedBox(width: 8.0),
                Text(
                  title,
                  style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            const Divider(
              color: Colors.black26,
              thickness: 1.0,
            ),
            const SizedBox(height: 8.0),
            Text(
              status,
              style: const TextStyle(fontSize: 16.0, color: Colors.black),
            ),
            const SizedBox(height: 16.0),
            Text(
              driver,
              style: const TextStyle(fontSize: 16.0, color: Colors.black),
            ),
            const SizedBox(height: 16.0),
            // Exibir o endereço dividido em duas linhas
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  addressParts[0].trim(), // Primeira parte do endereço
                  style: const TextStyle(fontSize: 14.0, color: Colors.black),
                ),
                if (addressParts.length > 1)
                  Text(
                    addressParts.sublist(1).join(',').trim(), // Resto do endereço
                    style: const TextStyle(fontSize: 14.0, color: Colors.black),
                  ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Text(
                  'Última comunicação ',
                  style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal, color: Colors.black),
                ),
                Text(
                  lastCommunication,
                  style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.speed, size: 24.0, color: Colors.blue),
                    const SizedBox(width: 8.0),
                    const Text(
                      'Hodômetro:',
                      style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 32.0),
                  child: Text(
                    odometer,
                    style: const TextStyle(fontSize: 14.0, color: Colors.black),
                  ),
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Icon(Icons.timer, size: 24.0, color: Colors.blue),
                    const SizedBox(width: 8.0),
                    const Text(
                      'Horímetro:',
                      style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 32.0),
                  child: Text(
                    horimeter,
                    style: const TextStyle(fontSize: 14.0, color: Colors.black),
                  ),
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Icon(Icons.settings, size: 24.0, color: Colors.blue),
                    const SizedBox(width: 8.0),
                    const Text(
                      'RPM:',
                      style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 32.0),
                  child: Text(
                    rpm,
                    style: const TextStyle(fontSize: 14.0, color: Colors.black),
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