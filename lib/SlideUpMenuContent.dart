// ignore_for_file: file_names, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geodesy/geodesy.dart' as geodesy; // Alias para Geodesy
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart' as latlng2; // Alias para latlong2

import 'package:flutter_application_1/ParqueArauco.dart';
import 'package:flutter_application_1/main.dart';

void _navigateToParkingDetail(BuildContext context, int parkingId) {
  switch (parkingId) {
    case 1:
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const ParkingSpacesScreen()));
      break;
    case 2:
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const ParqueAraucoScreen()));
      break;
    // Puedes agregar más casos aquí para otros estacionamientos
  }
}

class SlideUpMenuContent extends StatelessWidget {
  const SlideUpMenuContent({super.key});

  Future<bool> isWithinDistance(
      LatLng parkingLocation, double distanceInMeters) async {
    geodesy.Geodesy geo = geodesy.Geodesy();

    Position userPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    latlng2.LatLng userLocation =
        latlng2.LatLng(userPosition.latitude, userPosition.longitude);

    num distanceNum = geo.distanceBetweenTwoGeoPoints(
        latlng2.LatLng(userLocation.latitude, userLocation.longitude),
        latlng2.LatLng(parkingLocation.latitude, parkingLocation.longitude));

    return distanceNum <= distanceInMeters;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: Container(
              width: MediaQuery.sizeOf(context).width,
              height: 50,
              alignment: AlignmentDirectional.center,
              padding: const EdgeInsets.all(16.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: parkings.length,
              itemBuilder: (BuildContext context, int index) {
                return FutureBuilder<bool>(
                  future: isWithinDistance(parkings[index].location, 100),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator(); // Muestra un indicador de carga mientras se obtiene la ubicación
                    } else if (snapshot.hasData && snapshot.data!) {
                      return MenuCard(parkings[index],
                          context); // Muestra la tarjeta si está dentro de la distancia
                    } else {
                      return const SizedBox
                          .shrink(); // No muestra nada si está fuera de la distancia
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Parking {
  final int id;
  final LatLng location;
  final String name;
  final String ubication;
  final int totalSpaces;

  Parking({
    required this.id,
    required this.location,
    required this.name,
    required this.ubication,
    required this.totalSpaces,
  });
}

List<Parking> parkings = [
  Parking(
    id: 1,
    location: const LatLng(-33.41679534637822, -70.60473570944188),
    name: "Estacionamiento Costanera Center",
    ubication: "Providencia",
    totalSpaces: 75,
  ),

  Parking(
    id: 2,
    location: const LatLng(-33.404522426319375, -70.57564364545044),
    name: "Estacionamiento Parque Arauco",
    ubication: "Las Condes",
    totalSpaces: 75,
  ),
  // ... (otros estacionamientos)
];

Widget MenuCard(Parking parking, BuildContext context) {
  return Card(
    color: const Color(0xFFD4D8D9),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              parking.name, // Aquí se usa la variable
              style: const TextStyle(
                  color: Colors.redAccent,
                  fontSize: 20,
                  fontWeight: FontWeight.w800),
            ),
          ),
          Row(
            children: [
              const Icon(Icons.pin_drop),
              Text(parking.ubication) // Aquí se usa la variable
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.directions_car),
              Text('${parking.totalSpaces}') // Aquí se usa la variable
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () => _navigateToParkingDetail(context, parking.id),
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2B2D42)),
                child: const Text(
                  "Ver Información",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ],
      ),
    ),
  );
}
