import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dec_app/Pages/Seller/ProductSubmitionForm.dart';
import 'package:flutter/material.dart';

import '../../Models/product_model.dart';
import '../../Widgets/OngoingOrder_Tile.dart';


class OngoingOrders extends StatefulWidget {
  const OngoingOrders({super.key});

  @override
  State<OngoingOrders> createState() => _OngoingOrdersState();
}

class _OngoingOrdersState extends State<OngoingOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ක්‍රියාකාරී ඇණවුම්",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),),
        backgroundColor: Color(0xFF208A43),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Product').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('කිසියම් දෝෂයක් සිදුවී ඇත'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'කිසිදු ක්‍රියාකාරී ඇණවුමක් නැත',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16), // space between text and button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductSubmitionForm(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    child: Text('නව ඇණවුමක් එක් කරන්න'),
                  ),
                ],
              ),
            );
          }

          final products = snapshot.data!.docs.map((doc) {
            return Product.fromMap(doc.data() as Map<String, dynamic>, doc.id);
          }).toList();

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return OnOrderTile(product: product);
            },
          );
        },
      ),
    );
  }
}
