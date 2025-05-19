import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../Azure_Translation/translatable_text.dart';
import '../../Firestore/SellerReg.dart';
import '../LoginPage.dart';

class SellerRegistration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: SignUpScreen());
  }
}

class SignUpScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final FullNameController = TextEditingController();
  final ShopNameController = TextEditingController();
  final ShopRegNumController = TextEditingController();
  final PhnoController = TextEditingController();
  final NICController = TextEditingController();
  final EmailController = TextEditingController();
  final PWDController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;

  @override
  Widget build(BuildContext context) {
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
                  'වෙළදසැල් හිමිවරයෙකු ලෙස ලියාපදිංචිය.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 29,
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
                TextFormField(
                  controller: FullNameController,
                  decoration: InputDecoration(
                    label: TranslatableText('සම්පූර්ණ නම'),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Missing required information !';
                    } else if (value.length > 200) {
                      return 'Full Name Cannot Exceed 200 Characters !';
                    } else if (RegExp(r'[^a-zA-Z\s]').hasMatch(value)) {
                      return 'Full Name Cannot Contain Numbers or Special Characters !';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: ShopNameController,
                  decoration: InputDecoration(
                    label: TranslatableText('වෙළදසැලේ නම'),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter a Store Name!';
                    } else if (value.length > 200) {
                      return 'Store Name cannot Contain more than 200 Characters!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: ShopRegNumController,
                  decoration: InputDecoration(
                    label: TranslatableText('වෙළදසැල් ලියාපදිංචි අංකය'),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'වෙළදසැල් ලියාපදිංචි අංකය ඇතුලත් කිරීම අනිවාර්ය වේ!';
                    } else if (value.length > 50) {
                      return 'වෙළදසැලේ නම අක්ෂර 50කට වඩා වැඩි විය නොහැක!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: PhnoController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    label: TranslatableText('දුරකථන අංකය ඇතුලත් කරන්න.'),
                    hintText: '07X-XXX-XXXX',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'දුරකථන අංකය ඇතුලත් කිරීම අනිවාර්ය වේ!';
                    } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                      return 'දුරකථන අංකය අංක 10ක් විය යුතුය!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: NICController,
                  decoration: InputDecoration(
                    label: TranslatableText(
                      'ජාතික හැදුනුම්පත් අංකය ඇතුලත් කරන්න.',
                    ),
                    hintText: '20012800000V',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ජාතික හැදුනුම්පත් අංකය ඇතුලත් කිරීම අනිවාර්ය වේ!';
                    } else if (value.length != 12) {
                      return 'ජාතික හැදුනුම්පත් අංකය අක්ෂර 12ක් වියයුතුයී!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: EmailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    label: TranslatableText('විද්‍යුත් ලිපිනය ඇතුලත් කරනන.'),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'විද්‍යුත් ලිපිනය ඇතුලත් කිරීම අනිවාර්ය වේ!';
                    } else if (!RegExp(
                      r'^[\w\.-]+@[\w\.-]+\.\w{2,4}$',
                    ).hasMatch(value)) {
                      return 'ඇතුලත් කල විද්‍යුත් ලිපිනය නිවැරදි නොවේ!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: PWDController,
                  obscureText: true,
                  decoration: InputDecoration(
                    label: TranslatableText('නව මුරපදයක් ඇතුලත් කරන්න.'),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'නව මුරපදයක් ඇතුලත් කිරීම අනිවාර්ය වේ!';
                    } else if (value.length <= 6) {
                      return 'මුරපදය අක්ෂර 6කට වඩා වැඩි විය යුතුය!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 25),
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
                      registerSeller(
                        context: context,
                        fullNameController: FullNameController,
                        emailController: EmailController,
                        pwdController: PWDController,
                        shopNameController: ShopNameController,
                        shopRegNumController: ShopRegNumController,
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
