import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vr_wedding_rental/core/utils/theme/app_colors.dart';
import 'package:vr_wedding_rental/core/utils/widgets/custom_button.dart';
import 'package:vr_wedding_rental/features/auth/presentation/bloc/auth_bloc/auth_bloc_bloc.dart';
import 'package:vr_wedding_rental/features/auth/presentation/bloc/auth_bloc/auth_bloc_event.dart';
import 'package:vr_wedding_rental/features/auth/presentation/bloc/auth_bloc/auth_bloc_state.dart';
import 'package:vr_wedding_rental/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:vr_wedding_rental/features/auth/presentation/widgets/forgot_password_bn.dart';
import 'package:vr_wedding_rental/features/auth/presentation/widgets/sign_up_nav_widget.dart';

class SignInScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final AuthBloc authBloc; // Accept AuthBloc through constructor

  SignInScreen({super.key, required this.authBloc});

  void submitCredentials(BuildContext context) {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // Validation checks
    if (email.isEmpty || !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid email address.')),
      );
      return;
    }

    if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password cannot be empty.')),
      );
      return;
    }

    // Dispatch login event to AuthBloc
    authBloc.add(SignInEvent(email: email, password: password));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthBlocState>(
        bloc: authBloc, // Using the AuthBloc passed to the constructor
        listener: (context, state) {
          if (state is AuthLoading) {
            // Show loading indicator
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const Center(child: CircularProgressIndicator()),
            );
          } else if (state is Authenticated) {
            Navigator.of(context).pop(); // Remove loading indicator
            Navigator.of(context)
                .pushNamed('/home'); // Navigate to home on success
          } else if (state is AuthError) {
            Navigator.of(context).pop(); // Remove loading indicator
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  _buildWelcomeText(),
                  const SizedBox(height: 50),
                  _buildEmailField(context),
                  const SizedBox(height: 10),
                  _buildPasswordField(),
                  const ForgotPasswordBn(),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: "SIGN IN",
                    onPressed: () => submitCredentials(context),
                    buttonColor: AppColors.buttonTextColor,
                  ),
                  const SizedBox(height: 25),
                  _buildGoogleSignInButton(context),
                  const SizedBox(height: 30),
                  const SignUpNavigation(),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeText() {
    return const Column(
      children: [
        Text('Let\'s Sign You In', style: TextStyle(fontSize: 30)),
        Text('Welcome back.', style: TextStyle(fontSize: 18)),
        Text('You\'ve been missed!', style: TextStyle(fontSize: 18)),
      ],
    );
  }

  Widget _buildEmailField(BuildContext context) {
    return CustomTextField(
      controller: emailController,
      hintText: 'Enter your email',
      label: 'Email',
      obscureText: false,
      onSubmitted: (_) =>
          FocusScope.of(context).requestFocus(passwordFocusNode),
    );
  }

  Widget _buildPasswordField() {
    return CustomTextField(
      controller: passwordController,
      label: 'Password',
      hintText: 'Enter your password',
      obscureText: true,
      focusNode: passwordFocusNode,
    );
  }

  Widget _buildGoogleSignInButton(BuildContext context) {
    return GestureDetector(
      onTap: () => authBloc.add(GoogleSignInEvent()),
      child: Container(
        height: 45,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.dimBlack,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 25,
              child: Image.asset('assets/images/google.png'),
            ),
            const SizedBox(width: 10),
            const Text('Sign in with Google'),
          ],
        ),
      ),
    );
  }
}
