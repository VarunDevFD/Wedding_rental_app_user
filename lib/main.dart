import 'package:flutter/material.dart';
import 'package:vr_wedding_rental/app.dart';
import 'package:vr_wedding_rental/core/di/injectors.dart';

void main() async {
  await init(); //-------------------injection----------------- 
  runApp(const MyApp());
}
