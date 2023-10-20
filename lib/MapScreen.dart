// ignore_for_file: file_names, library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// Define la clase CustomMarker
class CustomMarker {
  final LatLng location;
  final String name;
  final BitmapDescriptor icon;

  CustomMarker({
    required this.location,
    required this.name,
    required this.icon,
  });
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  late LatLng _currentPosition;

  // DEFINO LA LISTA QUE CONTENDRA TODOS MIS MARCADORES PERSONALIZADOS
  List<Marker> customMarkers = [
    Marker(
      markerId: const MarkerId("1"),
      position: const LatLng(-33.41679534637822, -70.60473570944188),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow: const InfoWindow(
        title: "Estacionamiento Costanera Center",
      ),
    ),
    Marker(
      markerId: const MarkerId("2"),
      position: const LatLng(-33.404522426319375, -70.57564364545044),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow: const InfoWindow(
        title: "Estacionamiento Parque Arauco",
      ),
    ),
    // AGREGAR MAS CENTROS COMERCIALES
  ];

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _locateUser();
  }

  Future<void> _locateUser() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
    });
    mapController.moveCamera(CameraUpdate.newLatLng(_currentPosition));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa'),
        backgroundColor: Colors.green[700],
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: const CameraPosition(
          target: LatLng(0, 0), // posición inicial arbitraria
          zoom: 11.0,
        ),
        myLocationEnabled: true,
        markers: Set<Marker>.from(customMarkers),
      ),
    );
  }
}
