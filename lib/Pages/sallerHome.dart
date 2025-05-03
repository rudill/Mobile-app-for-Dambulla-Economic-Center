import 'package:flutter/material.dart';

class sallerApp extends StatelessWidget {
  const sallerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top bar with icons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.menu, size: 28, color: Colors.green),
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.green[100],
                    child: Icon(Icons.person, color: Colors.green),
                  ),
                ],
              ),
            ),

            // Title
            SizedBox(
              height: 75,
              width: 350,
              child: Container(
                width: double.infinity,
                height: 10,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/images/FHbanner.png'),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),

            SizedBox(height: 60),
            // Buttons
            MenuButton(text: 'මිල දර්ශනය'),
            MenuButton(text: 'ඇනවුම් එක් කිරීම'),
            MenuButton(text: 'ක්‍රියාකාරී ඇනවුම්'),
            MenuButton(text: 'වෙන් කල කාලය'),

            Spacer(),

            // Bottom image
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Image.asset(
                'assets/images/help.png', // replace with your image
                height: 250,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Reusable button widget
class MenuButton extends StatelessWidget {
  final String text;

  const MenuButton({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 8.0),
      child: ElevatedButton(
        onPressed: () {
          // Navigate or handle button action here
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          padding: EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}