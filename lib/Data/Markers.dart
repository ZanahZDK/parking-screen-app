// ignore_for_file: file_names

import 'package:google_maps_flutter/google_maps_flutter.dart';

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
    Marker(
      markerId: const MarkerId("3"),
      position: const LatLng(-33.51052431719239, -70.60623010121134),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow: const InfoWindow(
        title: "Estacionamiento Florida Center",
      ),
    ),
    Marker(
      markerId: const MarkerId("4"),
      position: const LatLng(-33.51909630360077, -70.59913630305729),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow: const InfoWindow(
        title: "Estacionamiento MallPlaza Vespucio",
      ),
    ),
    Marker(
      markerId: const MarkerId("5"),
      position: const LatLng(-33.45331918521875, -70.68240819474927),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow: const InfoWindow(
        title: "Estacionamiento MallPlaza Alameda",
      ),
    ),
    Marker(
      markerId: const MarkerId("6"),
      position: const LatLng(-33.453510856050265, -70.5692061993674),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow: const InfoWindow(
        title: "Estacionamiento MallPlaza Egaña",
      ),
    ),
    Marker(
      markerId: const MarkerId("7"),
      position: const LatLng(-33.631822727459166, -70.71056100908842),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow: const InfoWindow(
        title: "Estacionamiento MallPlaza Sur",
      ),
    ),
    Marker(
      markerId: const MarkerId("8"),
      position: const LatLng(-33.48802493556529, -70.57903941763668),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow: const InfoWindow(
        title: "Estacionamiento Paseo Quilin",
      ),
    ),
    Marker(
      markerId: const MarkerId("9"),
      position: const LatLng(-33.41498513654357, -70.54061085105606),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow: const InfoWindow(
        title: "Estacionamiento MallPlaza Los Dominicos",
      ),
    ),
    Marker(
      markerId: const MarkerId("10"),
      position: const LatLng(-33.401107338700385, -70.57533525668129),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow: const InfoWindow(
        title: "Estacionamiento Open Kennedy",
      ),
    ),
    Marker(
      markerId: const MarkerId("11"),
      position: const LatLng(-33.389659851232466, -70.54672894965537),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow: const InfoWindow(
        title: "Estacionamiento Alto Las Condes",
      ),
    ),
    Marker(
      markerId: const MarkerId("12"),
      position: const LatLng(-33.35747756939537, -70.51527156635545),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow: const InfoWindow(
        title: "Estacionamiento Portal La Dehesa ",
      ),
    ),
    Marker(
      markerId: const MarkerId("13"),
      position: const LatLng(-33.42785883779931, -70.54077781435129),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow: const InfoWindow(
        title: "Estacionamiento Portal La Reina",
      ),
    ),
    Marker(
      markerId: const MarkerId("14"),
      position: const LatLng(-33.40981446818548, -70.56740533158148),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow: const InfoWindow(
        title: "Estacionamiento Apumanque",
      ),
    ),
    Marker(
      markerId: const MarkerId("15"),
      position: const LatLng(-33.42461133190757, -70.65471095162547),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow: const InfoWindow(
        title: "Estacionamiento Barrio Independencia",
      ),
    ),
    Marker(
      markerId: const MarkerId("16"),
      position: const LatLng(-33.5951796396068, -70.70659338360429),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow: const InfoWindow(
        title: "Estacionamiento Paseo San Bernardo",
      ),
    ),
    Marker(
      markerId: const MarkerId("17"),
      position: const LatLng(-33.568605042767366, -70.55739560532753),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow: const InfoWindow(
        title: "Estacionamiento MallPlaza Tobalaba",
      ),
    ),
    Marker(
      markerId: const MarkerId("18"),
      position: const LatLng(-33.596911883208854, -70.57736197206867),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow: const InfoWindow(
        title: "Estacionamiento Open Puente Alto",
      ),
    ),
    Marker(
      markerId: const MarkerId("19"),
      position: const LatLng(-33.599297921136966, -70.57578483329922),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow: const InfoWindow(
        title: "Estacionamiento Espacio Urbano Puente Alto",
      ),
    ),
    Marker(
      markerId: const MarkerId("20"),
      position: const LatLng(-33.55354641417957, -70.67700147925522),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow: const InfoWindow(
        title: "Estacionamiento Arauco El Bosque",
      ),
    ),
    Marker(
      markerId: const MarkerId("21"),
      position: const LatLng(-33.516673054956996, -70.71651881470568),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow: const InfoWindow(
        title: "Estacionamiento MallPlaza Oeste",
      ),
    ),
    Marker(
      markerId: const MarkerId("22"),
      position: const LatLng(-33.481338105655624, -70.75197996097535),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow: const InfoWindow(
        title: "Estacionamiento Mall Arauco Maipú",
      ),
    ),
    Marker(
      markerId: const MarkerId("23"),
      position: const LatLng(-33.36836056664303, -70.73003835694364),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow: const InfoWindow(
        title: "Estacionamiento Mall Arauco Quilicura",
      ),
    ),
  ];
