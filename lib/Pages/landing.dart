import 'package:dec_app/Pages/personselect.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'language_provider.dart';
import 'trans.dart'; // Make sure this contains AzureTranslator.translateText

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  int _value = 2; // Default is Sinhala
  String welcomeText = 'ආයුබෝවන්';
  String continueText = 'ඉදිරියට යන්න';

  void _translateUI(String toLang) async {
    final translatedWelcome = await AzureTranslator.translateText(
      'Welcome',
      toLang,
    );
    final translatedContinue = await AzureTranslator.translateText(
      'Continue',
      toLang,
    );
    setState(() {
      welcomeText = translatedWelcome;
      continueText = translatedContinue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 70),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Text(
                    welcomeText,
                    style: const TextStyle(
                      fontFamily: 'RobotoMono-Bold',
                      color: Colors.green,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.only(right: 34),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                        value: 1,
                        groupValue: _value,
                        activeColor: Colors.green,
                        onChanged: (value) async {
                          setState(() {
                            _value = value!;
                          });
                          if (_value == 1) {
                            Provider.of<LanguageProvider>(
                              context,
                              listen: false,
                            ).changeLanguage('en');
                            _translateUI('en');
                          }
                        },
                      ),
                      const Text(
                        'English',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                        value: 2,
                        groupValue: _value,
                        activeColor: Colors.green,
                        onChanged: (value) {
                          setState(() {
                            _value = value!;
                            welcomeText = 'ආයුබෝවන්';
                            continueText = 'ඉදිරියට යන්න';
                          });
                        },
                      ),
                      const Text(
                        'සිංහල',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Person()),
                );
              },
              child: Text(
                continueText,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            ),
            const Spacer(),
            const Image(image: AssetImage('assets/images/fruits.png')),
          ],
        ),
      ),
    );
  }
}