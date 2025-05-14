import 'package:cloud_firestore/cloud_firestore.dart';

/// Fetch vendor data from 'priceList' collection based on shop name
Future<Map<String, dynamic>?> getVendorData(String shopName) async {
  try {
    final snapshot = await FirebaseFirestore.instance
        .collection('priceList')
        .where('shopName', isEqualTo: shopName)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.first.data();
    }
  } catch (e) {
    print('Error fetching vendor data: $e');
  }
  return null;
}

/// Fetch seller phone data from 'SellerReg' collection based on shop name
Future<Map<String, dynamic>?> getSellerPhoneData(String shopName) async {
  try {
    final snapshot = await FirebaseFirestore.instance
        .collection('SellerReg')
        .where('shopName', isEqualTo: shopName)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.first.data();
    }
  } catch (e) {
    print('Error fetching seller phone data: $e');
  }
  return null;
}
