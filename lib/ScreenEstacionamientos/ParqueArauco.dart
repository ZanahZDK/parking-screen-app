// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ParqueAraucoScreen extends StatefulWidget {
  const ParqueAraucoScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ParqueAraucoScreenState createState() => _ParqueAraucoScreenState();
}

class _ParqueAraucoScreenState extends State<ParqueAraucoScreen> {
  List<dynamic> parkingSpaces = [];
  String selectedFloor = 'Nivel 1';

  String parkingLotName =
      "Cargando nombre..."; // Variable para almacenar el nombre del estacionamiento

  // Método para cargar el nombre del estacionamiento
  loadParkingLotName(int parkingLotId) async {
    final response = await http
        .get(Uri.parse('http://10.0.2.2:8080/parking_lot/$parkingLotId'));
    if (response.statusCode == 200) {
      var parkingLot = json.decode(response.body);
      setState(() {
        parkingLotName = parkingLot[
            'name']; // Asumiendo que tu respuesta tiene una clave 'name'
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadParkingSpaces('Nivel 1', 2);
    loadParkingLotName(2);
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
      appBar: AppBar(title: const Text('Parking Finder')),
      body: Column(
        children: [
          // TEXTO CON NOMBRE DEL ESTACIONAMIENTO
          Container(
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.center,
            child: Text(
              parkingLotName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),

          // BOTONES QUE PERMITEN NAVEGAR ENTRE LOS PISOS DEL ESTACIONAMIENTO
          Padding(
            // METEMOS "ROW" DENTRO DEL PADDING PARA DARLE ESPACIO ENTRE EL TEXTO Y LOS BOTONES
            padding: const EdgeInsets.only(
                top: 1.0), // AJUSTO EL ESPACIO ENTRE EL TEXTO Y LOS BOTONES
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 50.0), // Ajusta el padding como desees
                  child: floorButton('Nivel 1', 2),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 50.0), // Ajusta el padding como desees
                  child: floorButton('Nivel 2', 2),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 50.0), // Ajusta el padding como desees
                  child: floorButton('Nivel 3', 2),
                ),
              ],
            ),
          ),

          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5, // Ajusta el número de elementos horizontales
                childAspectRatio: 0.65, // Ajusta la proporción de los elementos
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