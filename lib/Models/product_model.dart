import 'package:cloud_firestore/cloud_firestore.dart';

class Product{
  String id;
  String name;
  double price;
  int quantity;
  DateTime date;
  String shopno;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.date,
    required this.shopno,

  });

  factory Product.fromMap(Map<String, dynamic> map, String documentId) {
    return Product(
      id: documentId,
      name: map['name'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      quantity: map['quantity'] ?? 0,
      date: (map['date'] as Timestamp).toDate(),
      shopno: map['shopNo'] ?? '',
    );
  }

}