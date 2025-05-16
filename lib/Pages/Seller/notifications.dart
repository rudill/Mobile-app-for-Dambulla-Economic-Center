import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../Components/time_picker.dart';
import '../../Components/time_switcher.dart';
import '../../Firestore/Reservation.dart';
import '../../Hive/HiveBase.dart';
import '../../Models/product_updater.dart';

class NotificationsFromFireStore extends StatefulWidget {
  const NotificationsFromFireStore({super.key});

  @override
  State<NotificationsFromFireStore> createState() =>
      _NotificationsFromFireStoreState();
}

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
      stream: ReservationCollection().getReservationRequests(21),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();

        final reservations = snapshot.data?.docs;

        return ListView.builder(
          itemCount: reservations?.length,
          itemBuilder: (context, index) {
            final res = reservations?[index].data() as Map<String, dynamic>;
            return
            //   ListTile(
            //   title: Text('Reservation from ${res['farmerName']}'),
            //   subtitle: Text('Quantity is ${res['quantity']}'),
            // );
            Padding(
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
                                  HiveArchive().addToHiveBoxFromForm(
                                    TimeSwitcher(
                                      pickedTime: await getPickedTime(context),
                                    ).switchTimeToTimeSlot(),

                                    res['farmerName'],
                                  );

                                  UpdateOngoingOrder(
                                    quantity: res['quantity'],
                                    productID: res['productID'],
                                  );
                                  await ReservationCollection()
                                      .updateReservationStatus(res['id']);
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
