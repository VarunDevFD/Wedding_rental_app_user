import 'package:flutter/material.dart';
import 'package:vr_wedding_rental/app.dart';
import 'package:vr_wedding_rental/core/di/injectors.dart';

void main() async {
  //------FireBase-Initializing------
  WidgetsFlutterBinding
      .ensureInitialized(); //---Ready before any async operation are executed---

  await init(); //------Initialize-Dependency-injection------

  //------Start-App-by-rendering------
  runApp(const MyApp());
}
