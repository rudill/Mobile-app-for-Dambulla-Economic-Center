import 'package:cloud_firestore/cloud_firestore.dart';

class RetrieveReservations {
  Stream<QuerySnapshot> getReservationRequests(int sellerID) {
    return FirebaseFirestore.instance
        .collection('reservation')
        .where('sellerID', isEqualTo: sellerID)
        .where('status', isEqualTo: 'pending')
        .snapshots();
  }
}
