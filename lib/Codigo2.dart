// ignore_for_file: file_names
import 'dart:convert' show json;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Esta es la función que realiza la llamada HTTP
Future<List<dynamic>> fetchParkingSpaces(String floor) async {
  final response = await http
      .get(Uri.parse('http://10.0.2.2:8080/parking_space/byFloor/$floor'));

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load parking spaces');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parking Spaces'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              ElevatedButton(
                onPressed: () async {
                  parkingSpaces = await fetchParkingSpaces('Nivel 1');
                  setState(() {});
                },
                child: const Text('Nivel 1'),
              ),
              ElevatedButton(
                onPressed: () async {
                  parkingSpaces = await fetchParkingSpaces('Nivel 2');
                  setState(() {});
                },
                child: const Text('Nivel 2'),
              ),
              ElevatedButton(
                onPressed: () async {
                  parkingSpaces = await fetchParkingSpaces('Nivel 3');
                  setState(() {});
                },
                child: const Text('Nivel 3'),
              ),
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
                  margin: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: space['available'] ? Colors.green : Colors.red,
                    border: Border.all(color: Colors.black),
                  ),
                  child: Center(
                    child: Text(
                      space['ubication'],
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
