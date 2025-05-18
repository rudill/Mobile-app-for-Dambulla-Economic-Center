import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(title: Text('Requests')),
      body: reservationRequests(),
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> reservationRequests() {
    return StreamBuilder(
      stream: ReservationCollection().getReservationRequests(user!.uid),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();

        final reservations = snapshot.data?.docs;

        return ListView.builder(
          itemCount: reservations?.length,
          itemBuilder: (context, index) {
            final res = reservations?[index].data() as Map<String, dynamic>;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Text('Reservation from ${res['farmerName']}'),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('Quantity is ${res['quantity']}'),
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

                                  // HiveArchive().addToHiveBoxFromForm(

                                  //
                                  //   res['farmerName'],
                                  // );

                                  HiveReservationData(
                                    index:
                                        TimeSwitcher(
                                          pickedTime: await getPickedTime(
                                            context,
                                          ),
                                        ).switchTimeToTimeSlot(),
                                    id: res['id'],
                                    quantity: res['quantity'],
                                    sellerID: res['sellerID'],
                                    farmerName: res['farmerName'],
                                    phoneNumber: res['phoneNumber'],
                                    farmerAddress: res['farmerAddress'],
                                    productID: res['productID'],
                                    farmerID: res['farmerID'],
                                    date:
                                        (res['requested date'] as Timestamp)
                                            .toDate(),
                                    totalPrice: res['totalPrice'],
                                    status: res['status'],
                                  ).addToReservationHiveBox();

                                  await ReservationCollection()
                                      .updateReservationStatus(res['id']);

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
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
