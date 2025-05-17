import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Seller {
  final String uid;
  final String email;
  final String role;

  Seller({required this.uid, required this.email, required this.role});

  factory Seller.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Seller(
      uid: doc.id,
      email: data['email'] ?? '',
      role: data['role'] ?? '',
    );
  }
}

class SellerService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signInSeller(String email, String password) async {
    final UserCredential credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential.user;
  }

  Future<Seller?> getSellerData(String uid) async {
    final doc = await _firestore.collection('Users').doc(uid).get();
    if (doc.exists && (doc.data()?['role'] == 'seller')) {
      return Seller.fromFirestore(doc);
    }
    return null;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
