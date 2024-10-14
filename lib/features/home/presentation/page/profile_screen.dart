import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vr_wedding_rental/features/auth/presentation/bloc/auth_bloc/auth_bloc_bloc.dart';
import 'package:vr_wedding_rental/features/auth/presentation/bloc/auth_bloc/auth_bloc_event.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text('My Profile'),
            pinned: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.logout_outlined),
                onPressed: () {
                  // When you want to sign out (for example, in a button press)
                  context.read<AuthBloc>().add(SignOutEvent());
                  // Navigate to WelcomeScreen after sign out
                  context.go('/welcome');
                },
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const SizedBox(height: 20),
                _buildProfileCard(),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      ProfileItemList(),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard() {
    return const Card(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40,
              child: Image(
                image: AssetImage('assets/images/placeholder.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Varun P C',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'varunrevathi6@gmail.com',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileItemList extends StatelessWidget {
  const ProfileItemList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true, // Allows it to wrap content inside a Column
      physics:
          const NeverScrollableScrollPhysics(), // Prevents scrolling conflicts with the main scroll view
      itemCount: 7,
      itemBuilder: (context, index) {
        return ListTile(
          tileColor: (index % 2 == 0)
              ? const Color.fromARGB(192, 241, 255, 241)
              : const Color.fromARGB(116, 210, 235, 255),
          leading: const Icon(Icons.person), // Replace with relevant icons
          title: Text("Profile Item $index"),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            // Handle list item tap
          },
        );
      },
    );
  }
}
