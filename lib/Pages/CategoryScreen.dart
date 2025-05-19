import 'package:dec_app/Pages/priceList.dart';
import 'package:flutter/material.dart';
import 'package:dec_app/Azure_Translation/translatable_text.dart';
import '../Firestore/categoryImage.dart';
import '../Models/productDetails.dart';

class CategoryScreen extends StatelessWidget {
  final bool isVegetable;

  CategoryScreen({required this.isVegetable});

  @override
  Widget build(BuildContext context) {
    final list = isVegetable ? vegList : fruitList;
    return Scaffold(
      appBar: AppBar(
        title: TranslatableText(
          isVegetable ? "එලවළු" : "පලතුරු",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        backgroundColor: Color(0xFF208A43),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: list.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => PricePage(itemName: list[index]["name"]!),
                ),
              );
            },

            child: FutureBuilder<String>(
              future: FirebaseService.getImageUrl(list[index]["image"]!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError ||
                    !snapshot.hasData ||
                    snapshot.data!.isEmpty) {
                  return Card(
                    child: Column(
                      children: [
                        Icon(
                          Icons.image_not_supported,
                          size: 100,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 8),
                        TranslatableText(
                          list[index]["name"]!,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return Card(
                  child: Column(
                    children: [
                      Image.network(
                        snapshot.data!,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 8),
                      TranslatableText(
                        list[index]["name"]!,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
