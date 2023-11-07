import 'package:flutter/material.dart';

class ParkingAppPage extends StatelessWidget {
  const ParkingAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 2, 120, 174),
        title: const Text('Información de la App de Estacionamiento'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bienvenido a nuestra App de Estacionamiento',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Características principales:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '- Notificaciones de disponibilidad de espacios',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Beneficios de usar nuestra App:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '- Ahorro de tiempo al encontrar un espacio de estacionamiento',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '- Notificaciones en tiempo real para una mejor experiencia',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
