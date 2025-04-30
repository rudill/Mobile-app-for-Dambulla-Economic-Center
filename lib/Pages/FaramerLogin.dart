import 'package:dec_app/Pages/FarmerRegistation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: LoginPage(), debugShowCheckedModeBanner: false));
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.0),
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
                backgroundImage: AssetImage('asset/img_2.png'),
                backgroundColor: Colors.grey[300],
              ),
              SizedBox(height: 12),

              Text('ගොවි මහතෙකු ලෙස', style: TextStyle(fontSize: 25)),
              SizedBox(height: 24),

              // Email Field
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'ඔබගේ විද්‍යුත් ලිපිනය',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),

              // Password Field
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'ඔබගේ රහස් අංකය',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
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

              // Sign Up Button
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {},
                child: Text('ගිණුමට පිවිසෙන්න.'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 64),
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ), // full width
              ),
            ],
          ),
        ),
      ),
    );
  }
}
