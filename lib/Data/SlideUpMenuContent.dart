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
              child: Text('Deslice Hacia Arriba',
                  style: TextStyle(color: Color(0xFF607D8B))),
              width: MediaQuery.sizeOf(context).width,
              height: 50,
              alignment: AlignmentDirectional.center,
              padding: const EdgeInsets.only(bottom: 16),
            ),
          ),
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0), // Esquinas redondeadas
      ),
      color: Color(0xFFF5F5F5),
      elevation: 5,
      margin: EdgeInsets.all(10), // Espaciado alrededor de la tarjeta
      child: Padding(
        padding: EdgeInsets.all(15), // Espaciado interno de la tarjeta
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
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.location_on, color: Colors.black),
                SizedBox(width: 5),
                Text(parking.direction, style: TextStyle(color: Colors.black)),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.directions_car, color: Colors.black),
                SizedBox(width: 5),
                Text('${parking.totalSpaces} espacios en total',
                    style: TextStyle(color: Colors.black)),
              ],
            ),
            SizedBox(height: 10),
            Divider(
              thickness: 2, // Ajusta el grosor de la línea del Divider
              color: Colors.grey, // Ajusta el color del Divider
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () => navigateToParkingDetail(context, parking.id),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 2, 120, 174),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10), // Aquí defines el radio de la curvatura
                    ),
                  ),
                  child: const Text(
                    "Ver Información",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Text(
                  '\$${parking.hourPrice}/hr',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
