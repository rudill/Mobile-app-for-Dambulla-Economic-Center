import 'package:dec_app/Pages/Farmer/FarmerRegistation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'farmerHome.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'ලියාපදිංචි වූ ගිණුමකට පිවිසීම.',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24),

                CircleAvatar(
                  radius: 100,
                  backgroundImage: AssetImage('assets/images/farmer.png'),
                  backgroundColor: Colors.grey[300],
                ),
                SizedBox(height: 12),

                Text('ගොවි මහතෙකු ලෙස', style: TextStyle(fontSize: 25)),
                SizedBox(height: 24),

                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'ඔබගේ විද්‍යුත් ලිපිනය',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'කරුණාකර විද්‍යුත් ලිපිනය ඇතුළත් කරන්න';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'ඔබගේ රහස් අංකය',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'කරුණාකර රහස් අංකය ඇතුළත් කරන්න';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12),

                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Farmerregistration(),
                      ),
                    );
                  },
                  child: Text('ලියාපදිංචි වී නැද්ද? මෙතන ක්ලික් කරන්න'),
                ),

                SizedBox(height: 12),
                ElevatedButton(
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
                            .signInWithEmailAndPassword(
                              email: _emailController.text.trim(),
                              password: _passwordController.text.trim(),
                            );

                        User? user = userCredential.user;
                        if (user != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('සාර්ථකව පිවිසෙයි')),
                          );
                          await Future.delayed(Duration(milliseconds: 500));
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FarmerHomePage(),
                            ),
                          );
                        }
                      } on FirebaseAuthException catch (e) {
                        String message;

                        if (e.code == 'user-not-found') {
                          message =
                              'Email not found. Please check your email address.';
                        } else if (e.code == 'wrong-password') {
                          message = 'Incorrect password. Please try again.';
                        } else {
                          message = 'Login failed: ${e.message}';
                        }

                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(message)));
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('An unexpected error occurred.'),
                          ),
                        );
                        print(e);
                      }
                    }
                  },
                  child: Text('ගිණුමට පිවිසෙන්න.'),
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
      ),
    );
  }
}
