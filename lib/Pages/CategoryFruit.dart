import 'package:dec_app/Pages/translation_helper.dart';
import 'package:flutter/material.dart';

class CategoryFruit extends StatelessWidget {
  CategoryFruit({super.key});

  final List<Map<String, String>> fruitListSinhala = [
    {
      "name": "ඇඹුල් කෙසෙල්",
      "image":
      "https://img.freepik.com/free-photo/bananas-white-background_1187-1671.jpg",
    },
    {
      "name": "කොමඩු",
      "image":
      "https://img.freepik.com/free-psd/fruits-composition-isolated_23-2151856344.jpg",
    },
    {
      "name": "දිවුල්",
      "image":
      "https://img.freepik.com/free-photo/three-fresh-apples-wooden-piece_114579-55620.jpg",
    },
    {
      "name": "ගස්ලබු",
      "image":
      "https://img.freepik.com/free-photo/papaya-fruit-isolated_1203-6805.jpg",
    },
    {
      "name": "පැණි දොඩම්",
      "image":
      "https://img.freepik.com/free-photo/fresh-green-lime-bamboo-basket-isolated-white-background_1150-6168.jpg",
    },
    {
      "name": "අලිගැට පේර",
      "image":
      "https://img.freepik.com/free-photo/avocado-set-isolated-white-surface_24972-1136.jpg",
    },
    {
      "name": "පේර",
      "image": "https://img.freepik.com/free-photo/guava-fruit_74190-2534.jpg",
    },
    {
      "name": "නෙල්ලි",
      "image": "https://img.freepik.com/free-photo/guava-fruit_74190-2534.jpg",
    },
  ];

  Future<List<Map<String, String>>> _getTranslatedFruits(
      BuildContext context,
      ) async {
    final Map<String, String> nameMap = {
      for (var item in fruitListSinhala) item['name']!: item['name']!,
    };

    final translatedNames = await translateLabels(context, nameMap);

    return fruitListSinhala
        .map(
          (fruit) => {
        "name": translatedNames[fruit["name"]] ?? fruit["name"]!,
        "image": fruit["image"]!,
      },
    )
        .toList();
  }

  Future<String> _getTranslatedSearchText(BuildContext context) async {
    final labels = await translateLabels(context, {"search": "සෙවීම"});
    return labels["search"] ?? "සෙවීම";
  }

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
              color: const Color(0xFF208A43),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 8),
                      const Text(
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
              const SizedBox(height: 180),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: FutureBuilder<List<dynamic>>(
                    future: Future.wait([
                      _getTranslatedFruits(context),
                      _getTranslatedSearchText(context),
                    ]),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text("Error loading translations"),
                        );
                      } else {
                        final translatedList =
                        snapshot.data![0] as List<Map<String, String>>;
                        final searchHint = snapshot.data![1] as String;

                        return Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.tune, color: Colors.grey[800]),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: searchHint,
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  Icon(Icons.search, color: Colors.grey[800]),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Expanded(
                              child: GridView.count(
                                crossAxisCount: 2,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                children:
                                translatedList.map((fruit) {
                                  final imagePath = fruit["image"]!;
                                  final isNetwork = imagePath.startsWith(
                                    'http',
                                  );
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(
                                        12,
                                      ),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 4,
                                          offset: Offset(2, 2),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        isNetwork
                                            ? Image.network(
                                          imagePath,
                                          height: 110,
                                          fit: BoxFit.contain,
                                        )
                                            : Image.asset(
                                          imagePath,
                                          height: 110,
                                          fit: BoxFit.contain,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          fruit["name"]!,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        );
                      }
                    },
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
      size.width / 2,
      size.height + 20,
      size.width,
      size.height - 20,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}