// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class TarifasPage extends StatefulWidget {
  const TarifasPage({super.key});

  @override
  TarifasPageState createState() => TarifasPageState();
}

class TarifasPageState extends State<TarifasPage> {
  final TextEditingController _horasController = TextEditingController();
  List<dynamic> parkingLots = [];
  String? selectedParkingLot;
  double hourlyRate = 0; // Asumiendo que obtendrás esto de tu API

  @override
  void initState() {
    super.initState();
    loadParkingLots();
  }

  void loadHourlyRate(String parkingLotId) async {
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8080/parking_lot/$parkingLotId/minutePrice'),
      );

      if (response.statusCode == 200) {
        if (mounted) {
          setState(() {
            hourlyRate = double.parse(response.body);
          });
        }
      } else {
        // Manejar error cuando el statusCode no es 200
        showError(
            'Error al cargar la tarifa. Código de estado: ${response.statusCode}');
      }
    } catch (e) {
      // Manejar otros errores, como problemas de red
      showError('Ocurrió un error al cargar la tarifa: $e');
    }
  }

  Future<void> loadParkingLots() async {
    try {
      final response =
          await http.get(Uri.parse('http://10.0.2.2:8080/parking_lot'));

      if (response.statusCode == 200) {
        if (mounted) {
          // Verifica si el estado todavía está montado
          setState(() {
            parkingLots = json.decode(response.body);
          });
        }
      } else {
        // Manejar error cuando el statusCode no es 200
        showError(
            'Error al cargar los datos. Código de estado: ${response.statusCode}');
      }
    } catch (e) {
      // Manejar otros errores, como problemas de red
      showError('Ocurrió un error al cargar los datos: $e');
    }
  }

  void calculateFee() {
    String hoursText = _horasController.text;

    if (hoursText.isEmpty) {
      showError('Por favor, ingrese un número de minutos.');
      return;
    }

    try {
      int hours = int.parse(hoursText);
      double totalFee = hours * hourlyRate;

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Tarifa Calculada'),
            content: Text('La tarifa total es de: CLP \$${totalFee.toInt()}'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cerrar'),
              ),
            ],
          );
        },
      );
    } on FormatException {
      showError('Por favor, ingrese un número de horas válido.');
    } catch (e) {
      showError('Por favor, ingrese un número de horas válido.');
    }
  }

  void showError(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 2, 120, 174),
          title: const Text('Tarifas de Estacionamiento'),
        ),
        body: Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 2, 120, 174),
            ),
            child: Stack(children: <Widget>[
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/god.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Center(
                // Centrar la Card en la pantalla
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(
                          20.0), // Ajustar el padding según sea necesario
                      child: Column(
                        mainAxisSize: MainAxisSize.min, // Ajustar al contenido
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DropdownButton<String>(
                            items: parkingLots.map((lot) {
                              return DropdownMenuItem<String>(
                                value: lot['id'].toString(),
                                child: Text(lot['name']),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedParkingLot = newValue;
                                if (newValue != null) {
                                  loadHourlyRate(newValue);
                                }
                              });
                            },
                            hint: const Text('Selecciona un estacionamiento'),
                            value: selectedParkingLot,
                          ),
                          TextField(
                            controller: _horasController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Minutos',
                              hintText: 'Ingrese la cantidad de minutos',
                            ),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter
                                  .digitsOnly // Aceptar solo dígitos
                            ],
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: calculateFee,
                            child: const Text(
                              'Calcular Tarifa',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ])));
  }
}
