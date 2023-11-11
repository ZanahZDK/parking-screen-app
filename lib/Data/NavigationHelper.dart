// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_application_1/ScreenEstacionamientos/ParkingDetailScreen.dart';

void navigateToParkingDetail(BuildContext context, int parkingId) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => ParkingDetailScreen(parkingLotId: parkingId),
  ));
}
