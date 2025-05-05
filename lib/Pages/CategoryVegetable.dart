import 'package:flutter/material.dart';

class CategoryVegetable extends StatelessWidget {
  final List<Map<String, String>> vegList = [
    {
      "name": "ලොකු ළුණු",
      "image": "https://cdn.pixabay.com/photo/2021/02/06/17/02/red-onion-5988726_1280.jpg"
    },
    {
      "name": "තක්කාලි",
      "image": "https://images.pexels.com/photos/53588/tomatoes-vegetables-food-frisch-53588.jpeg"
    },
    {"name": "ලංකා අල", "image": "https://cdn.pixabay.com/photo/2018/12/06/05/42/potato-3859166_1280.jpg"},
    {"name": "වට්ටක්කා", "image": "https://cdn.pixabay.com/photo/2018/12/06/05/42/potato-3859166_1280.jpg"},
    {"name": "මාළු මිරිස්", "image": "https://cdn.pixabay.com/photo/2018/12/06/05/42/potato-3859166_1280.jpg"},
    {"name": "කරවිල", "image": "https://cdn.pixabay.com/photo/2018/12/06/05/42/potato-3859166_1280.jpg"},
    {"name": "කැරට්", "image": "https://cdn.pixabay.com/photo/2018/12/06/05/42/potato-3859166_1280.jpg"},
    {"name": "බෝංචි", "image": "https://cdn.pixabay.com/photo/2018/12/06/05/42/potato-3859166_1280.jpg"},
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
                        "Vegetables",
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

          // Main content
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
                            hintText: 'search',
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
                    children: vegList.map((veg) {
                      final imagePath = veg["image"]!;
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
                              veg["name"]!,
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
