import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFFFFD966),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.location_on,
                      size: 35,
                      color: Color(0xFFFFD966),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'ALMLAH',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Discover Oman\'s Hidden Gems',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.explore),
              title: const Text('Explore Places'),
              onTap: () {
                Navigator.pop(context);
                // Add navigation to explore places
              },
            ),
            ListTile(
              leading: const Icon(Icons.add_location),
              title: const Text('Add New Place'),
              onTap: () {
                Navigator.pop(context);
                // Add navigation to add new place
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                // Add navigation to settings
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              'ALMLAH',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 40),
            Text(
              'Aspiring for the Sultanate of Oman to have an economic share through tourism, we at ALMLAH aim to document tourist destinations in the Sultanate of Oman through the world of technology.',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[800],
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              'We focus on providing unique experiences that showcase Oman\'s beautiful nature and rich cultural heritage, making these destinations accessible to visitors from around the world.',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[800],
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        backgroundColor: const Color(0xFFFFD966),
        child: const Icon(Icons.home, color: Colors.black),
      ),
    );
  }
}