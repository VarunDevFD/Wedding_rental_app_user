import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vr_wedding_rental/features/auth/presentation/bloc/toggle_bloc/toggle_bloc_bloc.dart';
import 'package:vr_wedding_rental/features/auth/presentation/bloc/toggle_bloc/toggle_bloc_event.dart';
import 'package:vr_wedding_rental/features/auth/presentation/bloc/toggle_bloc/toggle_bloc_state.dart';
import 'package:vr_wedding_rental/features/auth/presentation/widgets/custom_text_field.dart';

class ConfirmPasswordField extends StatelessWidget {
  final TextEditingController confirmPasswordController;
  final TextEditingController newPasswordController;
  final FocusNode confirmPasswordFocusNode;

  const ConfirmPasswordField({
    super.key,
    required this.confirmPasswordController,
    required this.confirmPasswordFocusNode,
    required this.newPasswordController,
  });

  String? _validateConfirmPassword(String? value) {
    if (value != newPasswordController.text) {
      return 'Passwords do not match';
    }
    return null; // Validation passed
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TogglePasswordBloc, TogglePasswordState>(
      builder: (context, state) {
        return CustomTextField(
          controller: confirmPasswordController,
          label: 'Confirm Password',
          hintText: 'Re-enter your password',
          obscureText: !state.confirmPasswordVisible,
          focusNode: confirmPasswordFocusNode,
          validator: _validateConfirmPassword,
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
}
