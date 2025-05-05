import 'package:flutter/material.dart';

class ProfileEditPage extends StatelessWidget {
  const ProfileEditPage({super.key});

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
            // Profile Image
            const SizedBox(height: 30),
            Stack(
              alignment: Alignment.center,
              children: [
                const CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.black,
                  child: CircleAvatar(
                    radius: 58,
                    backgroundColor: Colors.white,
                    child: Text(
                      'Update\nProfile\nPicture',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, color: Colors.black),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 6,
                  right: 6,
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.grey.shade800,
                    child: const Icon(Icons.camera_alt, color: Colors.white, size: 18),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 75),

            // Form Fields
            const _ProfileTextField(label: 'නම වෙනස් කරන්න'),
            const _ProfileTextField(label: 'වෙලදසැල් නම'),
            const _ProfileTextField(label: 'ජංගම දුරකථන අංකය'),
            const _ProfileTextField(label: 'ලියාපදිංචි අංකය'),

            const SizedBox(height: 80),

            // Submit Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade800,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                // Handle profile update submission
              },
              child: const Text('තහවුරු කරන්න', style: TextStyle(fontSize: 20)),
            ),

            const SizedBox(height: 15),

            // Back to Menu Button
            TextButton.icon(
              onPressed: () {
                Navigator.pop(context); // go back to menu
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

// Custom reusable text field widget
class _ProfileTextField extends StatelessWidget {
  final String label;
  const _ProfileTextField({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }
}
