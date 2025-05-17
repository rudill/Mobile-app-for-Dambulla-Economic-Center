import 'package:flutter/material.dart';

class ReservationInfo extends StatelessWidget {
  const ReservationInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade800,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          const CircleAvatar(
            radius: 80,
            backgroundImage: AssetImage('assets/images/faramer1.jpg'),
          ),
        ],
      ),
    );
  }
}
