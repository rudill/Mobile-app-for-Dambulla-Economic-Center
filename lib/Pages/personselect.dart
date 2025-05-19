import 'package:dec_app/Pages/Farmer/FarmerRegistation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dec_app/Azure_Translation/translation_provider.dart';
import 'package:dec_app/Azure_Translation/translatable_text.dart';

class Person extends StatefulWidget {
  const Person({super.key});

  @override
  State<Person> createState() => _PersonState();
}

class _PersonState extends State<Person> {
  @override
  Widget build(BuildContext context) {
    return TranslationLoadingOverlay(
      child: Scaffold(
        body: Column(
          children: [
            Image(image: AssetImage("assets/images/img.png")),

            SizedBox(
              height: 200,
              child: Center(
                child: TranslatableText(
                  "ඔබ ?",
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
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IntrinsicWidth(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Push image a bit right
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: AssetImage(
                              'assets/images/farmer.png',
                            ),
                          ),
                        ),
                        const SizedBox(height: 13),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: 100,
                          ), // min width for button
                          child: ElevatedButton(
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
                            child: TranslatableText(
                              'ගොවි මහත්මයෙක්',
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(flex: 1),

                  IntrinsicWidth(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: AssetImage(
                              'assets/images/owner.png',
                            ),
                          ),
                        ),
                        const SizedBox(height: 9),
                        ConstrainedBox(
                          constraints: BoxConstraints(minWidth: 100),
                          child: ElevatedButton(
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
                            child: TranslatableText(
                              "වෙළඳසැල් හිමිකරුවෙක්",
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Spacer(),
            Image(image: AssetImage('assets/images/down_shape.png')),
          ],
        ),
      ),
    );
  }
}
