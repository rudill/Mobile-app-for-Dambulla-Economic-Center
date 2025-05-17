import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SendReservation {
  int quantity;
  String sellerID;
  String farmerID;
  String productID;
  String farmerName;
  int phoneNumber;
  String farmerAddress;
  double totalPrice;
  DateTime date;

  SendReservation({
    required this.quantity,
    required this.sellerID,
    required this.farmerName,
    required this.phoneNumber,
    required this.farmerAddress,
    required this.productID,
    required this.farmerID,
    required this.totalPrice,
    required this.date
  });

  Future<ScaffoldFeatureController<SnackBar, SnackBarClosedReason>>
  createReservation(BuildContext context) async {
    try {
      final res = FirebaseFirestore.instance.collection('reservation').doc();

      await res.set({
        'id': res.id,
        'quantity': quantity,
        'farmerName': farmerName,
        'farmerID': farmerID,
        'sellerID': sellerID,
        'productID': productID,
        'farmerAddress': farmerAddress,
        'phoneNumber': phoneNumber,
        'totalPrice' :totalPrice,
        'date' :date,
        'status': 'pending',
      });
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
