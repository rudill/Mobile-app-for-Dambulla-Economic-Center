import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Firestore/auth_service.dart';
import 'Seller/sallerHome.dart';
import 'landing.dart';
import 'personselect.dart';
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
      body: Column(
        children: [
          Image(image: AssetImage("assets/images/img.png")),
          SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 60),
                  SizedBox(
                    height: 50,
                    child: Container(
                      width: double.infinity,
                      height: 10,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage('assets/images/FHbanner.png'),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 50),

                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      label: TranslatableText('ඔබගේ විද්‍යුත් ලිපිනය'),
                      border: OutlineInputBorder(),
                    ),
                    validator:
                        (value) =>
                            value!.isEmpty
                                ? 'කරුණාකර විද්‍යුත් ලිපිනය ඇතුළත් කරන්න'
                                : null,
                  ),

                  SizedBox(height: 16),

                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      label: TranslatableText('ඔබගේ මුරපදය'),
                      border: OutlineInputBorder(),
                    ),
                    validator:
                        (value) =>
                            value!.isEmpty
                                ? 'කරුණාකර රහස් අංකය ඇතුළත් කරන්න'
                                : null,
                  ),
                  SizedBox(height: 40),

                  ElevatedButton(
                    onPressed: _login,
                    child: TranslatableText('ගිණුමට පිවිසෙන්න.'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 64),
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  TextButton(
                    onPressed:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Welcome()),
                        ),
                    child: TranslatableText(
                      'ලියාපදිංචි වී නැද්ද? මෙතන ක්ලික් කරන්න',
                    ),
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
          Image(image: AssetImage('assets/images/down_shape.png')),
        ],
      ),
    );
  }
}
