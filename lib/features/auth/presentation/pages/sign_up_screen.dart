import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vr_wedding_rental/core/utils/theme/app_colors.dart';
import 'package:vr_wedding_rental/core/utils/theme/app_text_styles.dart';
import 'package:vr_wedding_rental/core/utils/widgets/custom_button.dart';
import 'package:vr_wedding_rental/core/utils/widgets/custom_divider_widget.dart';
import 'package:vr_wedding_rental/features/auth/presentation/bloc/toggle_bloc/toggle_bloc_bloc.dart';
import 'package:vr_wedding_rental/features/auth/presentation/bloc/toggle_bloc/toggle_bloc_event.dart';
import 'package:vr_wedding_rental/features/auth/presentation/bloc/toggle_bloc/toggle_bloc_state.dart';
import 'package:vr_wedding_rental/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:vr_wedding_rental/features/auth/presentation/widgets/sign_in_nav_widget.dart';

class SignUpScreen extends StatelessWidget {
  // Controllers for the text fields
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

  // Function to handle form submission
  void submitCredentials(BuildContext context) {
    if (formKey.currentState?.validate() == true) {
      // Perform the sign-up action (mocked with a delay)
      Future.delayed(const Duration(seconds: 2), () {
        context.go('/home'); // Navigate to home on success
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => TogglePasswordBloc(),
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
                        onSubmitted: (_) =>
                            FocusScope.of(context).requestFocus(emailFocusNode),
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: emailController,
                        hintText: 'Enter your email',
                        label: 'Email',
                        obscureText: false,
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
                      _buildGoogleSignInButton(context),
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
      onTap: () => context.go('/sign-in'),
      child: Container(
        height: 40,
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: AppColors.dimBlack,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/google.png', height: 25),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
