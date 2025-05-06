import 'package:flutter/material.dart';
import 'menu.dart';

class TechnicalHelpPage extends StatelessWidget {
  const TechnicalHelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Back button
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 24.0, bottom: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Menu()),
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.arrow_back, color: Colors.black),
                      SizedBox(width: 6),
                      Text(
                        'ආපසු',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Top green header
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.green[700],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.settings, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'තාක්ෂණික සහාය',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Centered content
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'යෙදුම භාවිතා කරන අතරතුර ඔබට\n'
                            'කිසියම් ගැටළුවක් ඇති වුවහොත්,\n'
                            'ඔබට සහාය වීමට අපගේ තාක්ෂණික\n'
                            'සහාය කණ්ඩායම මෙහි සිටී. අප හා\n'
                            'සම්බන්ධ වන්න, අපි ඔබේ ගැටලුව\n'
                            'හැකි ඉක්මනින් විසඳා ගැනීමට උදව්\n'
                            'කරන්නෙමු.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, height: 1.6),
                      ),
                      SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.phone, color: Colors.red),
                          SizedBox(width: 8),
                          Text(
                            'අප අමතන්න:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text('+94 77 123 4567', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                      Text('+94 76 987 6543', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ),

            // Bottom image
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(
                'assets/images/help.png', // Ensure this path is correct and declared in pubspec.yaml
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
