import 'package:flutter/material.dart';



class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.logout,
                color: Color.fromARGB(255, 0, 208, 235),
              ))
        ],
      ),
      body: const Center(
        child: Text('Home Screen'),
      ),
    );
  }
}
