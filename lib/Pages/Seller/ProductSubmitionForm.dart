import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../Azure_Translation/translatable_text.dart';
import '../../Firestore/productData.dart';
import '../../Models/productDetails.dart';

class ProductSubmitionForm extends StatefulWidget {
  @override
  _ProductSubmitionFormState createState() => _ProductSubmitionFormState();
}

class _ProductSubmitionFormState extends State<ProductSubmitionForm> {
  String selectedOption = 'veg';
  String selectedItem = 'කැරට්';
  User? user = FirebaseAuth.instance.currentUser;

  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController shopNoController = TextEditingController();
  late TextEditingController dateController = TextEditingController();

  void initState() {
    super.initState();
    dateController = TextEditingController(
      text: DateFormat('yyyy-MM-dd').format(DateTime.now()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ClipPath(
            clipper: BottomWaveClipper(),
            child: Container(
              padding: EdgeInsets.only(top: 50, bottom: 20),
              width: double.infinity,
              color: Colors.green,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: 10),
                  TranslatableText(
                    'ඇණවුම් එක් කිරීම',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TranslatableText("තෝරන්න", style: TextStyle(fontSize: 16)),
                  Row(
                    children: [
                      Radio(
                        value: 'veg',
                        groupValue: selectedOption,
                        onChanged: (value) {
                          setState(() {
                            selectedOption = value!;
                            selectedItem = vegItems.first;
                          });
                        },
                      ),
                      TranslatableText("එළවලු"),
                      Radio(
                        value: 'fruit',
                        groupValue: selectedOption,
                        onChanged: (value) {
                          setState(() {
                            selectedOption = value!;
                            selectedItem = fruitItems.first;
                          });
                        },
                      ),
                      TranslatableText("පළතුරු"),
                    ],
                  ),
                  SizedBox(height: 10),
                  if (selectedOption == 'veg' || selectedOption == 'fruit')
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black45),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: DropdownButtonFormField<String>(
                        value: selectedItem,
                        decoration: InputDecoration(
                          label:TranslatableText( "${selectedOption == 'veg' ? 'එළවලු' : 'පළතුරු'} නම",),

                          labelStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none,
                        ),
                        items:
                            (selectedOption == 'veg' ? vegItems : fruitItems)
                                .map((String item) {
                                  return DropdownMenuItem<String>(
                                    value: item,
                                    child: TranslatableText(item),
                                  );
                                })
                                .toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedItem = newValue!;
                          });
                        },
                      ),
                    ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField("ප්‍රමාණය", quantityController),
                      ),
                      SizedBox(width: 8),
                      Text("KG"),
                    ],
                  ),
                  SizedBox(height: 20),
                  _buildTextField("මිල", priceController, prefixText: "රු."),
                  SizedBox(height: 20),
                  _buildTextField("කඩ අංකය", shopNoController),
                  SizedBox(height: 20),
                  _buildTextField(
                    "දිනය",
                    dateController,
                    hintText: "YYYY-MM-DD",
                  ),
                  SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () async {
                        Map<String, dynamic> productdetails = {
                          'price': double.parse(priceController.text),
                          'quantity': int.parse(quantityController.text),
                          'name': selectedItem,
                          'shopNo': shopNoController.text,
                          'date': DateTime.parse(dateController.text),
                          'sellerID': user!.uid,
                        };
                        Database().addProduct(productdetails, context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                      child: TranslatableText("ඇතුලත් කරන්න"),
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

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    String? prefixText,
    String? hintText,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        label: TranslatableText(label),
        prefixText: prefixText,
        hintText: hintText,
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green, width: 2),
        ),
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
