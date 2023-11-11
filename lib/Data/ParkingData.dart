// ignore_for_file: file_names, library_private_types_in_public_api
import 'package:http/http.dart' as http;
import 'dart:convert';

class Parking {
  final int id;
  final String direction;
  final double latitud;
  final double longitud;
  final String name;
  final int hourPrice;
  final int minutePrice;
  final int totalSpaces;

  Parking({
    required this.id,
    required this.direction,
    required this.latitud,
    required this.longitud,
    required this.name,
    required this.hourPrice,
    required this.minutePrice,
    required this.totalSpaces,
  });

  factory Parking.fromJson(Map<String, dynamic> json) {
    return Parking(
      id: json['id'],
      direction: json['direction'],
      latitud: json['latitud'],
      longitud: json['longitud'],
      name: json['name'],
      hourPrice: json['hourPrice'],
      minutePrice: json['minutePrice'],
      totalSpaces: json['totalSpaces'],
    );
  }

  static Future<List<Parking>> fetchMarkers() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8080/parking_lot'));

    if (response.statusCode == 200) {
      List<dynamic> parkingLotsJson = json.decode(response.body);
      return parkingLotsJson
          .map((json) => Parking(
                id: json['id'],
                direction: json['direction'],
                latitud: json['latitud'],
                longitud: json['longitud'],
                name: json['name'],
                hourPrice: json['hourPrice'],
                minutePrice: json['minutePrice'],
                totalSpaces: json['totalSpaces'],
              ))
          .toList();
    } else {
      throw Exception(
          'No se pudieron cargar los estacionamientos desde la API');
    }
  }
}
