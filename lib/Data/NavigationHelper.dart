// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_application_1/ScreenEstacionamientos/CostaneraCenter.dart';
import 'package:flutter_application_1/ScreenEstacionamientos/FloridaCenter.dart';
import 'package:flutter_application_1/ScreenEstacionamientos/MPAlameda.dart';
import 'package:flutter_application_1/ScreenEstacionamientos/MPEga%C3%B1a.dart';
import 'package:flutter_application_1/ScreenEstacionamientos/MPLosDominicos.dart';
import 'package:flutter_application_1/ScreenEstacionamientos/MPSur.dart';
import 'package:flutter_application_1/ScreenEstacionamientos/MPVespucio.dart';
import 'package:flutter_application_1/ScreenEstacionamientos/OpenKennedy.dart';
import 'package:flutter_application_1/ScreenEstacionamientos/ParqueArauco.dart';
import 'package:flutter_application_1/ScreenEstacionamientos/PaseoQuilin.dart';

void navigateToParkingDetail(BuildContext context, int parkingId) {
  switch (parkingId) {
    case 1:
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const CostaneraCenterScreen()));
      break;
    case 2:
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const ParqueAraucoScreen()));
      break;
    case 3:
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const FloridaCenterScreen()));
      break;
    case 4:
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const MPVespucioScreen()));
      break;
    case 5:
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const MPAlamedaScreen()));
      break;
    case 6:
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const MPEganaScreen()));
      break;
    case 7:
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const MPSurScreen()));
      break;
    case 8:
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const PaseoQuilinScreen()));
      break;
    case 9:
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const MPLosDominicosScreen()));
      break;
    case 10:
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const OpenKennedyScreen()));
      break;
    // Puedes agregar más casos aquí para otros estacionamientos
  }
}
