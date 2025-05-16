import 'package:flutter/material.dart';
import '../Firestore/price_list_service.dart';
import 'Farmer/sendRequest.dart';

class PricePage extends StatelessWidget {
  final String itemName;
  final PriceListService _priceListService = PriceListService();

  PricePage({super.key, required this.itemName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Column(
        children: [
          _buildCustomAppBar(context),
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: _priceListService.getPriceList(itemName),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No data available'));
                }

                final priceData = snapshot.data!;
                return ListView.builder(
                  itemCount: priceData.length,
                  itemBuilder: (context, index) {
                    final Color cardColor =
                    index % 2 == 0 ? Color(0xFFE2F6E1) : Colors.white;
                    final data = priceData[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => SendRequestPage(
                                  shopName: data['shopName'],
                                  ownerName: data['ownerName'],
                                  shopNumber: data['shopNumber'],
                                  price: data['price'],
                                  phoneNo: data['phoneNo'],
                                  sellerId: data['sellerId']
                                ),
                          ),
                        );
                      },
                      child: _buildPriceCard(
                        cardColor,
                        data['shopName'],
                        data['ownerName'],
                        data['weight'],
                        data['shopNumber'],
                        data['price'],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
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
      ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  shopName,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
          SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ownerName,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Text(
                      'කඩ අංකය : $shopNumber',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
                      'කිලෝවක මිළ.',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'රු $price/-',
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
