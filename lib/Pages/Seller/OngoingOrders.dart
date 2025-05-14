import 'package:dec_app/Pages/Seller/ProductSubmitionForm.dart';
import 'package:flutter/material.dart';

import '../../Widgets/OngoingOrder_Tile.dart';
import '../../Firestore/productData.dart';

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
        stream: Database().productDetails(),
        builder: (context,snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('කිසියම් දෝෂයක් සිදුවී ඇත'));
          }

          final products = snapshot.data;
          if (products== null || products.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'කිසිදු ක්‍රියාකාරී ඇණවුමක් නැත',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
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
