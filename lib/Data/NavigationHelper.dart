// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_application_1/ScreenEstacionamientos/AltoLasCondes.dart';
import 'package:flutter_application_1/ScreenEstacionamientos/Apumanque.dart';
import 'package:flutter_application_1/ScreenEstacionamientos/AraucoElBosque.dart';
import 'package:flutter_application_1/ScreenEstacionamientos/AraucoMaipu.dart';
import 'package:flutter_application_1/ScreenEstacionamientos/AraucoQuilicura.dart';
import 'package:flutter_application_1/ScreenEstacionamientos/BarrioIndependencia.dart';
import 'package:flutter_application_1/ScreenEstacionamientos/CostaneraCenter.dart';
import 'package:flutter_application_1/ScreenEstacionamientos/EUPuenteAlto.dart';
import 'package:flutter_application_1/ScreenEstacionamientos/FloridaCenter.dart';
import 'package:flutter_application_1/ScreenEstacionamientos/MPAlameda.dart';
import 'package:flutter_application_1/ScreenEstacionamientos/MPEga%C3%B1a.dart';
import 'package:flutter_application_1/ScreenEstacionamientos/MPLosDominicos.dart';
import 'package:flutter_application_1/ScreenEstacionamientos/MPOeste.dart';
import 'package:flutter_application_1/ScreenEstacionamientos/MPSur.dart';
import 'package:flutter_application_1/ScreenEstacionamientos/MPTobalaba.dart';
import 'package:flutter_application_1/ScreenEstacionamientos/MPVespucio.dart';
import 'package:flutter_application_1/ScreenEstacionamientos/OpenKennedy.dart';
import 'package:flutter_application_1/ScreenEstacionamientos/OpenPuenteAlto.dart';
import 'package:flutter_application_1/ScreenEstacionamientos/ParqueArauco.dart';
import 'package:flutter_application_1/ScreenEstacionamientos/PaseoQuilin.dart';
import 'package:flutter_application_1/ScreenEstacionamientos/PaseoSanBernardo.dart';
import 'package:flutter_application_1/ScreenEstacionamientos/PortalDehesa.dart';
import 'package:flutter_application_1/ScreenEstacionamientos/PortalReina.dart';

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
    case 11:
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const AltoLasCondesScreen()));
      break;
    case 12:
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const PortalDehesaScreen()));
      break;
    case 13:
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const PortalReinaScreen()));
      break;
    case 14:
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const ApumanqueScreen()));
      break;
    case 15:
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const BarrioIndependenciaScreen()));
      break;
    case 16:
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const PaseoSanBernardoScreen()));
      break;
    case 17:
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const MPTobalabaScreen()));
      break;
    case 18:
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const OpenPuenteAltoScreen()));
      break;
    case 19:
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const EUPuenteAltoScreen()));
      break;
    case 20:
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const AraucoElBosqueScreen()));
      break;
    case 21:
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const MPOesteScreen()));
      break;
    case 22:
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const AraucoMaipuScreen()));
      break;
    case 23:
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const AraucoQuilicuraScreen()));
      break;
  }
}
