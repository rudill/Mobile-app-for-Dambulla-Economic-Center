import 'package:flutter/material.dart';

class TechnicalHelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top bar
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(16.0),
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
                        style: TextStyle(fontSize: 16, height: 1.6),
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
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text('+94 77 123 4567', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                      Text('+94 76 987 6543', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ),

            // Bottom image
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(
                'assets/images/help.png',
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
