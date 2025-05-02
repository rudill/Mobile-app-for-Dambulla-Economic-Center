import 'package:flutter/material.dart';

class ProductSubmitionForm extends StatefulWidget {
  @override
  _ProductSubmitionFormState createState() => _ProductSubmitionFormState();
}

class _ProductSubmitionFormState extends State<ProductSubmitionForm> {
  String selectedOption = 'පුරවන්න';


  final TextEditingController nameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController inputController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

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
                  Text(
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
                  Text("තෝරන්න", style: TextStyle(fontSize: 16)),
                  Row(
                    children: [
                      Radio(
                        value: 'එළවලු',
                        groupValue: selectedOption,
                        onChanged: (value) {
                          setState(() {
                            selectedOption = value!;
                          });
                        },
                      ),
                      Text("එළවලු"),
                      Radio(
                        value: 'පළතුරු',
                        groupValue: selectedOption,
                        onChanged: (value) {
                          setState(() {
                            selectedOption = value!;
                          });
                        },
                      ),
                      Text("පළතුරු"),
                    ],
                  ),
                  SizedBox(height: 10),
                  _buildTextField("එළවලු/පළතුරු නම", nameController),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(child: _buildTextField("ප්‍රමාණය", quantityController)),
                      SizedBox(width: 8),
                      Text("KG"),
                    ],
                  ),
                  SizedBox(height: 10),
                  _buildTextField("මිල", priceController, prefixText: "රු."),
                  SizedBox(height: 10),
                  _buildTextField("කඩ අංකය", inputController),
                  SizedBox(height: 10),
                  _buildTextField("දිනය", dateController, hintText: "mm/dd/yyyy"),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                      child: Text("ඇතුලත් කරන්න"),
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


  Widget _buildTextField(String label, TextEditingController controller,
      {String? prefixText, String? hintText}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
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
        size.width / 2, size.height + 20, size.width, size.height - 20);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
