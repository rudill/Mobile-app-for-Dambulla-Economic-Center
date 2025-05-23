import 'package:dec_app/Pages/Farmer/orderWaiting.dart';
import 'package:dec_app/Pages/Selection_Page.dart';

import 'package:flutter/material.dart';

import '../../Azure_Translation/translatable_text.dart';
import '../menu.dart';

class FarmerApp extends StatelessWidget {
  const FarmerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Farmer Home',
      theme: ThemeData(primarySwatch: Colors.green),
      home: FarmerHomePage(),
    );
  }
}

class FarmerHomePage extends StatelessWidget {
  FarmerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Builder(
          builder:
              (context) => IconButton(
                icon: const Icon(Icons.menu, color: Colors.green),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Menu()),
                  );
                },
              ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 120,
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

            const SizedBox(height: 80),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Selection_screen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const TranslatableText(
                  'මිල දර්ශනය ',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OrderWaiting()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const TranslatableText(
                  'වෙන් කළ කාලය',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),

            const Spacer(),
            Image.asset('assets/images/help.png'),
          ],
        ),
      ),
    );
  }
}
