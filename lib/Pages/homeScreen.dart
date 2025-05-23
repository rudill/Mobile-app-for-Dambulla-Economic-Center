import 'package:dec_app/Pages/LoginPage.dart';
import 'package:dec_app/Pages/Farmer/FarmerRegistation.dart';
import 'package:dec_app/Pages/Farmer/orderWaiting.dart';
import 'package:dec_app/Pages/Seller/SellerRegistration.dart';

import 'package:flutter/material.dart';
import 'package:dec_app/Pages/landing.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,

              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Welcome()),
                      );
                    },
                    child: Text("Welcome Page"),
                  ),

                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Farmerregistration(),
                        ),
                      );
                    },
                    child: Text("Famer Register Form"),
                  ),

                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SellerRegistration(),
                        ),
                      );
                    },
                    child: Text("Seller Register Form"),
                  ),

                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text("Login Page"),
                  ),

                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OrderWaiting()),
                      );
                    },
                    child: Text("Order Waiting"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
