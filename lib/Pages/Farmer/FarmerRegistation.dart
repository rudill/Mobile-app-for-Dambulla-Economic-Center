import 'package:dec_app/Pages/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../../Firestore/FamerReg.dart';
import 'package:dec_app/Azure_Translation/translation_provider.dart';
import 'package:dec_app/Azure_Translation/translatable_text.dart';

class Farmerregistration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: FarmerReg());
  }
}

class FarmerReg extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final FnameController = TextEditingController();
  final LnameController = TextEditingController();
  final PhnoController = TextEditingController();
  final NICController = TextEditingController();
  final EmailController = TextEditingController();
  final PWDController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;

  @override
  Widget build(BuildContext context) {
    final translator = Provider.of<TranslationProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TranslatableText(
                  'ගොවි මහතෙකු ලෙස ලියාපදිංචිය.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 5),
                Image.asset('assets/images/signup_image.png', height: 150),
                SizedBox(height: 30),
                TranslatableText(
                  'ඔබගේ තොරතුරු ලබා දෙන්න.',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 5),

                // First Name
                FutureBuilder<String>(
                  future: translator.translate('මුල් නම ඇතුලත් කරන්න'),
                  builder: (context, snapshot) {
                    return TextFormField(
                      controller: FnameController,
                      decoration: InputDecoration(
                        labelText: snapshot.data ?? 'මුල් නම ඇතුලත් කරන්න',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'First Name is Required !';
                        } else if (value.length > 30) {
                          return 'First Name Cannot be Longer than 30 Characters.';
                        } else if (RegExp(r'[^a-zA-Z\s]').hasMatch(value)) {
                          return 'First Name Cannot Contain Numbers or Special Characters.';
                        }
                        return null;
                      },
                    );
                  },
                ),

                SizedBox(height: 15),

                // Last Name
                FutureBuilder<String>(
                  future: translator.translate('වාසගම ඇතුලත් කරන්න'),
                  builder: (context, snapshot) {
                    return TextFormField(
                      controller: LnameController,
                      decoration: InputDecoration(
                        labelText: snapshot.data ?? 'වාසගම ඇතුලත් කරන්න',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please provide a Surname!';
                        } else if (value.length > 30) {
                          return 'Surname Cannot be Longer than 30 Characters!';
                        } else if (RegExp(r'[^a-zA-Z\s]').hasMatch(value)) {
                          return 'Surnames Cannot Contain Numbers or Special Characters!';
                        }
                        return null;
                      },
                    );
                  },
                ),

                SizedBox(height: 15),

                // Phone Number
                FutureBuilder<String>(
                  future: translator.translate('දුරකථන අංකය ඇතුලත් කරන්න.'),
                  builder: (context, snapshot) {
                    return TextFormField(
                      controller: PhnoController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: snapshot.data ?? 'දුරකථන අංකය ඇතුලත් කරන්න.',
                        hintText: '07X-XXX-XXXX',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Phone Number is Mandatory!';
                        } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                          return 'Phone Number Must be 10 Digits!';
                        }
                        return null;
                      },
                    );
                  },
                ),

                SizedBox(height: 15),

                // NIC
                FutureBuilder<String>(
                  future: translator.translate(
                    'ජාතික හැදුනුම්පත් අංකය ඇතුලත් කරන්න.',
                  ),
                  builder: (context, snapshot) {
                    return TextFormField(
                      controller: NICController,
                      decoration: InputDecoration(
                        labelText:
                            snapshot.data ??
                            'ජාතික හැදුනුම්පත් අංකය ඇතුලත් කරන්න.',
                        hintText: '20012800000V',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'NIC Number is Mandatory!';
                        } else if (value.length != 12) {
                          return 'NIC must be 12 characters!';
                        }
                        return null;
                      },
                    );
                  },
                ),

                SizedBox(height: 15),

                // Email
                FutureBuilder<String>(
                  future: translator.translate(
                    'විද්‍යුත් ලිපිනය ඇතුලත් කරන්න.',
                  ),
                  builder: (context, snapshot) {
                    return TextFormField(
                      controller: EmailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText:
                            snapshot.data ?? 'විද්‍යුත් ලිපිනය ඇතුලත් කරන්න.',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is Required!';
                        } else if (!RegExp(
                          r'^[\w\.-]+@[\w\.-]+\.\w{2,4}$',
                        ).hasMatch(value)) {
                          return 'Invalid Email Address!';
                        }
                        return null;
                      },
                    );
                  },
                ),

                SizedBox(height: 15),

                // Password
                FutureBuilder<String>(
                  future: translator.translate('නව මුරපදයක් ඇතුලත් කරන්න.'),
                  builder: (context, snapshot) {
                    return TextFormField(
                      controller: PWDController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: snapshot.data ?? 'නව මුරපදයක් ඇතුලත් කරන්න.',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is Required!';
                        } else if (value.length <= 6) {
                          return 'Password Must be More than 6 Characters!';
                        }
                        return null;
                      },
                    );
                  },
                ),

                SizedBox(height: 30),

                // Submit
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      registerFarmer(
                        context: context,
                        emailController: EmailController,
                        pwdController: PWDController,
                        fnameController: FnameController,
                        lnameController: LnameController,
                        nicController: NICController,
                        phnoController: PhnoController,
                        formKey: _formKey,
                        onSuccess: (userId) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: TranslatableText("සාර්ථකයි!"),
                                content: TranslatableText(
                                  "ඔබේ දත්ත සාර්ථකව උඩුගත විය.",
                                ),
                                actions: [
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.green,
                                    ),
                                    child: TranslatableText("හරි"),
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => LoginPage(),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      );
                    },
                    child: TranslatableText(
                      'ලියාපදිංචි කරන්න',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 5),

                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: TranslatableText('ගිණුමක්‌ තීබේද? මෙතන ක්ලික් කරන්න.'),
                ),
                SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
