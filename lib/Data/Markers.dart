// ignore_for_file: file_names, library_private_types_in_public_api
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<List<Marker>> fetchMarkers() async {
  final response =
      await http.get(Uri.parse('http://16.170.227.32:8080/parking_lot'));

  if (response.statusCode == 200) {
    List<dynamic> parkingLotsJson = json.decode(response.body);
    return parkingLotsJson
        .map((json) => Marker(
              markerId: MarkerId(json['id'].toString()),
              position: LatLng(json['latitud'], json['longitud']),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueBlue),
              infoWindow: InfoWindow(title: json['name']),
            ))
        .toList();
  } else {
    throw Exception('No se pudieron cargar los estacionamientos desde la API');
  }
}
