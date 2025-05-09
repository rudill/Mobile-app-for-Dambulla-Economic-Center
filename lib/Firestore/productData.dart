import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Models/product_model.dart';

class Database{
  final String collectionName ='Product';

  Future<void> deleteProduct(String id, BuildContext context)async{
    try {
      await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(id)
          .delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("ඔබගේ ඇණවූම ඉවත් කරන ලදි")),);
      Navigator.pop(context);
    } catch  (e){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("ඔබගේ ඇණවූම ඉවත් කිරීම අසාර්ථකයි")),
      );
    }
  }

  Future <void> updateProduct(Map <String,dynamic> productDetails, String id, BuildContext context )async{
    try{
      await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(id)
          .update(productDetails);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("ඇණවුම යාවත්කාලීන කිරීම සාර්ථකයි")),
      );
      Navigator.pop(context);

    }catch (e){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("ඇණවුම යාවත්කාලීන කිරීම අසාර්ථකයි")),
      );
    }
  }

  Stream<List<Product>> productDetails() {
    return FirebaseFirestore.instance
        .collection(collectionName)
        .snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Product.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }

}





