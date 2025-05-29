import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Azure_Translation/translatable_text.dart';

import '../../Components/productQuantityManager.dart';
import '../../Components/time_picker.dart';
import '../../Components/time_switcher.dart';
import '../../Firestore/Reservation.dart';
import '../../Models/hive_reservation_data.dart';

class NotificationsFromFireStore extends StatefulWidget {
  const NotificationsFromFireStore({super.key});

  @override
  State<NotificationsFromFireStore> createState() =>
      _NotificationsFromFireStoreState();
}

User? user = FirebaseAuth.instance.currentUser;

class _NotificationsFromFireStoreState
    extends State<NotificationsFromFireStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TranslatableText(
          "ඇණවුම් ඉල්ලීම්",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        backgroundColor: Color(0xFF208A43),
      ),
      body: reservationRequests(),
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> reservationRequests() {
    return StreamBuilder(
      stream: ReservationCollection().getReservationRequests(user!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: TranslatableText('Error: ${snapshot.error}'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData) {
          return const Center(child: TranslatableText('කිසිදු දත්තයක් නැත'));
        }

        final reservations = snapshot.data?.docs;

        return ListView.builder(
          itemCount: reservations?.length,
          itemBuilder: (context, index) {
            final res = reservations?[index].data() as Map<String, dynamic>;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    ListTile(
                      title: TranslatableText(
                        '${res['farmerName']} වෙතින් වෙන්කිරීමේ ඉල්ලීමක්',
                      ),
                     
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                        children: [
                          ActionChip(
                          
                            label: FutureBuilder<String?>(
                              future: ReservationCollection().getProductName(
                                res['productID'],
                              ),
                              builder: (context, snapshot) {
                                final productName =
                                    snapshot.data ?? 'Loading...';
                                return TranslatableText(
                                  '$productName ${res['quantity']}Kg',

                                  style: TextStyle(color: Colors.black),
                                );
                              },
                            ),
                            onPressed: () {},
                          ),
                          ActionChip(
                            label: TranslatableText(
                              'මුළු මිල Rs:${res['totalPrice']}0',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: ActionChip(
                            avatar: Icon(Icons.phone_android_outlined),
                            label: Text('0${res['phoneNumber'].toString()}'),
                          ),
                        ),
                      ],
                    ),
                
                    OverflowBar(
                      alignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              int quantity = res['quantity'];
                              String productID = res['productID'];

                              String pickedTime = await getPickedTime(context);
                              String timeSlot = pickedTime;

                              HiveReservationData(
                                index: TimeSwitcher().switchTimeToTimeSlot(
                                  pickedTime,
                                ),
                                id: res['id'],
                                quantity: res['quantity'],
                                sellerID: res['sellerID'],
                                farmerName: res['farmerName'],
                                phoneNumber: res['phoneNumber'],
                                farmerAddress: res['farmerAddress'],
                                productID: res['productID'],
                                farmerID: res['farmerID'],
                                date: (res['date'] as Timestamp).toDate(),
                                totalPrice: res['totalPrice'],
                                status: res['status'],
                                timeSlot: res['timeSlot'],
                              ).addToReservationHiveBox();

                              await ReservationCollection()
                                  .updateReservationStatus(res['id'], timeSlot);

                              ProductQuantityManager().updateFilledQuantity(
                                productID,
                                quantity,
                              );

                             
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                            ),
                            child: TranslatableText('වෙන් කරන්න'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              await ReservationCollection().rejectReservation(
                                res['id'],
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                            ),
                            child: TranslatableText('ප්රතික්ෂේප කරන්න'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              //myCard(res, context),
            );
          },
        );
      },
    );
  }

  Card myCard(Map<String, dynamic> res, BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Reservation from ${res['farmerName']}',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: Text('Quantity is ${res['quantity']}')),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        int quantity = res['quantity'];
                        String productID = res['productID'];

                        String pickedTime = await getPickedTime(context);
                        String timeSlot = pickedTime;

                        HiveReservationData(
                          index: TimeSwitcher().switchTimeToTimeSlot(
                            pickedTime,
                          ),
                          id: res['id'],
                          quantity: res['quantity'],
                          sellerID: res['sellerID'],
                          farmerName: res['farmerName'],
                          phoneNumber: res['phoneNumber'],
                          farmerAddress: res['farmerAddress'],
                          productID: res['productID'],
                          farmerID: res['farmerID'],
                          date: (res['date'] as Timestamp).toDate(),
                          totalPrice: res['totalPrice'],
                          status: res['status'],
                          timeSlot: res['timeSlot'],
                        ).addToReservationHiveBox();

                        await ReservationCollection().updateReservationStatus(
                          res['id'],
                          timeSlot,
                        );

                        ProductQuantityManager().updateFilledQuantity(
                          productID,
                          quantity,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                      child: Text('Add'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await ReservationCollection().rejectReservation(
                          res['id'],
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                      child: Text('Reject'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
