import 'package:flutter/material.dart';
import 'package:vr_wedding_rental/core/routes/app_blocs.dart';
import 'package:vr_wedding_rental/core/routes/app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBlocProvider(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
        title: 'Flutter Wedding Rental Application',
      ),
    );
  }
}
