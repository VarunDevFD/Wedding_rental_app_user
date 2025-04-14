import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
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
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  SignInScreen({super.key});

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
    BlocProvider.of<AuthBloc>(context).add(
      SignInEvent(email: email, password: password),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthBlocState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            // Show loading indicator
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const Center(child: CircularProgressIndicator()),
            );
          } else if (state is Authenticated) {
            context.pop(); // Remove loading indicator
            context.go('/home'); // Navigate to home on success
          } else if (state is AuthError) {
            context.pop(); // Remove loading indicator
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 50.w),
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  _buildWelcomeText(),
                  SizedBox(height: 50.h),
                  _buildEmailField(context),
                  SizedBox(height: 10.h),
                  _buildPasswordField(),
                  const ForgotPasswordBn(),
                  SizedBox(height: 20.h),
                  CustomButton(
                    text: "SIGN IN",
                    onPressed: () => submitCredentials(context),
                    buttonColor: AppColors.buttonTextColor,
                  ),
                  SizedBox(height: 25.h),
                  _buildGoogleSignInButton(context),
                  SizedBox(height: 30.h),
                  const SignUpNavigation(),
                  SizedBox(height: 10.h),
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
      onTap: () => BlocProvider.of<AuthBloc>(context).add(GoogleSignInEvent()),
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
