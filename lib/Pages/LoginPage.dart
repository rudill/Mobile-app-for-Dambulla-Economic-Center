import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Firestore/auth_service.dart';
import 'Seller/sallerHome.dart';
import 'landing.dart';
import 'Farmer/farmerHome.dart';
import 'package:dec_app/Azure_Translation/translatable_text.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final AuthService _authService = AuthService();

  void _showError(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: TranslatableText(message)));
  }

  void _login() async {
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
                  TranslatableText("කරුණාකර රැඳී සිටින්න..."),
                ],
              ),
            ),
          );
        },
      );

      try {
        User? user = await _authService.signInWithEmail(
          _emailController.text,
          _passwordController.text,
        );

        if (user != null) {
          var userDoc = await _authService.getUserData(user.uid);
          if (userDoc.exists) {
            Navigator.pop(context);
            if (userDoc['role'] == 'farmer') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => FarmerHomePage()),
              );
            } else if (userDoc['role'] == 'seller') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SellerHome()),
              );
            } else {
              _showError('Unknown role.');
            }
          }
        }
      } catch (e) {
        Navigator.pop(context);
        _showError(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [

          Positioned(
            top: 100,
            child: Image.asset(
              'assets/images/FHbanner.png',
              height: 250,
              width: 350,
              fit: BoxFit.contain,
            ),
          ),


          Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 100),

                  Material(
                    elevation: 8,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: EdgeInsets.all(24),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [


                            TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.email),
                                label: TranslatableText(
                                    'ඔබගේ විද්‍යුත් ලිපිනය'),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              validator: (value) =>
                              value!.isEmpty
                                  ? 'කරුණාකර විද්‍යුත් ලිපිනය ඇතුළත් කරන්න'
                                  : null,
                            ),
                            SizedBox(height: 16),

                            StatefulBuilder(
                              builder: (context, setState) {
                                bool _obscurePassword = true;
                                return TextFormField(
                                  controller: _passwordController,
                                  obscureText: _obscurePassword,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.lock),
                                    label: TranslatableText('ඔබගේ මුරපදය'),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  validator: (value) =>
                                  value!.isEmpty
                                      ? 'කරුණාකර රහස් අංකය ඇතුළත් කරන්න'
                                      : null,
                                );
                              },
                            ),
                            SizedBox(height: 24),

                            ElevatedButton(
                              onPressed: _login,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                minimumSize: Size(double.infinity, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              child: TranslatableText(
                                'ගිණුමට පිවිසෙන්න.',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 40),

                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => Welcome()));
                    },
                    child: TranslatableText(
                      'ලියාපදිංචි වී නැද්ද? මෙතන ක්ලික් කරන්න',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
