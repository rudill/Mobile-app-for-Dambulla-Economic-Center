import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class OrderWaitingData {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Map<String, dynamic>>> getOrderWaitingData(String farmerID) {
    return _firestore
        .collection('reservation')
        .where('farmerID', isEqualTo: farmerID)
        .snapshots()
        .asyncMap((orderSnapshot) async {
      List<Map<String, dynamic>> combinedData = [];

      for (var orderDoc in orderSnapshot.docs) {
        var orderData = orderDoc.data();

        var sellerFuture = _firestore.collection('SellerReg').doc(orderData['sellerID']).get();
        var productFuture = _firestore.collection('Product').doc(orderData['productID']).get();

        var sellerDoc = await sellerFuture;
        var productDoc = await productFuture;

        var sellerData = sellerDoc.data();
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
            'time': orderData['timeSlot'] ?? "",
            'resID': orderDoc.id,
          });
        }
      }

      return combinedData;
    });
  }

  Stream<List<Map<String, dynamic>>> getPastOrders(String farmerID) {
    return _firestore
        .collection('orderHistory')
        .where('farmerID', isEqualTo: farmerID)
        .where('status', isEqualTo: 'completed')
        .snapshots()
        .asyncMap((orderSnapshot) async {
      List<Map<String, dynamic>> combinedData = [];

      for (var orderDoc in orderSnapshot.docs) {
        var orderData = orderDoc.data();

        var sellerFuture = _firestore.collection('SellerReg').doc(orderData['sellerID']).get();
        var productFuture = _firestore.collection('Product').doc(orderData['productID']).get();

        var sellerDoc = await sellerFuture;
        var productDoc = await productFuture;

        var sellerData = sellerDoc.data();
        var productData = productDoc.data();

        String formattedDate = '';
        if (orderData['date'] is Timestamp) {
          DateTime dateTime = (orderData['date'] as Timestamp).toDate();
          formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
        }

        if (sellerDoc.exists) {
          combinedData.add({
            'shopName': sellerData?['ShopName'] ?? '',
            'productName': productData?['name'],
            'quantity': orderData['quantity'],
            'date': formattedDate,
            'totalPrice': orderData['totalPrice'],
          });
        }
      }

      return combinedData;
    });
  }

  Future<void> rejectOrder(String id,)async{
    try {
      await FirebaseFirestore.instance
          .collection('reservation')
          .doc(id)
          .delete();
    } catch  (e){
      print('Error$e');
    }
  }

}
