// ignore_for_file: file_names, non_constant_identifier_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geodesy/geodesy.dart' as geodesy; // Alias para Geodesy
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart' as latlng2; // Alias para latlong2

import 'package:flutter_application_1/ScreenEstacionamientos/ParqueArauco.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/Data/ParkingData.dart';

//FUNCION: LINKEA LOS BOTONES DE "MAS INFORMACION" A LAS PANTALLAS DE CADA CENTRO COMERCIAL DONDE SE MUESTRAN LOS ESPACIOS DISPONIBLES.
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

class SlideUpMenuContent extends StatefulWidget {
  const SlideUpMenuContent({super.key});

  @override
  _SlideUpMenuContentState createState() => _SlideUpMenuContentState();
}

class _SlideUpMenuContentState extends State<SlideUpMenuContent> {
  Position? currentPosition;

  Future<void> _refreshParkings() async {
    currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {}); // Esto actualizará la UI
  }

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
    return Column(
      children: [
        ElevatedButton(
          onPressed: _refreshParkings, // Vincula el botón con el método
          child: const Text('REFRESCAR'),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
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
                        future:
                            isWithinDistance(parkings[index].location, 1000),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasData && snapshot.data!) {
                            return MenuCard(parkings[index], context);
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  State<StatefulWidget> createState() {
    throw UnimplementedError();
  }
}

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
              parking
                  .name, // LE DAMOS EL VALOR DE "NAME" PROVENIENTE DE PARKINGDATA.DART
              style: const TextStyle(
                  color: Colors.redAccent,
                  fontSize: 20,
                  fontWeight: FontWeight.w800),
            ),
          ),
          Row(
            children: [
              const Icon(Icons.pin_drop),
              Text(parking
                  .ubication) // LE DAMOS EL VALOR DE "UBICATION" PROVENIENTE DE PARKINGDATA.DART
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.directions_car),
              Text(
                  '${parking.totalSpaces}') // LE DAMOS EL VALOR DE "TOTALSPACES" PROVENIENTE DE PARKINGDATA.DART
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
