import 'package:dec_app/Pages/SellerRegistration.dart';
import 'package:flutter/material.dart';

class SellerloginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

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
                  backgroundImage: AssetImage('assets/images/owner.png'),
                  backgroundColor: Colors.grey[300],
                ),
                SizedBox(height: 12),

                Text('විකුණුම් මහතෙකු ලෙස', style: TextStyle(fontSize: 25)),
                SizedBox(height: 24),

                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'ඔබගේ විද්‍යුත් ලිපිනය',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'කරුණාකර ඔබගේ විද්‍යුත් ලිපිනය ඇතුළත් කරන්න';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'ඔබගේ රහස් අංකය',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'කරුණාකර ඔබගේ රහස් අංකය ඇතුළත් කරන්න';
                    }
                    return null;
                  },
                  obscureText: true,
                ),
                SizedBox(height: 12),

                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SellerRegistration(),
                      ),
                    );
                  },
                  child: Text('ලියාපදිංචි වී නැද්ද? මෙතන ක්ලික් කරන්න'),
                ),

                SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // If form is valid, proceed
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text('Logging in...')));
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
