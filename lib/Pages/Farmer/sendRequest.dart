import 'package:dec_app/Firestore/sellerData.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../Firestore/setReservations.dart';

class SendRequestPage extends StatefulWidget {
  final String shopName;

  const SendRequestPage({super.key, required this.shopName});

  @override
  _SendRequestPageState createState() => _SendRequestPageState();
}

class _SendRequestPageState extends State<SendRequestPage> {
  TextEditingController dateController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController itemController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController sellerController = TextEditingController();

  Map<String, dynamic>? vendorData;
  Map<String, dynamic>? sellerPhoneData;

  double totalAmount = 0.0;

  @override
  void initState() {
    super.initState();
    quantityController.addListener(_calculateTotal);
    fetchData();
    dateController = TextEditingController();
    quantityController = TextEditingController();
    itemController = TextEditingController();
    contactController = TextEditingController();
    addressController = TextEditingController();
    sellerController = TextEditingController();
  }

  void _calculateTotal() {
    final quantityText = quantityController.text;
    if (vendorData != null && quantityText.isNotEmpty) {
      final quantity = double.tryParse(quantityText) ?? 0;
      final unitPrice = double.tryParse(vendorData!['price'].toString()) ?? 0;
      setState(() {
        totalAmount = quantity * unitPrice;
      });
    } else {
      setState(() {
        totalAmount = 0;
      });
    }
  }

  Future<void> fetchData() async {
    try {
      final priceData = await getVendorData(widget.shopName);
      final phoneData = await getSellerPhoneData(widget.shopName);

      setState(() {
        vendorData = priceData;
        sellerPhoneData = phoneData;
      });
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  @override
  void dispose() {
    quantityController.removeListener(_calculateTotal);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(80),
                  ),
                ),
              ),
              Positioned(
                top: 40,
                left: 16,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back, color: Colors.white, size: 28),
                ),
              ),
            ],
          ),
          vendorData == null
              ? Padding(
            padding: const EdgeInsets.all(16),
            child: CircularProgressIndicator(),
          )
              : Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      vendorData!['shopName'] ?? '',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('හිමිකරු:',
                            style:
                            TextStyle(fontWeight: FontWeight.w500)),
                        Text(vendorData!['ownerName'] ?? ''),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('කඩ අංකය:',
                            style:
                            TextStyle(fontWeight: FontWeight.w500)),
                        Text(vendorData!['shopNumber'] ?? ''),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('දුරකථන අංකය:',
                            style:
                            TextStyle(fontWeight: FontWeight.w500)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(sellerPhoneData?['phone1'] ?? ''),
                            Text(sellerPhoneData?['phone2'] ?? ''),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        buildDateField(context),
                        SizedBox(height: 12),
                        buildTextField('ලබාදෙන ප්‍රමාණය', quantityController),
                        SizedBox(height: 12),
                        buildTextField('නම', itemController),
                        SizedBox(height: 12),
                        buildTextField('දුරකථන අංකය', contactController),
                        SizedBox(height: 12),
                        buildTextField('ලිපිනය', addressController),
                        SizedBox(height: 16),
                        buildTextField('Seller ID', sellerController),
                        Text(
                          totalAmount > 0
                              ? 'ලැබෙන මුළු මුදල: රු.${totalAmount.toStringAsFixed(2)}'
                              : 'ලැබෙන මුළු මුදල: රු.${vendorData?['price'] ?? "0"}',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () async {
                            await SendReservation(
                              quantity: int.parse(quantityController.text),
                              sellerID: int.parse(sellerController.text),
                              farmerName: itemController.text,
                              phoneNumber: int.parse(contactController.text),
                              farmerAddress: addressController.text,
                            ).createReservation(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: EdgeInsets.symmetric(
                                horizontal: 40, vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'කාලය වෙන්කරවා ගැනිම',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: label == 'ලබාදෙන ප්‍රමාණය'
          ? TextInputType.number
          : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        suffixText: label == 'ලබාදෙන ප්‍රමාණය' ? 'KG' : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
      ),
      onChanged: label == 'ලබාදෙන ප්‍රමාණය'
          ? (value) {
        _calculateTotal();
      }
          : null,
    );
  }

  Widget buildDateField(BuildContext context) {
    return TextField(
      controller: dateController,
      readOnly: true,
      decoration: InputDecoration(
        labelText: 'දිනය',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        suffixIcon: Icon(Icons.calendar_today),
      ),
      onTap: () async {
        final pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2030),
        );
        if (pickedDate != null) {
          final formatted = DateFormat('yyyy/MM/dd').format(pickedDate);
          dateController.text = formatted;
        }
      },
    );
  }
}
