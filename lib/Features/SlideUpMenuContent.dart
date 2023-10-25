// ignore_for_file: file_names, non_constant_identifier_names, library_private_types_in_public_api, avoid_print, unused_element, prefer_const_constructors, sort_child_properties_last, depend_on_referenced_packages

import 'package:flutter_application_1/Data/NavigationHelper.dart';
import 'package:flutter_application_1/Data/ParkingData.dart';

//IMPORT PACKAGES

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geodesy/geodesy.dart' as geodesy; // Alias para Geodesy
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart' as latlng2; // Alias para latlong2

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
  void initState() {
    print('Ejecutando init slidemenu');
    super.initState();
    _listenPosition();
  }

  _listenPosition() async {
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    // ignore: unused_local_variable
    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position? position) {
      setState(() {});
      print(position == null
          ? 'Unknown'
          : '${position.latitude.toString()}, ${position.longitude.toString()}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 18.9,
            width: 140,
            margin: EdgeInsets.only(top: 15, bottom: 15),
            child: Padding(
                padding: EdgeInsets.only(
                  bottom: 10,
                ),
                child: ElevatedButton(
                    onPressed: () {},
                    child: null,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 2, 120, 174),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))))),
          ),
          Center(
            child: Container(
              child: Text(
                'Deslice Hacia Arriba',
                style: TextStyle(color: Colors.grey[600]),
              ),
              width: MediaQuery.sizeOf(context).width,
              height: 50,
              alignment: AlignmentDirectional.center,
              padding: const EdgeInsets.only(bottom: 16),
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
                  future: isWithinDistance(parkings[index].location, 1000),
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

Widget MenuCard(Parking parking, BuildContext context) {
  return Card(
    color: const Color(0xFFD4D8D9),
    elevation: 5,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              parking
                  .name, // LE DAMOS EL VALOR DE "NAME" PROVENIENTE DE PARKINGDATA.DART
              style: TextStyle(
                  color: Color.fromARGB(255, 2, 120, 174),
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
                onPressed: () => navigateToParkingDetail(context, parking.id),
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 2, 120, 174)),
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
