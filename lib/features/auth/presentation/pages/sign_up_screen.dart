import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vr_wedding_rental/core/utils/theme/app_colors.dart';
import 'package:vr_wedding_rental/core/utils/theme/app_text_styles.dart';
import 'package:vr_wedding_rental/core/utils/widgets/custom_button.dart';
import 'package:vr_wedding_rental/core/utils/widgets/custom_divider_widget.dart';
import 'package:vr_wedding_rental/features/auth/presentation/bloc/auth_bloc/auth_bloc_bloc.dart';
import 'package:vr_wedding_rental/features/auth/presentation/bloc/auth_bloc/auth_bloc_event.dart';
import 'package:vr_wedding_rental/features/auth/presentation/bloc/auth_bloc/auth_bloc_state.dart';
import 'package:vr_wedding_rental/features/auth/presentation/bloc/toggle_bloc/toggle_bloc_bloc.dart';
import 'package:vr_wedding_rental/features/auth/presentation/bloc/toggle_bloc/toggle_bloc_event.dart';
import 'package:vr_wedding_rental/features/auth/presentation/bloc/toggle_bloc/toggle_bloc_state.dart';
import 'package:vr_wedding_rental/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:vr_wedding_rental/features/auth/presentation/widgets/sign_in_nav_widget.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // Focus nodes for handling text field focus
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode newPasswordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();

  SignUpScreen({super.key});

  // Global key for the form
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Function to handle form submission with validation
  void submitCredentials(BuildContext context) {
    if (formKey.currentState?.validate() == true) {
      // Perform the sign-up action (mocked with a delay)
      Future.delayed(const Duration(seconds: 2), () {
        context.go('/home'); // Navigate to home on success
      });

      BlocProvider.of<AuthBloc>(context).add(
        SignUpEvent(
          email: emailController.toString(),
          password: newPasswordController.toString(),
        ),
      );
    }
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    // Check if the email is in the correct format
    String pattern = r'^[^@]+@[^@]+\.[^@]+';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null; // Validation passed
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null; // Validation passed
  }

  String? validateConfirmPassword(String? value) {
    if (value != newPasswordController.text) {
      return 'Passwords do not match';
    }
    return null; // Validation passed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => TogglePasswordBloc(), // Toggle Password Bloc

        child: BlocListener<AuthBloc, AuthBlocState>(
          listener: (context, state) {
            if (state is AuthLoading) {
              // Show loading indicator
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) =>
                    const Center(child: CircularProgressIndicator()),
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
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      children: [
                        const SizedBox(height: 25),
                        Text("Create an Account",
                            style: AppTextStyles.titleSignIn),
                        const SizedBox(height: 50),
                        CustomTextField(
                          controller: nameController,
                          hintText: 'Enter your Name',
                          label: 'Name',
                          obscureText: false,
                          validator: (value) => value == null || value.isEmpty
                              ? 'Please enter your name'
                              : null,
                          onSubmitted: (_) => FocusScope.of(context)
                              .requestFocus(emailFocusNode),
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: emailController,
                          hintText: 'Enter your email',
                          label: 'Email',
                          obscureText: false,
                          validator: validateEmail,
                          onSubmitted: (_) => FocusScope.of(context)
                              .requestFocus(newPasswordFocusNode),
                        ),
                        const SizedBox(height: 10),
                        _buildPasswordField(),
                        const SizedBox(height: 10),
                        _buildConfirmPasswordField(),
                        const SizedBox(height: 30),
                        CustomButton(
                          text: "SIGN UP",
                          onPressed: () => submitCredentials(context),
                          buttonColor: AppColors.buttonTextColor,
                        ),
                        const SizedBox(height: 20),
                        const OrDivider(),
                        const SizedBox(height: 20),
                        _buildGoogleSignInButton(
                            context), // Google Sign In Button
                        const SizedBox(height: 30),
                        const SignInNavigation(),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return BlocBuilder<TogglePasswordBloc, TogglePasswordState>(
      builder: (context, state) {
        return CustomTextField(
          controller: newPasswordController,
          label: 'Password',
          hintText: 'Enter your password',
          obscureText: !state.passwordVisible,
          focusNode: newPasswordFocusNode,
          validator: validatePassword,
          suffixIcon: IconButton(
            icon: Icon(state.passwordVisible
                ? Icons.visibility
                : Icons.visibility_off),
            onPressed: () {
              context
                  .read<TogglePasswordBloc>()
                  .add(TogglePasswordVisibility());
            },
          ),
        );
      },
    );
  }

  Widget _buildConfirmPasswordField() {
    return BlocBuilder<TogglePasswordBloc, TogglePasswordState>(
      builder: (context, state) {
        return CustomTextField(
          controller: confirmPasswordController,
          label: 'Confirm Password',
          hintText: 'Re-enter your password',
          obscureText: !state.confirmPasswordVisible,
          focusNode: confirmPasswordFocusNode,
          validator: validateConfirmPassword,
          suffixIcon: IconButton(
            icon: Icon(state.confirmPasswordVisible
                ? Icons.visibility
                : Icons.visibility_off),
            onPressed: () {
              context
                  .read<TogglePasswordBloc>()
                  .add(ToggleConfirmPasswordVisibility());
            },
          ),
        );
      },
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
