import 'package:dec_app/Pages/Farmer/FarmerRegistation.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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

                // Email Field
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

                // Password Field
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

                // Text Button
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

                // Sign In Button
                SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Proceed with login
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('සාර්ථකව පිවිසෙයි')),
                      );
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
