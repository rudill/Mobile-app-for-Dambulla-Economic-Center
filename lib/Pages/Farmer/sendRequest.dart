import 'package:dec_app/Pages/Farmer/orderWaiting.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../Firestore/Reservation.dart';
import '../../Firestore/setReservations.dart';
import '../../Models/reservation_details.dart';

class SendRequestPage extends StatefulWidget {
  final String shopName;
  final String ownerName;
  final String shopNumber;
  final String price;
  final String phoneNo;
  final String sellerId;

  SendRequestPage({
    required this.shopName,
    required this.ownerName,
    required this.shopNumber,
    required this.price,
    required this.phoneNo,
    required this.sellerId,
  });

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

  final String productID = 'බෝංචි';
  final String farmerID = 'ef342efxs';

  double? totalPrice;

  @override
  void initState() {
    super.initState();
    sellerController.text = widget.sellerId;

    // Set initial total to unit price
    totalPrice = double.tryParse(widget.price);

    quantityController.addListener(() {
      final qty = int.tryParse(quantityController.text);
      final unitPrice = double.tryParse(widget.price);
      if (qty != null && unitPrice != null) {
        setState(() {
          totalPrice = qty * unitPrice;
        });
      } else {
        setState(() {
          totalPrice = double.tryParse(widget.price); // fallback to unit price
        });
      }
    });
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

          // Vendor info card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
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
                      widget.shopName,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'හිමිකරු:',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Text(widget.ownerName),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'කඩ අංකය:',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Text(widget.shopNumber),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'දුරකථන අංකය:',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Text(widget.phoneNo),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Form
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
                        buildQuantityField(
                          'ලබාදෙන ප්‍රමාණය',
                          quantityController,
                        ),
                        SizedBox(height: 12),
                        buildTextField('නම', itemController),
                        SizedBox(height: 12),
                        buildTextField('දුරකථන අංකය', contactController),
                        SizedBox(height: 12),
                        buildTextField('ලිපිනය', addressController),
                        SizedBox(height: 16),
                        buildTextField('Seller ID', sellerController),
                        SizedBox(height: 16),
                        Text(
                          totalPrice != null
                              ? 'ලැබෙන මුළු මුදල රු.${totalPrice!.toStringAsFixed(2)}'
                              : 'මුළු මුදල ගණනය වීමට බලාසිටින්න',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () async {
                            await ReservationCollection().createReservation(
                              context,
                              ReservationDetails(
                                quantity: int.parse(quantityController.text),
                                sellerID: sellerController.text,
                                farmerName: itemController.text,
                                phoneNumber: int.parse(contactController.text),
                                farmerAddress: addressController.text,
                                productID: productID,
                                farmerID: farmerID,
                              ),
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OrderWaiting(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 14,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
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

  // Modified to add "KG" suffix
  Widget buildQuantityField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        suffixText: 'KG',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
      ),
      keyboardType:
          label == 'Seller ID' || label == 'දුරකථන අංකය'
              ? TextInputType.number
              : TextInputType.text,
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
          final formatted = DateFormat('MM/dd/yyyy').format(pickedDate);
          dateController.text = formatted;
        }
      },
    );
  }
}
