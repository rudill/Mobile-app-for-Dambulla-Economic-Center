import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Models/reservation_details.dart';

class ReservationCollection {
  Stream<QuerySnapshot> getReservationRequests(int sellerID) {
    return FirebaseFirestore.instance
        .collection('reservation')
        .where('sellerID', isEqualTo: sellerID)
        .where('status', isEqualTo: 'pending')
        .snapshots();
  }

  Future<void> updateReservationStatus(String resID) async {
    final String status = 'accepted';
    FirebaseFirestore.instance.collection('reservation').doc(resID).update({
      'status': status,
    });
  }

  Future<ScaffoldFeatureController<SnackBar, SnackBarClosedReason>>
  createReservation(BuildContext context, ReservationDetails details) async {
    try {
      final res = FirebaseFirestore.instance.collection('reservation').doc();

      await res.set(details.reservationData(res.id));
      return ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('success')));
    } catch (exception) {
      return ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('failed')));
    }
  }
}
