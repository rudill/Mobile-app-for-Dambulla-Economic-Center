import 'package:flutter/material.dart';

import '../../Firestore/Reservation.dart';
import '../../Hive/HiveBase.dart';

class ReservationInfo extends StatelessWidget {
  final int index;
  const ReservationInfo({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final reservation = HiveArchive().getReservationDetails(index);

    return Scaffold(
      appBar: AppBar(title: const Text('Reservation Information')),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          child: Card(
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/faramer1.jpg'),
                      radius: 48,
                      //backgroundColor: Colors.orange[200],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: Text(
                      reservation?['farmerName'] ?? '',
                      style: Theme.of(
                        context,
                      ).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        // color: Colors.orange[800],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  _buildInfoRow(
                    'Farmer Name',
                    reservation?['farmerName'] ?? '',
                  ),
                  _buildInfoRow(
                    'Phone Number',
                    reservation?['phoneNumber'].toString() ?? '',
                  ),
                  _buildInfoRow('Address', reservation?['farmerAddress'] ?? ''),
                  FutureBuilder<String?>(
                    future: ReservationCollection().getProductName(
                      reservation?['productID'],
                    ),
                    builder: (context, snapshot) {
                      final productName = snapshot.data ?? 'Loading...';
                      return _buildInfoRow('Product', productName);
                    },
                  ),
                  _buildInfoRow(
                    'Quantity',
                    reservation?['quantity'].toString() ?? '',
                  ),
                  _buildInfoRow('Date', reservation?['date'].toString() ?? ''),
                  _buildInfoRow(
                    'Total Price',
                    'Rs. ${reservation?['totalPrice'].toString() ?? ''}',
                  ),
                  _buildInfoRow('Status', reservation?['status'] ?? ''),
                  const SizedBox(height: 32),

                  ElevatedButton(
                    onPressed: () {
                      ReservationCollection().completeOrder(
                        reservation!,
                        reservation['id'],
                      );
                      HiveArchive().resBox.delete(index);
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[700],
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Complete Order'),
                  ),

                  Row(children: [const Spacer()]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Chip buildChip(Map<String, dynamic>? reservation) {
    return Chip(
      label: Text(
        reservation?['status'] ?? '',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.orange[700],
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    );
  }

  Widget _buildInfoRow(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              '$label:',
              textAlign: TextAlign.start,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
