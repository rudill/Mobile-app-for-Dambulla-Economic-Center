import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../Firestore/reservationStatus.dart';

class OrderWaiting extends StatefulWidget {
  const OrderWaiting({super.key});

  @override
  State<OrderWaiting> createState() => _OrderWaitingState();
}

class _OrderWaitingState extends State<OrderWaiting> {

  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xFF208A43)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<List<Map<String, dynamic>>>(
              stream: OrderWaitingData().getOrderWaitingData(user!.uid),
              builder: (context, snapshot) {
                //below
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 350),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                //up

                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 500,),
                        Text(
                          'කිසිදු ක්‍රියාකාරී ඇණවුමක් නැත',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  );
                }
                return SizedBox(
                  height: 500,
                  child: PageView.builder(
                    itemCount: snapshot.data!.length,
                    controller: PageController(viewportFraction: 0.9),
                    itemBuilder: (context, index) {
                      var data = snapshot.data![index];
                      return Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 90,
                                  height: 90,
                                  child: Image(
                                    image: AssetImage(
                                      data['status'] == 'pending'
                                          ? 'assets/images/clock_icon.png'
                                          : 'assets/images/OrderAcceptTick.png',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            Row(
                              children: [
                                Text(
                                  'දිනය:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(width: 16),
                                Text('${data['date']}'),
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
                                Text(
                                  '${data['productName']}  ${data['quantity']}KG',
                                  style: TextStyle(fontSize: 16),
                                ),
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
                                Text(
                                  '${data['shopName']}',
                                  style: TextStyle(fontSize: 16),
                                ),
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
                                Text(
                                  '${data['shopNo']}',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),

                            Row(
                              children: [
                                Text(
                                  'දුරකථන අංකය: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(width: 16),
                                Text(
                                  '${data['phoneNo']}',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            SizedBox(height: 30),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    width: 380,
                                    height: 90,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF20AB43),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        data['status'] == 'pending'
                                            ? 'තහවුරු කරන තෙක් සිටින්න'
                                            : 'කාලය පෙ.ව 6.30-7.00',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
