import 'package:flutter/material.dart';

class Person extends StatefulWidget {
  const Person({super.key});

  @override
  State<Person> createState() => _PersonState();
}

class _PersonState extends State<Person> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image(image: AssetImage("asset/img.png")),

          SizedBox(
            height: 220,
            child: Center(
              child: Text(
                "ඔබ ?",
                style: TextStyle(
                  fontSize: 47,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                  fontFamily: 'RobotoMono',
                ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Row(
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage('asset/img_2.png'),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'ගොවි මහත්මයෙක්',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Spacer(),
          Image(image: AssetImage("asset/img_1.png")),
        ],
      ),
    );
  }
}
