import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vr_wedding_rental/features/auth/presentation/bloc/toggle_bloc/toggle_bloc_bloc.dart';
import 'package:vr_wedding_rental/features/auth/presentation/bloc/toggle_bloc/toggle_bloc_event.dart';
import 'package:vr_wedding_rental/features/auth/presentation/bloc/toggle_bloc/toggle_bloc_state.dart';
import 'package:vr_wedding_rental/features/auth/presentation/widgets/custom_text_field.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController newPasswordController;
  final FocusNode newPasswordFocusNode;
  final String? Function(String?) validatePassword;

  const PasswordField({
    super.key,
    required this.newPasswordController,
    required this.newPasswordFocusNode,
    required this.validatePassword,
  });

  @override
  Widget build(BuildContext context) {
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
}
