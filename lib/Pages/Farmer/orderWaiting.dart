import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../Azure_Translation/translatable_text.dart';
import '../../Firestore/reservationStatus.dart';
import 'farmerHome.dart';

class OrderWaiting extends StatefulWidget {
  const OrderWaiting({super.key});
  @override
  State<OrderWaiting> createState() => _OrderWaitingState();
}
String getTimeWithAmPm(String timeString) {
  final parts = timeString.split(':');
  int hour = int.parse(parts[0]);
  final minute = parts[1];
  final isPm = hour >= 12;
  final displayHour = hour == 0 ? 12 : hour > 12 ? hour - 12 : hour;
  final amPm = isPm ? 'PM' : 'AM';

  return '$displayHour:$minute $amPm';
}

class _OrderWaitingState extends State<OrderWaiting> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF208A43),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => FarmerApp()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<List<Map<String, dynamic>>>(
              stream: OrderWaitingData().getOrderWaitingData(user!.uid),
              builder: (context, snapshot) {

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 350),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (snapshot.hasError) {
                  return TranslatableText('Error: ${snapshot.error}');
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 500),
                        TranslatableText(
                          'කිසිදු ක්‍රියාකාරී ඇණවුමක් නැත',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  );
                }
                return SizedBox(
                  height: 450,
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
                                          : data['status'] == 'accepted'
                                          ? 'assets/images/OrderAcceptTick.png'
                                          : 'assets/images/reject2.png',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            Row(
                              children: [
                                TranslatableText(
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
                                TranslatableText(
                                  'එලවලු ප්‍රමාණය: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: TranslatableText(
                                    '${data['productName']}  ${data['quantity']}KG',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),

                            Row(
                              children: [
                                TranslatableText(
                                  'වෙලදසැල: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(width: 16),
                                TranslatableText(
                                  '${data['shopName']}',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),

                            Row(
                              children: [
                                TranslatableText(
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
                                TranslatableText(
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
                                      color: data['status'] == 'rejected' ?Colors.red : Color(0xFF20AB43),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: data['status'] == 'rejected'
                                          ? ElevatedButton(
                                        onPressed: () async {
                                          await OrderWaitingData().rejectOrder(data['resID']);
                                        },
                                        child: TranslatableText('ඔබගේ ඇනවුම ප්‍රතික්ශේප විය'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.redAccent,
                                          foregroundColor: Colors.white,
                                        ),
                                      )
                                          : TranslatableText(
                                        data['status'] == 'pending'
                                            ? 'තහවුරු කරන තෙක් සිටින්න'
                                            : 'කාලය ${getTimeWithAmPm(data['time'])}',
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

            StreamBuilder<List<Map<String, dynamic>>>(
              stream: OrderWaitingData().getPastOrders(user!.uid),
              builder: (context, snapshot) {

                if (snapshot.hasError) {
                  return TranslatableText('Error loading past orders: ${snapshot.error}');
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      // child: TranslatableText(
                      //   'පසුගිය ඇණවුම් නොමැත',
                      //   style: TextStyle(fontSize: 16),
                      // ),
                    ),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
                      child: TranslatableText(
                        'පසුගිය ඇණවුම්',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(), // prevent scroll conflict
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        var order = snapshot.data![index];
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Color(0xFF20AB43)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${order['date']}', style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500)),
                                  SizedBox(height: 4),
                                  TranslatableText('${order['productName']} ${order['quantity']}kg',
                                      style: TextStyle(fontSize: 14 ,fontWeight: FontWeight.w500)),
                                  SizedBox(height: 4),
                                  TranslatableText('${order['shopName']}', style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500)),
                                ],
                              ),
                              Text(
                                'රු. ${order['totalPrice'].toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),

    );

  }
}
