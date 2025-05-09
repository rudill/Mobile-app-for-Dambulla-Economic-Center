import 'package:cloud_firestore/cloud_firestore.dart';

class RetrieveReservations {
  Stream<QuerySnapshot> getReservationRequests(int sellerID) {
    return FirebaseFirestore.instance
        .collection('reservation')
        .where('farmerID', isEqualTo: sellerID)
        .where('status', isEqualTo: 'pending')
        .snapshots();
  }
}
