import 'package:flutter/material.dart';

class OrderWaiting extends StatefulWidget {
  const OrderWaiting({super.key});

  @override
  State<OrderWaiting> createState() => _OrderWaitingState();
}

class _OrderWaitingState extends State<OrderWaiting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image(image: AssetImage('assets/images/upShape.png')),
          SizedBox(height: 10),
          SizedBox(
            width: 90,
            height: 90,
            child: Image(image: AssetImage('assets/images/clock_icon.png')),
          ),

          SizedBox(height: 20),

          Container(
            padding: EdgeInsets.all(16),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'දිනය: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(width: 16),
                    Align(
                      alignment: Alignment.topRight,
                      child: Text('2024/10/24', style: TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
                SizedBox(height: 8),

                Row(
                  children: [
                    Text(
                      'එලවලු ප්‍රමාණය: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(width: 16),
                    Text('ලංකා අල 100kg', style: TextStyle(fontSize: 16)),
                  ],
                ),
                SizedBox(height: 8),

                Row(
                  children: [
                    Text(
                      'වෙලදසැල: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(width: 16),
                    Text('කීර්ති වෙළඳසැල', style: TextStyle(fontSize: 16)),
                  ],
                ),
                SizedBox(height: 8),

                Row(
                  children: [
                    Text(
                      'කඩ අංකය: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(width: 16),
                    Text('B/25', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 20),

          Container(
            width: 380,
            height: 90,
            decoration: BoxDecoration(
              color: const Color(0xFF20AB43),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                'තහවුරු කරන තෙක් සිටින්න',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Title(
            color: Colors.black,
            child: Text(
              'පසුගිය ඇනවුම්',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),

          SizedBox(height: 20),

          Container(
            //height: 90,
            width: 380,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(15),
            ),

            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '2025/01/11',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'ලීක්ස් 20kg',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'රුපියල්. 18,600.00',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 20),

          Container(
            //height: 90,
            width: 380,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(15),
            ),

            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '2025/01/10',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'කැරට් 50kg',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'රුපියල්. 15,300.00',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 20),

          Container(
            //height: 90,
            width: 380,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(15),
            ),

            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '2025/10/11',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'ලංකා අල 30kg',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'රුපියල්. 15,300.00',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
