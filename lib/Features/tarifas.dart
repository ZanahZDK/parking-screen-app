import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class  MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HelpCenterPage(),
    );
  }
}

class HelpCenterPage extends StatelessWidget {
  const HelpCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Centro de Ayuda'),
        backgroundColor: const Color.fromARGB(255, 2, 120, 174),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Card(
              child: ListTile(
                title: const Text('Calcular Tarifas'),
                subtitle: const Text('Información sobre tarifas y precios.'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  TarifasPage()),
                  );
                },
              ),
            ),
            // Puedes agregar más elementos de la lista para otros temas de ayuda aquí.
          ],
        ),
      ),
    );
  }
}

class TarifasPage extends StatelessWidget {
  final TextEditingController _horasController = TextEditingController();

  TarifasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarifas de Estacionamiento'),
        backgroundColor: const Color.fromARGB(255, 2, 120, 174),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tarifas de Estacionamiento',
                      style: TextStyle(fontSize: 24),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Aquí encontrarás información detallada sobre las tarifas de estacionamiento en nuestro establecimiento.',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Tarifa por hora:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'USD 2000 por hora.',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Tarifa diaria:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'USD 10.000 por día.',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Calculadora:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _horasController,
                      decoration: const InputDecoration(
                        labelText: 'Horas',
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        final horas = int.parse(_horasController.text);
                        final costoTotal = horas * 2.000;
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Resultado'),
                            content: Text('El costo total es: USD $costoTotal'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Aceptar'),
                              ),
                            ],
                          ),
                        );
                      },
                      child: const Text('Calcular'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}