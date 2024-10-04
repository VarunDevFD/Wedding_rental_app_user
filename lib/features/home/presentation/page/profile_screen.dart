// import 'package:flutter/material.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Placeholder(
//         child: Text("Hello"),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                icon: const Icon(Icons.settings),
                onPressed: () {
                  // Handle settings action
                },
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 20.h),
                _buildProfileCard(),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: const Column(
                    children: [
                      ProfileItemList(),
                    ],
                  ),
                ),
                SizedBox(height: 25.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard() {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40.r,
              child: const Image(
                image: AssetImage('assets/images/placeholder.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Varun P C',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'varunrevathi6@gmail.com',
              style: TextStyle(
                fontSize: 16.sp,
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
          title: Text("Pro  file Item $index"),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            // Handle list item tap
          },
        );
      },
    );
  }
}
