import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Management"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: CircleAvatar(
                radius: 50,
                child: Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.white,
                ),
                backgroundColor: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                "John Doe",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Center(
              child: Text(
                "johndoe@example.com",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "Profile Details:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const ListTile(
              leading: Icon(Icons.phone, color: Colors.green),
              title: Text("Phone: +1234567890"),
            ),
            const ListTile(
              leading: Icon(Icons.location_on, color: Colors.red),
              title: Text("Address: 123 Main Street, City, Country"),
            ),
            const ListTile(
              leading: Icon(Icons.calendar_today, color: Colors.orange),
              title: Text("Joined: January 1, 2020"),
            ),
          ],
        ),
      ),
    );
  }
}