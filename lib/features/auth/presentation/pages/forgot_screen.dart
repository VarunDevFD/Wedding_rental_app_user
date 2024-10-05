import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            "Forgot Password"), // Use title instead of actions for the main title
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/sign-in'),
        ),
        actions: const [
          // You can add other action buttons here if needed
        ],
      ),
      body: const Center(
        child: Text(
            "Please enter your email to reset your password"), // Placeholder for the main content
      ),
    );
  }
}
