import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vr_wedding_rental/features/auth/presentation/bloc/auth_bloc/auth_bloc_bloc.dart';
import 'package:vr_wedding_rental/features/auth/presentation/bloc/forgot_pass_word_bloc/forgot_password_bloc_bloc.dart';
import 'package:vr_wedding_rental/features/home/presentation/bloc/animation_search_bar_home_bloc/an_search_bloc.dart';
import 'package:vr_wedding_rental/features/home/presentation/bloc/firebase_category/firebase_category_bloc_bloc.dart'; 

class AppBlocProvider extends StatelessWidget {
  final Widget child;

  const AppBlocProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc()),
        BlocProvider(create: (_) => ForgetPasswordBloc()),
        BlocProvider(create: (_) => SearchBarBloc()),
        BlocProvider(create: (_) => FirebaseCategoryBloc()),
      ],
      child: child,
    );
  }
}
