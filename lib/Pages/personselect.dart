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
            padding: EdgeInsets.only(right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('asset/farmer.png'),
                    ),
                    SizedBox(height: 9),

                    Text(
                      'ගොවි මහත්මයෙක්',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),

                SizedBox(width: 50),

                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('asset/owner.png'),
                      radius: 50,
                    ),
                    SizedBox(height: 9),
                    Text(
                      'වෙළඳසැල් හිමිකරුවෙක්',
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
