// ignore_for_file: file_names, library_private_types_in_public_api, sort_child_properties_last, unused_import, duplicate_ignore
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Data/firebase_options.dart';
// ignore: unused_import
import 'package:flutter_application_1/Features/inicio_sesion.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/Features/tarifas.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_application_1/Features/SlideUpMenuContent.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_application_1/Data/Markers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ParkingApp());
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  late LatLng _currentPosition;

  final String _mapStyle = '''
    [
      {
        "featureType": "poi.attraction",
        "stylers": [
          {
            "visibility": "off"
          }
        ]
      },
      {
        "featureType": "poi.business",
        "stylers": [
          {
            "visibility": "off"
          }
        ]
      },
      {
        "featureType": "poi.government",
        "stylers": [
          {
            "visibility": "off"
          }
        ]
      },
      {
        "featureType": "poi.medical",
        "stylers": [
          {
            "visibility": "off"
          }
        ]
      },
      {
        "featureType": "poi.park",
        "elementType": "labels.icon",
        "stylers": [
          {
            "visibility": "off"
          }
        ]
      },
      {
        "featureType": "poi.place_of_worship",
        "stylers": [
          {
            "visibility": "off"
          }
        ]
      },
      {
        "featureType": "poi.school",
        "stylers": [
          {
            "visibility": "off"
          }
        ]
      },
      {
        "featureType": "poi.sports_complex",
        "stylers": [
          {
            "visibility": "off"
          }
        ]
      },
      {
        "featureType": "transit",
        "stylers": [
          {
            "visibility": "off"
          }
        ]
      }
    ]
  ''';

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController.setMapStyle(_mapStyle);
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
        actions: [
          (FirebaseAuth.instance.currentUser == null)
              ? IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const LoginPage(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.person))
              : IconButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    setState(() {});
                  },
                  icon: const Icon(Icons.logout))
        ],
        title: const Text('Parking Finder'),
        backgroundColor: const Color.fromARGB(255, 2, 120, 174),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 2, 120, 174),
              ),
              child: Text(
                'Menú',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Opción 1'),
              onTap: () {
                // Acción al seleccionar la opción 1
              },
            ),
            ListTile(
              title: const Text('Tarifas'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HelpCenterPage()));
              },
            ),
            // Agrega más opciones de menú según tus necesidades
          ],
        ),
      ),
      body: SlidingUpPanel(
        onPanelSlide: (position) {},
        panel: const SlideUpMenuContent(), // Contenido del menú deslizante
        body: GoogleMap(
          padding: const EdgeInsets.only(bottom: 200),
          onMapCreated: _onMapCreated,
          initialCameraPosition: const CameraPosition(
            target: LatLng(0, 0), // posición inicial arbitraria
            zoom: 15.0,
          ),
          myLocationEnabled: true,
          markers: Set<Marker>.from(customMarkers),
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
        minHeight: 100.0, // Altura mínima del panel
        maxHeight: 1000.0, // Altura máxima del panel
      ),
    );
  }
}