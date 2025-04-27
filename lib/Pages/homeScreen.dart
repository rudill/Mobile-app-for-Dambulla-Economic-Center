import 'package:dec_app/Pages/OngoingOrders.dart';
import 'package:dec_app/Pages/ReservedTimeTable.dart';

import 'package:flutter/material.dart';
import 'package:dec_app/Pages/landing.dart';

import '../Hive/add_to_hive.dart';

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
                        builder: (context) => ReservedTimeSlots(),
                      ),
                    );
                  },
                  child: Text("Reserved Timetable"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OngoingOrders()),
                    );
                  },
                  child: Text("Progress Page"),
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
