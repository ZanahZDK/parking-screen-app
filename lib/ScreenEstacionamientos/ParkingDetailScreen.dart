// ignore_for_file: override_on_non_overriding_member, library_private_types_in_public_api, prefer_final_fields, avoid_print, file_names
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ParkingDetailScreen extends StatefulWidget {
  final int parkingLotId;
  final List<String> floors;

  const ParkingDetailScreen(
      {Key? key,
      required this.parkingLotId,
      this.floors = const ['Nivel 1', 'Nivel 2', 'Nivel 3']})
      : super(key: key);

  @override
  _ParkingDetailScreenState createState() => _ParkingDetailScreenState();
}

class _ParkingDetailScreenState extends State<ParkingDetailScreen> {
  String parkingLotName = "Cargando...";
  List<dynamic> parkingSpaces = [];
  String selectedFloor = 'Nivel 1';
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    loadParkingLotName(widget.parkingLotId);
    loadParkingSpaces('Nivel 1', widget.parkingLotId);
    _startAutoRefresh();
  }

  void _startAutoRefresh() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (mounted) {
        loadParkingSpaces(selectedFloor, widget.parkingLotId);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  loadParkingLotName(int parkingLotId) async {
    try {
      final response = await http.get(
          Uri.parse('http://16.170.227.32:8080/parking_lot/$parkingLotId'));
      if (response.statusCode == 200) {
        var parkingLot = json.decode(response.body);
        if (mounted) {
          setState(() {
            parkingLotName = parkingLot['name'];
          });
        }
      } else {
        print('Error al cargar el estacionamiento: ${response.statusCode}');
      }
    } catch (e) {
      print('Error al realizar la solicitud: $e');
    }
  }

  loadParkingSpaces(String floor, int parkingLotId) async {
    try {
      final response = await http.get(Uri.parse(
          'http://16.170.227.32:8080/parking_space/byFloorAndParkingLot/$floor/$parkingLotId'));
      if (response.statusCode == 200) {
        var spaces = json.decode(response.body) as List;
        spaces.sort((a, b) =>
            (a['ubication'] as String).compareTo(b['ubication'] as String));
        if (mounted) {
          setState(() {
            parkingSpaces = spaces;
            selectedFloor = floor;
          });
        }
      } else {
        print(
            'Error al cargar espacios de estacionamiento: ${response.statusCode}');
      }
    } catch (e) {
      print('Error al realizar la solicitud: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Parking Finder')),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.center,
            child: Text(
              parkingLotName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 1.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: widget.floors
                  .map((floor) => Padding(
                        padding: const EdgeInsets.only(bottom: 50.0),
                        child: floorButton(floor, widget.parkingLotId),
                      ))
                  .toList(),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 0.65,
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
