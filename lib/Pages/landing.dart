import 'package:dec_app/Pages/personselect.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dec_app/Azure_Translation/translation_provider.dart';
import 'package:dec_app/Azure_Translation/translatable_text.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  int _value = 2;

  @override
  Widget build(BuildContext context) {
    return TranslationLoadingOverlay(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 70),
              Container(
                color: Colors.white,
                child: Column(
                  children: const [
                    TranslatableText(
                      'ආයුබෝවන්',
                      style: TextStyle(
                        fontFamily: 'RobotoMono-Bold',
                        color: Colors.green,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    //TranslatableText(
                    //'Welcome',
                    //style: TextStyle(
                    //fontFamily: 'RobotoMono-Bold',
                    //color: Colors.green,
                    //fontSize: 35,
                    //fontWeight: FontWeight.bold,
                    //),
                    //),
                  ],
                ),
              ),

              SizedBox(height: 100),

              Padding(
                padding: EdgeInsets.only(right: 34),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio(
                          value: 1,
                          groupValue: _value,
                          activeColor: Colors.green,
                          onChanged: (value) {
                            setState(() {
                              _value = value!;
                            });
                            final provider = Provider.of<TranslationProvider>(
                              context,
                              listen: false,
                            );
                            provider.setLanguage(_value == 1 ? 'en' : 'si');
                          },
                        ),
                        Text(
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
                            });
                            final provider = Provider.of<TranslationProvider>(
                              context,
                              listen: false,
                            );
                            provider.setLanguage(_value == 1 ? 'en' : 'si');
                          },
                        ),
                        TranslatableText(
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

              SizedBox(height: 50),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Person()),
                  );
                },
                child: TranslatableText(
                  "ඉදිරියට යන්න",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              ),

              Spacer(),
              Image(image: AssetImage('assets/images/fruits.png')),
            ],
          ),
        ),
      ),
    );
  }
}
