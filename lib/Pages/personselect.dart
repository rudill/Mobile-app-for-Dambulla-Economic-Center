import 'package:dec_app/Pages/Farmer/FarmerRegistation.dart';
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
          Image(image: AssetImage("assets/images/img.png")),

          SizedBox(
            height: 200,
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
                      radius: 60,
                      backgroundImage: AssetImage('assets/images/farmer.png'),
                    ),
                    SizedBox(height: 13),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shadowColor: const Color.fromRGBO(0, 0, 0, 10),
                        elevation: 10,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Farmerregistration(),
                          ),
                        );
                      },
                      child: Text(
                        'ගොවි මහත්මයෙක්',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(width: 30),

                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/owner.png'),
                      radius: 60,
                    ),
                    SizedBox(height: 9),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shadowColor: const Color.fromRGBO(0, 0, 0, 10),
                        elevation: 10,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Farmerregistration(),
                          ),
                        );
                      },
                      child: Text(
                        "වෙළඳසැල් හිමිකරුවෙක්",
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Spacer(),
          Image(image: AssetImage('assets/images/down_shape.png')),
        ],
      ),
    );
  }
}
