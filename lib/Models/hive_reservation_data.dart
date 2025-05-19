import 'package:hive_ce/hive.dart';

class HiveReservationData {
  int index;
  String id;
  int quantity;
  String sellerID;
  String farmerID;
  String productID;
  String farmerName;
  int phoneNumber;
  String farmerAddress;
  double? totalPrice;
  DateTime date;
  String status;

  HiveReservationData({
    required this.index,
    required this.id,
    required this.quantity,
    required this.sellerID,
    required this.farmerName,
    required this.phoneNumber,
    required this.farmerAddress,
    required this.productID,
    required this.farmerID,
    required this.date,
    required this.totalPrice,
    required this.status,
  });

  final resBox = Hive.box('reservations');

  Map<String, dynamic> get hiveData => {
    'index': index,
    'id': id,
    'quantity': quantity,
    'sellerID': sellerID,
    'farmerID': farmerID,
    'productID': productID,
    'farmerName': farmerName,
    'phoneNumber': phoneNumber,
    'farmerAddress': farmerAddress,
    'status': status,
    'requested date': date,
    'totalPrice': totalPrice,
  };

  Future<void> addToReservationHiveBox() async {
    try {
      await resBox.put(hiveData['index'], hiveData);
      print('added to hive');
    } catch (e) {
      print('error');
    }
  }
}
