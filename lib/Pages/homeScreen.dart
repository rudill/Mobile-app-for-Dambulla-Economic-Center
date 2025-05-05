import 'package:dec_app/Pages/CategoryFruit.dart';
import 'package:dec_app/Pages/CategoryVegetable.dart';
import 'package:dec_app/Pages/Farmer/FaramerLogin.dart';
import 'package:dec_app/Pages/Farmer/FarmerRegistation.dart';
import 'package:dec_app/Pages/Seller/SellerLogin.dart';
import 'package:dec_app/Pages/Seller/SellerRegistration.dart';
import 'package:dec_app/Pages/Farmer/farmerHome.dart';
import 'package:dec_app/Pages/priceList.dart';
import 'package:dec_app/Pages/Seller/sallerHome.dart';
import 'package:dec_app/Pages/Farmer/sendRequest.dart';

import 'package:flutter/material.dart';
import 'package:dec_app/Pages/landing.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: Column(
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
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  },
                  child: Text("Farmer Login Page"),
                ),

                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SellerloginPage(),
                      ),
                    );
                  },
                  child: Text("Seller Login Page"),
                ),




                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryVegetable(),
                      ),
                    );
                  },
                  child: Text("Vegetable Category"),
                ),

                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryFruit(),
                      ),
                    );
                  },
                  child: Text("Fruit Category"),
                ),

                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PricePage(),
                      ),
                    );
                  },
                  child: Text("Price List"),
                ),

                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SendRequestPage(),
                      ),
                    );
                  },
                  child: Text("Send Request"),
                ),

                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FarmerApp(),
                      ),
                    );
                  },
                  child: Text("farmer home"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => sallerApp(),
                      ),
                    );
                  },
                  child: Text("Seller Home"),
                ),
                // ElevatedButton(
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => HiveForm()),
                //     );
                //   },
                //   child: Text('Add to hive base'),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
