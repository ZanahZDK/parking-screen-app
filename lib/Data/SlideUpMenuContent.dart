// ignore_for_file: file_names, non_constant_identifier_names, library_private_types_in_public_api, avoid_print, unused_element, prefer_const_constructors, sort_child_properties_last, depend_on_referenced_packages, unused_local_variable

import 'package:flutter_application_1/Data/NavigationHelper.dart';
import 'package:flutter_application_1/Data/ParkingData.dart';

//IMPORT PACKAGES

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
  Future<List<Parking>>? futureParkings;
  StreamSubscription<Position>? positionStream;

  @override
  void initState() {
    super.initState();
    _refreshParkings();
    futureParkings = Parking.fetchMarkers();
    _listenPosition();
  }

  @override
  void dispose() {
    positionStream?.cancel();
    super.dispose();
  }

  Future<void> _refreshParkings() async {
    currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {}); // Esto actualizará la UI
  }

  Future<bool> isWithinDistance(
      Parking parking, double distanceInMeters) async {
    geodesy.Geodesy geo = geodesy.Geodesy();

    Position userPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    latlng2.LatLng userLocation =
        latlng2.LatLng(userPosition.latitude, userPosition.longitude);

    latlng2.LatLng parkingLocation = latlng2.LatLng(
      parking.latitud,
      parking.longitud,
    );

    num distanceNum = geo.distanceBetweenTwoGeoPoints(
      userLocation,
      parkingLocation,
    );
    return distanceNum <= distanceInMeters;
  }

  _listenPosition() async {
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
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
    return FutureBuilder<List<Parking>>(
      future: Parking
          .fetchMarkers(), // Asegúrate de que este método devuelva una lista de Parking
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          return _buildParkingList(
              context,
              snapshot
                  .data!); // Pasamos la lista de parkings al método que construye la UI
        } else {
          return Text('No se encontraron datos');
        }
      },
    );
  }

  Widget _buildParkingList(BuildContext context, List<Parking> parkings) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Tu UI aquí, como el botón y el texto 'Deslice Hacia Arriba'
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: parkings.length,
              itemBuilder: (BuildContext context, int index) {
                return FutureBuilder<bool>(
                  future: isWithinDistance(parkings[index], 1000),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasData && snapshot.data!) {
                      return MenuCard(parkings[index], context);
                    } else {
                      return SizedBox.shrink();
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.pin_drop),
                    Text(parking.direction) // Valor de "ubication"
                  ],
                ),
                Text('\$ ${parking.hourPrice} por hora') // Valor de "hourPrice"
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.directions_car),
                    Text(
                        '${parking.totalSpaces} espacios') // Valor de "totalSpaces"
                  ],
                ),
                Text(
                    '\$${parking.minutePrice} por minuto') // Valor de "minutePrice"
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
}
