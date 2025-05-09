import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../Firestore/getReservations.dart';

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
      appBar: AppBar(
        title: Text('Requests'),
      ),
      body: reservationRequests(),
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> reservationRequests() {
    return StreamBuilder(
    stream: RetrieveReservations().getReservationRequests(21),
    builder: (context, snapshot) {
      if (!snapshot.hasData) return CircularProgressIndicator();

      final reservations = snapshot.data?.docs;

      return ListView.builder(
        itemCount: reservations?.length,
        itemBuilder: (context, index) {
          final res = reservations?[index].data() as Map<String, dynamic>;
          return ListTile(
            title: Text('Reservation from ${res['farmerName']}'),
            subtitle: Text('Quantity is ${res['quantity']}'),
          );
        },
      );
    },
  );
  }
}
