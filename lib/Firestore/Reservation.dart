import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Models/reservation_details.dart';

class ReservationCollection {
  Stream<QuerySnapshot> getReservationRequests(String sellerID) {
    return FirebaseFirestore.instance
        .collection('reservation')
        .where('sellerID', isEqualTo: sellerID)
        .where('status', isEqualTo: 'pending')
        .snapshots();
  }

  Future<void> updateReservationStatus(String resID, String timeSlot) async {
    final String status = 'accepted';
    FirebaseFirestore.instance.collection('reservation').doc(resID).update({
      'status': status,
      'timeSlot': '$timeSlot:00',
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

  Future<String?> getProductName(String productID) async {
    try {
      final docSnapshot =
          await FirebaseFirestore.instance
              .collection('Product')
              .doc(productID)
              .get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data();
        return data?['name'] as String?;
      } else {
        print('No product found with ID: $productID');
      }
    } catch (e) {
      print('Error fetching product: $e');
    }
    return null;
  }

  Future<void> completeReservation(
    Map<String, dynamic> orderDetails,
    String resID,
  ) async {
    String status = 'completed';

    try {
      await FirebaseFirestore.instance
          .collection('orderHistory')
          .doc()
          .set(orderDetails);

      final querySnapshot =
          await FirebaseFirestore.instance
              .collection('orderHistory')
              .where('id', isEqualTo: resID)
              .get();

      for (final doc in querySnapshot.docs) {
        await doc.reference.update({'status': status});
      }

      await FirebaseFirestore.instance
          .collection('reservation')
          .doc(resID)
          .delete();

      print('added to history');
    } catch (e) {
      print('Failed to add to history');
    }
  }

  Future<void> rejectReservation(String resID) async {
    String status = 'rejected';

    final querySnapShots =
        await FirebaseFirestore.instance
            .collection('reservation')
            .where('id', isEqualTo: resID)
            .get();

    for (final doc in querySnapShots.docs) {
      await doc.reference.update({'status': status});
    }
  }
}
