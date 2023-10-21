// ignore_for_file: file_names

import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  Parking(
    id: 3,
    location: const LatLng(-33.51052431719239, -70.60623010121134),
    name: "Estacionamiento Florida Center",
    ubication: "La Florida",
    totalSpaces: 75,
  ),
  Parking(
    id: 4,
    location: const LatLng(-33.51909630360077, -70.59913630305729),
    name: "Estacionamiento MallPlaza Vespucio",
    ubication: "La Florida",
    totalSpaces: 75,
  ),
  Parking(
    id: 5,
    location: const LatLng(-33.45331918521875, -70.68240819474927),
    name: "Estacionamiento MallPlaza Alameda",
    ubication: "Santiago",
    totalSpaces: 75,
  ),
  Parking(
    id: 6,
    location: const LatLng(-33.453510856050265, -70.5692061993674),
    name: "Estacionamiento MallPlaza Egaña",
    ubication: "La Reina",
    totalSpaces: 75,
  ),
  Parking(
    id: 7,
    location: const LatLng(-33.631822727459166, -70.71056100908842),
    name: "Estacionamiento MallPlaza Sur",
    ubication: "San Bernardo",
    totalSpaces: 75,
  ),
  Parking(
    id: 8,
    location: const LatLng(-33.48802493556529, -70.57903941763668),
    name: "Estacionamiento Paseo Quilin",
    ubication: "Peñalolen",
    totalSpaces: 75,
  ),
  Parking(
    id: 9,
    location: const LatLng(-33.41498513654357, -70.54061085105606),
    name: "Estacionamiento MallPlaza Los Dominicos",
    ubication: "Las Condes",
    totalSpaces: 75,
  ),
  Parking(
    id: 10,
    location: const LatLng(-33.401107338700385, -70.57533525668129),
    name: "Estacionamiento Mall Open Kennedy",
    ubication: "Las Condes",
    totalSpaces: 75,
  ),
  Parking(
    id: 11,
    location: const LatLng(-33.389659851232466, -70.54672894965537),
    name: "Estacionamiento Alto Las Condes",
    ubication: "Las Condes",
    totalSpaces: 75,
  ),
  Parking(
    id: 12,
    location: const LatLng(-33.35747756939537, -70.51527156635545),
    name: "Estacionamiento Portal La Dehesa ",
    ubication: "Lo Barnechea",
    totalSpaces: 75,
  ),
  Parking(
    id: 13,
    location: const LatLng(-33.42785883779931, -70.54077781435129),
    name: "Estacionamiento Portal La Reina",
    ubication: "La Reina",
    totalSpaces: 75,
  ),
  Parking(
    id: 14,
    location: const LatLng(-33.40981446818548, -70.56740533158148),
    name: "Estacionamiento Apumanque",
    ubication: "Las Condes",
    totalSpaces: 75,
  ),
  Parking(
    id: 15,
    location: const LatLng(-33.42461133190757, -70.65471095162547),
    name: "Estacionamiento Barrio Independencia",
    ubication: "Independecia",
    totalSpaces: 75,
  ),
  Parking(
    id: 16,
    location: const LatLng(-33.5951796396068, -70.70659338360429),
    name: "Estacionamiento Paseo San Bernardo",
    ubication: "San Bernardo",
    totalSpaces: 75,
  ),
  Parking(
    id: 17,
    location: const LatLng(-33.568605042767366, -70.55739560532753),
    name: "Estacionamiento MallPlaza Tobalaba",
    ubication: "Puente Alto",
    totalSpaces: 75,
  ),
  Parking(
    id: 18,
    location: const LatLng(-33.596911883208854, -70.57736197206867),
    name: "Estacionamiento Open Puente Alto",
    ubication: "Puente Alto",
    totalSpaces: 75,
  ),
  Parking(
    id: 19,
    location: const LatLng(-33.599297921136966, -70.57578483329922),
    name: "Estacionamiento Espacio Urbano Puente Alto",
    ubication: "Puente Alto",
    totalSpaces: 75,
  ),
  Parking(
    id: 20,
    location: const LatLng(-33.55354641417957, -70.67700147925522),
    name: "Estacionamiento Arauco El Bosque",
    ubication: "El Bosque",
    totalSpaces: 75,
  ),
  Parking(
    id: 21,
    location: const LatLng(-33.516673054956996, -70.71651881470568),
    name: "Estacionamiento MallPlaza Oeste",
    ubication: "Cerrillos",
    totalSpaces: 75,
  ),
  Parking(
    id: 22,
    location: const LatLng(-33.481338105655624, -70.75197996097535),
    name: "Estacionamiento Mall Arauco Maipú",
    ubication: "Maipu",
    totalSpaces: 75,
  ),
  Parking(
    id: 23,
    location: const LatLng(-33.36836056664303, -70.73003835694364),
    name: "Estacionamiento Mall Arauco Quilicura",
    ubication: "Quilicura",
    totalSpaces: 75,
  ),
];
