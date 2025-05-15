import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dec_app/Pages/Farmer/sendRequest.dart';
import 'package:flutter/material.dart';

class PricePage extends StatelessWidget {
  final String itemName;

  PricePage({super.key, required this.itemName,});

  Stream<List<Map<String, dynamic>>> fetchProductData() async* {
    final productSnapshot = await FirebaseFirestore.instance
        .collection('Product').where('name', isEqualTo: itemName).get();

    List<Map<String, dynamic>> combinedData = [];
    for (var productDoc in productSnapshot.docs) {
      var productData = productDoc.data();


      var sellerDoc = await FirebaseFirestore.instance
          .collection('SellerReg')
          .doc(productData['sellerID'])
          .get();

      if (sellerDoc.exists) {
        var sellerData = sellerDoc.data();
        combinedData.add({
          'shopName': sellerData?['ShopName'] ,
          'ownerName': sellerData?['FullName'] ,

          'shopNo': productData['shopNo'] ,
          'quantity': productData['quantity']?.toString() ,
          'price': productData['price']?.toString() ,
        });
      }
    }
    yield combinedData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: StreamBuilder<List<Map<String, dynamic>>>(

        stream: fetchProductData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          }

          final priceData = snapshot.data!;
          return ListView.builder(
            itemCount: priceData.length,
            itemBuilder: (context, index) {
              final Color cardColor =
              index % 2 == 0 ? Color(0xFFE2F6E1) : Colors.white;
              final product = priceData[index];
              return _buildPriceCard(
                  cardColor,
                  product['shopName'],
                  product['ownerName'],
                  '${product['quantity']} Kg',
                  product['shopNo'],
                  product['price'],
                  context
              );
            },
          );
        },
      ),
    );
  }


  Widget _buildPriceCard(
      Color color,
      String shopName,
      String ownerName,
      String weight,
      String shopNumber,
      String price,
      BuildContext context,
      ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SendRequestPage(

            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.withAlpha(100)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  shopName,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    color: Color(0xFF047333),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '$weight අවශ්‍යයි',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ownerName,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'කඩ අංකය : $shopNumber',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [

                      Text(
                        '1KG රු. $price/-',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildCustomAppBar(BuildContext context) {

  return Container(
    height: 140,
    child: Stack(
      children: [
        // Curved green background
        ClipPath(
          clipper: CurvedBottomClipper(),
          child: Container(
            height: 140,
            color: Color(0xFF1B8E46), // Dark green color as in the image
            width: double.infinity,
          ),
        ),
        // Back button and title
        Positioned(
          top: 60,
          left: 10,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                // Back arrow button
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back, color: Colors.white, size: 32),
                ),
                SizedBox(width: 15),
                // Title text
                Text(
                  'වෙළඳපොළ මිල',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// Custom clipper to create the curved bottom effect for the app bar
class CurvedBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(-100, size.height - 40); // Start from bottom-left

    // Create curved path
    path.quadraticBezierTo(
      size.width / 2, // Control point x
      size.height + 50, // Control point y
      size.width, // End point x
      size.height - 70, // End point y
    );

    // Complete the path
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}