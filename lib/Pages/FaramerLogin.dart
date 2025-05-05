import 'package:dec_app/Pages/FarmerRegistation.dart';
import 'package:flutter/material.dart';
import 'language_provider.dart';
import 'trans.dart'; // AzureTranslator.translateText
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  // Method to get translated labels dynamically
  Future<Map<String, String>> _getTranslatedLabels(String lang) async {
    if (lang == 'si') {
      return {
        'title': 'ලියාපදිංචි වූ ගිණුමකට පිවිසීම',
        'asFarmer': 'ගොවි මහතෙකු ලෙස',
        'email': 'ඔබගේ විද්‍යුත් ලිපිනය',
        'password': 'ඔබගේ රහස් අංකය',
        'notRegistered': 'ලියාපදිංචි වී නැද්ද? මෙතන ක්ලික් කරන්න',
        'login': 'ගිණුමට පිවිසෙන්න.',
      };
    }

    return {
      'title': await AzureTranslator.translateText(
        'ලියාපදිංචි වූ ගිණුමකට පිවිසීම',
        lang,
      ),
      'asFarmer': await AzureTranslator.translateText('ගොවි මහතෙකු ලෙස', lang),
      'email': await AzureTranslator.translateText(
        'ඔබගේ විද්‍යුත් ලිපිනය',
        lang,
      ),
      'password': await AzureTranslator.translateText('ඔබගේ රහස් අංකය', lang),
      'notRegistered': await AzureTranslator.translateText(
        'ලියාපදිංචි වී නැද්ද? මෙතන ක්ලික් කරන්න',
        lang,
      ),
      'login': await AzureTranslator.translateText('ගිණුමට පිවිසෙන්න.', lang),
    };
  }

  @override
  Widget build(BuildContext context) {
    final langCode = Provider.of<LanguageProvider>(context).languageCode;

    return FutureBuilder<Map<String, String>>(
      future: _getTranslatedLabels(langCode),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final t = snapshot.data!;

        return Scaffold(
          body: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    t['title']!,
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 28),

                  CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage('assets/images/farmer.png'),
                    backgroundColor: Colors.grey[300],
                  ),
                  SizedBox(height: 12),

                  Text(t['asFarmer']!, style: TextStyle(fontSize: 25)),
                  SizedBox(height: 24),

                  // Email Field
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: t['email'],
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),

                  // Password Field
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: t['password'],
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 12),

                  // Text Button
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Farmerregistration(),
                        ),
                      );
                    },
                    child: Text(t['notRegistered']!),
                  ),

                  // Sign In Button
                  SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(t['login']!),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 64),
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}