// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_application_1/MapScreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(const ParkingApp());

class ParkingApp extends StatelessWidget {
  const ParkingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parking App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MapScreen(),
    );
  }
}

class ParkingSpacesScreen extends StatefulWidget {
  const ParkingSpacesScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ParkingSpacesScreenState createState() => _ParkingSpacesScreenState();
}

class _ParkingSpacesScreenState extends State<ParkingSpacesScreen> {
  List<dynamic> parkingSpaces = [];
  String selectedFloor = 'Nivel 1';

  @override
  void initState() {
    super.initState();
    loadParkingSpaces('Nivel 1', 1);
  }

  loadParkingSpaces(String floor, int parkingLotId) async {
    final response = await http.get(Uri.parse(
        'http://10.0.2.2:8080/parking_space/byFloorAndParkingLot/$floor/$parkingLotId'));
    if (response.statusCode == 200) {
      var spaces = json.decode(response.body) as List;

      // Ordenar los estacionamientos por 'ubication' en orden ascendente
      spaces.sort((a, b) =>
          (a['ubication'] as String).compareTo(b['ubication'] as String));

      setState(() {
        parkingSpaces = spaces;
      });
    }
    setState(() {
      selectedFloor = floor; // Actualiza el piso seleccionado
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Parking Spaces')),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              floorButton('Nivel 1', 1),
              floorButton('Nivel 2', 1),
              floorButton('Nivel 3', 1),
            ],
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
              ),
              itemCount: parkingSpaces.length,
              itemBuilder: (context, index) {
                final space = parkingSpaces[index];
                return Container(
                  margin: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: space['available']
                        ? const Color.fromARGB(255, 32, 140, 255)
                        : const Color.fromARGB(255, 185, 186, 187),
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(space['ubication'],
                        style: const TextStyle(color: Colors.white)),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  //CAMBIAR DE COLOR EL BOTON SEGUN ESTADO

  Widget floorButton(String floor, int parkingLotId) {
    return ElevatedButton(
      onPressed: () => loadParkingSpaces(floor, parkingLotId),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            return floor == selectedFloor ? Colors.blue : Colors.grey;
          },
        ),
      ),
      child: Text(floor),
    );
  }
}
