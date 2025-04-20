 import 'package:flutter/material.dart';
import 'package:vr_wedding_rental/core/animation_custom.dart';
import 'package:vr_wedding_rental/features/auth/presentation/bloc/auth_bloc/auth_bloc_state.dart';

Widget buildProfileCard(Authenticated state) {
    final user = state.user;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(children: [
        const Positioned(
            top: -30,
            left: -40,
            right: -40,
            bottom: -30,
            child: AnimatedCircleDialog()),
        Center(
          child: Container(
            width: 250,
            height: 220,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(17, 250, 107, 55),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    child: user.photoUrl != null
                        ? ClipOval(
                            child: Image.network(
                              state.user.photoUrl!,
                              fit: BoxFit.cover,
                              width: 80,
                              height: 80,
                            ),
                          )
                        : const Image(
                            image: AssetImage('assets/images/placeholder.jpeg'),
                            fit: BoxFit.cover,
                          ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    user.name ?? 'Varun P C',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    user.email,
                    style: const TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }