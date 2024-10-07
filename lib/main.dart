import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vr_wedding_rental/app.dart';
import 'package:vr_wedding_rental/core/di/injectors.dart';
import 'package:vr_wedding_rental/core/firebase/firebase_options.dart';

void main() async {
  //------FireBase-Initializing------
  WidgetsFlutterBinding
      .ensureInitialized(); //---Ready before any async operation are executed---
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions
        .currentPlatform, //---Connect-with-firebase_options.dart---
  );

  //------Initialize-Dependency-injection------
  await init();

  //------Start-App-by-rendering------
  runApp(const MyApp());
}
