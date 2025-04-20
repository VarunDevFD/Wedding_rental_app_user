import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vr_wedding_rental/core/animation_custom.dart';
import 'package:vr_wedding_rental/features/auth/presentation/bloc/auth_bloc/auth_bloc_bloc.dart';
import 'package:vr_wedding_rental/features/auth/presentation/bloc/auth_bloc/auth_bloc_event.dart';
import 'package:vr_wedding_rental/features/auth/presentation/bloc/auth_bloc/auth_bloc_state.dart';
import 'package:vr_wedding_rental/features/profile/presentation/widgets/user_details_w.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthBlocState>(
      listener: (context, state) {
        if (state is SignOutSuccessState) {
          context.go('/welcome');
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AuthError) {
          return Center(child: Text(state.message));
        } else if (state is Authenticated) {
          return buildProfileContent(context, state);
        }
        return const Center(child: Text('Checking authentication...'));
      },
    );
  }

  buildProfileContent(BuildContext context, Authenticated state) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: const Text('My Profile'),
              pinned: true,
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.logout_outlined,
                    color: Colors.pinkAccent,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Sign Out'),
                        content:
                            const Text('Are you sure you want to sign out?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              context.read<AuthBloc>().add(SignOutEvent());
                            },
                            child: const Text('Sign Out'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  const SizedBox(height: 20),
                  buildProfileCard(state),
                  const SizedBox(height: 15),
                  // Wedding Preferences
                  const Text(
                    'Wedding Preferences',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Card(
                    elevation: 2,
                    child: ListTile(
                      leading:
                          const Icon(Icons.palette, color: Colors.pinkAccent),
                      title: const Text('Wedding Theme'),
                      subtitle: const Text('Rustic, Modern, Classic'),
                      trailing: const Icon(Icons.edit),
                      onTap: () {
                        // Navigate to preferences screen
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Edit Preferences coming soon!')),
                        );
                      },
                    ),
                  ),
                  Card(
                    elevation: 2,
                    child: ListTile(
                      leading: const Icon(Icons.attach_money,
                          color: Colors.pinkAccent),
                      title: const Text('Budget Range'),
                      subtitle: const Text('\$1,000 - \$5,000'),
                      trailing: const Icon(Icons.edit),
                      onTap: () {
                        // Edit budget
                      },
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Booking History
                  const Text(
                    'Booking History',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Card(
                    elevation: 2,
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.accessibility_rounded,
                              color: Colors.pinkAccent),
                          title: const Text('Wedding Dress Rental'),
                          subtitle: const Text('Booked for: 2025-06-15'),
                          onTap: () {
                            // View booking details
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'View Booking Details coming soon!')),
                            );
                          },
                        ),
                        const Divider(),
                        ListTile(
                          leading: const Icon(Icons.table_chart,
                              color: Colors.pinkAccent),
                          title: const Text('Table Decor Set'),
                          subtitle: const Text('Booked for: 2025-06-15'),
                          onTap: () {
                            // View booking details
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Saved Items
                  const Text(
                    'Saved Items',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Card(
                    elevation: 2,
                    child: Column(
                      children: [
                        ListTile(
                          leading: Image.network(
                            'https://example.com/wedding_dress.jpg', // Replace with actual image URL
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.image_not_supported),
                          ),
                          title: const Text('Vintage Lace Dress'),
                          subtitle: const Text('\$150/day'),
                          onTap: () {
                            // View saved item details
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('View Saved Item coming soon!')),
                            );
                          },
                        ),
                        const Divider(),
                        ListTile(
                          leading: Image.network(
                            'https://example.com/ring.jpg',
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.image_not_supported),
                          ),
                          title: const Text('Diamond Ring Set'),
                          subtitle: const Text('\$50/day'),
                          onTap: () {
                            // View saved item details
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Account Actions
                  const Text(
                    'Account Settings',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Card(
                    elevation: 2,
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.notifications,
                              color: Colors.pinkAccent),
                          title: const Text('Manage Notifications'),
                          onTap: () {
                            // Navigate to notification settings
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.logout,
                              color: Colors.pinkAccent),
                          title: const Text('Sign Out'),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Sign Out'),
                                content: const Text(
                                    'Are you sure you want to sign out?'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      context
                                          .read<AuthBloc>()
                                          .add(SignOutEvent());
                                    },
                                    child: const Text('Sign Out'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
