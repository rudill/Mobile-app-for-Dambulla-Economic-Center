import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class OrderWaitingData {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Map<String, dynamic>>> getOrderWaitingData(
    String farmerID,
  ) async* {
    try {
      final orderSnapshot =
          await _firestore
              .collection('reservation')
              .where('farmerID', isEqualTo: farmerID)
              .get();

      List<Map<String, dynamic>> combinedData = [];

      for (var orderDoc in orderSnapshot.docs) {
        var orderData = orderDoc.data();

        var sellerDoc =
            await _firestore
                .collection('SellerReg')
                .doc(orderData['sellerID'])
                .get();
        var sellerData = sellerDoc.data();

        var productDoc =
            await _firestore
                .collection('Product')
                .doc(orderData['productID'])
                .get();
        var productData = productDoc.data();

        String formattedDate = '';
        if (orderData['date'] is Timestamp) {
          DateTime dateTime = (orderData['date'] as Timestamp).toDate();
          formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
        }

        if (sellerDoc.exists) {
          combinedData.add({
            'shopName': sellerData?['ShopName'] ?? '',
            'phoneNo': sellerData?['PhoneNo'] ?? '',
            'shopNo': productData?['shopNo'] ?? '',
            'productName': productData?['name'],
            'quantity': orderData['quantity'],
            'status': orderData['status'],
            'date': formattedDate,
          });
        }
      }

      yield combinedData;
    } catch (e) {
      print('Error: $e');
      yield [];
    }
  }
}
