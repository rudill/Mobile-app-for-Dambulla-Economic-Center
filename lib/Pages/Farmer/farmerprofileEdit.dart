import 'package:flutter/material.dart';

class FarmerProfileEditPage extends StatelessWidget {
  const FarmerProfileEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'තොරතුරු වෙනස් කිරිම',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green.shade800,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 30),
            const CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('assets/images/faramer1.jpg'),
            ),
            const SizedBox(height: 60),

            // Form Fields (all inline)
            const Padding(
              padding: EdgeInsets.only(bottom: 14),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'නම වෙනස් කරන්න',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(bottom: 14),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'ජංගම දුරකථන අංකය',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 14),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'ලියාපදිංචි අංකය',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),

            const SizedBox(height: 60),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade800,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                // Submit action
              },
              child: const Text('තහවුරු කරන්න', style: TextStyle(fontSize: 20)),
            ),

            const SizedBox(height: 15),

            TextButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
              label: const Text('ආපසු'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
