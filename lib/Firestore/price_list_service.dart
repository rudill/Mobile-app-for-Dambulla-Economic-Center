import 'package:cloud_firestore/cloud_firestore.dart';

class PriceListService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Map<String, dynamic>>> getPriceList(String itemName) async* {
    try {

      final productSnapshot =
      await _firestore
          .collection('Product')
          .where('name', isEqualTo: itemName)
          .get();

      List<Map<String, dynamic>> combinedData = [];

      for (var productDoc in productSnapshot.docs) {
        var productData = productDoc.data();

        var sellerDoc =
        await _firestore
            .collection('SellerReg')
            .doc(productData['sellerID'])
            .get();

        if (sellerDoc.exists) {
          var sellerData = sellerDoc.data();
          combinedData.add({
          'shopName': sellerData?['ShopName'] ?? '',
          'ownerName': sellerData?['FullName'] ?? '',
          'phoneNo':sellerData?['Phno']??'',
          'sellerId':productData['sellerID'],
          'shopNumber': productData['shopNo'] ?? '',
          'weight': '${productData['quantity']?.toString() ?? ''} Kg',
          'price': productData['price']?.toString()??'',
          });
        }
      }

      yield combinedData;
    } catch (e) {
      print('Error fetching price list: $e');
      yield [];
    }
  }
}
