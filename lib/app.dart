import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vr_wedding_rental/core/route/app_router.dart';
import 'package:vr_wedding_rental/features/auth/domain/repositories/auth_repo.dart';
import 'package:vr_wedding_rental/features/auth/presentation/bloc/auth_bloc/auth_bloc_bloc.dart'; // Import your AuthBloc here

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
      title: 'Flutter Wedding Rental Application',
      theme: ThemeData(primarySwatch: Colors.blue),
      builder: (context, child) {
        // Create an instance of AuthRepository
        final authRepository = AuthRepository();

        // Provide the AuthBloc using BlocProvider
        return BlocProvider(
          create: (context) => AuthBloc(repository: authRepository),
          child: child!,
        );
      },
    );
  }
}
