import 'package:dec_app/Pages/Farmer/FaramerLogin.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'farmerHome.dart';

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
                Text(
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
                Text(
                  'ඔබගේ තොරතුරු ලබා දෙන්න.',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 5),
                //First Name Section--------------------------------------------(1)
                TextFormField(
                  controller: FnameController,
                  decoration: InputDecoration(
                    labelText: 'මුල් නම ඇතුලත් කරන්න.',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'මුල් නම ඇතුලත් කිරීම අනිවාර්ය වේ!';
                    } else if (value.length > 30) {
                      return 'මුල් නම අක්ෂර 30කට වඩා වැඩි විය නොහැක!';
                    } else if (RegExp(r'[^a-zA-Z\s]').hasMatch(value)) {
                      return 'මුල් නම තුළ අංක සහ විශේෂ ලක්ෂණ අඩංගු විය නොහැක!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                //Last Name Section---------------------------------------------(2)
                TextFormField(
                  controller: LnameController,
                  decoration: InputDecoration(
                    labelText: 'වාසගම ඇතුලත් කරන්න.',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'වාසගම ඇතුලත් කිරීම අනිවාර්ය වේ!';
                    } else if (value.length > 30) {
                      return 'වාසගම අක්ෂර 30කට වඩා වැඩි විය නොහැක!';
                    } else if (RegExp(r'[^a-zA-Z\s]').hasMatch(value)) {
                      return 'වාසගම තුළ අංක සහ විශේෂ ලක්ෂණ අඩංගු විය නොහැක!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                //Phone Number Section------------------------------------------(3)
                TextFormField(
                  controller: PhnoController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'දුරකථන අංකය ඇතුලත් කරන්න.',
                    hintText: '07X-XXX-XXXX',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'දුරකථන අංකය අනිවාර්ය වේ!';
                    } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                      return 'දුරකථන අංකය අංක 10ක් විය යුතුය!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                //NIC Number Section--------------------------------------------(4)
                TextFormField(
                  controller: NICController,
                  decoration: InputDecoration(
                    labelText: 'ජාතික හැදුනුම්පත් අංකය ඇතුලත් කරන්න.',
                    hintText: '20012800000V',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ජාතික හැදුනුම්පත් අංකය අනිවාර්ය වේ!';
                    } else if (value.length != 12) {
                      return 'ජාතික හැදුනුම්පත් අංකය අක්ෂර 12ක් වියයුතුයී!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                //Email Section-------------------------------------------------(5)
                TextFormField(
                  controller: EmailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'විද්‍යුත් ලිපිනය ඇතුලත් කරනන. ',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'විද්‍යුත් ලිපිනය අනිවාර්ය වේ!';
                    } else if (!RegExp(
                      r'^[\w\.-]+@[\w\.-]+\.\w{2,4}$',
                    ).hasMatch(value)) {
                      return 'ඇතුලත් කල විද්‍යුත් ලිපිනය නිවැරදි නොවේ!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                //Password Section----------------------------------------------(6)
                TextFormField(
                  controller: PWDController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'නව මුරපදයක් ඇතුලත් කරන්න.',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'නව මුරපදයක් අනිවාර්ය වේ!';
                    } else if (value.length <= 6) {
                      return 'මුරපදය අක්ෂර 6කට වඩා වැඩි විය යුතුය!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),
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
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return Dialog(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CircularProgressIndicator(),
                                    SizedBox(width: 16),
                                    Text("කරුණාකර රැඳී සිටින්න..."),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                        try {
                          UserCredential userCredential = await auth
                              .createUserWithEmailAndPassword(
                                email: EmailController.text.trim(),
                                password: PWDController.text.trim(),
                              );

                          user = userCredential.user;

                          await user!.updateDisplayName(
                            FnameController.text.trim(),
                          );
                          await user!.reload();
                          user = auth.currentUser;

                          CollectionReference collRef = FirebaseFirestore
                              .instance
                              .collection("FamerReg");
                          await collRef.add({
                            'Email': EmailController.text.trim(),
                            'First Name': FnameController.text.trim(),
                            'Last Name': LnameController.text.trim(),
                            'NIC': NICController.text.trim(),
                            'Phone Number': PhnoController.text.trim(),
                          });

                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("සාර්ථකයි!"),
                                content: Text("ඔබේ දත්ත සාර්ථකව උඩුගත විය."),
                                actions: [
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.green,
                                    ),
                                    child: Text("හරි"),
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) => FarmerHomePage(),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              );
                            },
                          );

                          FnameController.clear();
                          LnameController.clear();
                          PhnoController.clear();
                          NICController.clear();
                          EmailController.clear();
                          PWDController.clear();
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Password too weak.')),
                            );
                          } else if (e.code == 'email-already-in-use') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Email already in use.')),
                            );
                          }
                        } catch (e) {
                          print(e);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('An error occurred.')),
                          );
                        }
                      }
                    },

                    child: Text(
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
                  child: Text('ගිණුමක්‌ තීබේද? මෙතන ක්ලික් කරන්න.'),
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
