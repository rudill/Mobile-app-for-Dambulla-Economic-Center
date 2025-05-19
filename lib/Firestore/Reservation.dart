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
}
