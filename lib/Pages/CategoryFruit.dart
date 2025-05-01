import 'package:flutter/material.dart';

class CategoryFruit extends StatelessWidget {
  final List<Map<String, String>> fruitList = [
    {
      "name": "අප්පල්",
      "image": "https://images.pexels.com/photos/102104/pexels-photo-102104.jpeg"
    },
    {
      "name": "කෙසෙල්",
      "image": "https://images.pexels.com/photos/41957/bananas-fruits-food-healthy-41957.jpeg"
    },
    {"name": "දොඩම්", "image": "assets/orange.png"},
    {"name": "අඹ", "image": "assets/mango.png"},
    {"name": "පේර", "image": "assets/guava.png"},
    {"name": "දුරියන්", "image": "assets/durian.png"},
    {"name": "අනනස්", "image": "assets/pineapple.png"},
    {"name": "අංගුරු", "image": "assets/grapes.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: [
          ClipPath(
            clipper: BottomWaveClipper(),
            child: Container(
              height: 160,
              width: double.infinity,
              color: Color(0xFF208A43),
              child: SafeArea(
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Fruits",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(height: 180),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.tune, color: Colors.grey[800]),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'සෙවීම',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Icon(Icons.search, color: Colors.grey[800]),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    children: fruitList.map((fruit) {
                      final imagePath = fruit["image"]!;
                      final isNetwork = imagePath.startsWith('http');

                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(2, 2),
                            )
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            isNetwork
                                ? Image.network(imagePath,
                                height: 60, fit: BoxFit.contain)
                                : Image.asset(imagePath,
                                height: 60, fit: BoxFit.contain),
                            SizedBox(height: 8),
                            Text(
                              fruit["name"]!,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 20);
    path.quadraticBezierTo(
        size.width / 2, size.height + 20, size.width, size.height - 20);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
