import 'package:dec_app/Pages/FarmerRegistation.dart';
import 'package:dec_app/Pages/SellerRegistration.dart';
import 'package:dec_app/Pages/priceList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'language_provider.dart';
import 'trans.dart';

class Person extends StatefulWidget {
  const Person({super.key});

  @override
  State<Person> createState() => _PersonState();
}

class _PersonState extends State<Person> {
  Future<Map<String, String>> _translateTexts(String lang) async {
    if (lang == 'si') {
      return {
        'whoAreYou': 'ඔබ ?',
        'farmer': 'ගොවි මහත්මයෙක්',
        'shopOwner': 'වෙළඳසැල් හිමිකරුවෙක්',
      };
    } else {
      return {
        'whoAreYou': await AzureTranslator.translateText('ඔබ ?', 'en'),
        'farmer': await AzureTranslator.translateText('ගොවි මහත්මයෙක්', 'en'),
        'shopOwner': await AzureTranslator.translateText(
          'වෙළඳසැල් හිමිකරුවෙක්',
          'en',
        ),
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      // <-- New: wrap with Consumer
      builder: (context, langProvider, _) {
        String selectedLang = langProvider.languageCode;

        return FutureBuilder<Map<String, String>>(
          // <-- New: wrap with FutureBuilder
          future: _translateTexts(selectedLang),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            final t = snapshot.data!; // <-- Map for translated texts

            return Scaffold(
              body: Column(
                children: [
                  Image(image: AssetImage("assets/images/img.png")),

                  SizedBox(
                    height: 200,
                    child: Center(
                      child: Text(
                        t['whoAreYou']!, //"ඔබ ?",
                        style: TextStyle(
                          fontSize: 47,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                          fontFamily: 'RobotoMono',
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundImage: AssetImage(
                                'assets/images/farmer.png',
                              ),
                            ),
                            SizedBox(height: 13),

                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shadowColor: const Color.fromRGBO(0, 0, 0, 10),
                                elevation: 10,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Farmerregistration(),
                                  ),
                                );
                              },
                              child: Text(
                                t['farmer']!, //'ගොවි මහත්මයෙක්',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(width: 30),

                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                              backgroundImage: AssetImage(
                                'assets/images/owner.png',
                              ),
                              radius: 60,
                            ),
                            SizedBox(height: 9),

                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shadowColor: const Color.fromRGBO(0, 0, 0, 10),
                                elevation: 10,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) =>
                                        SellerRegistration(), // Farmerregistration(),
                                  ),
                                );
                              },
                              child: Text(
                                t['shopOwner']!, //"වෙළඳසැල් හිමිකරුවෙක්",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Spacer(),
                  Image(image: AssetImage('assets/images/down_shape.png')),
                ],
              ),
            );
          },
        );
      },
    );
  }
}