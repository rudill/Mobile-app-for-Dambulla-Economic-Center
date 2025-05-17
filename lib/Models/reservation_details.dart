class ReservationDetails {
  int quantity;
  String sellerID;
  String farmerID;
  String productID;
  String farmerName;
  int phoneNumber;
  String farmerAddress;
  //String date;
  double? totalPrice;
  DateTime date;

  ReservationDetails({
    required this.quantity,
    required this.sellerID,
    required this.farmerName,
    required this.phoneNumber,
    required this.farmerAddress,
    required this.productID,
    required this.farmerID,
    required this.date,
    required this.totalPrice,
  });

  Map<String, dynamic> reservationData(String id) {
    return {
      'id': id,
      'quantity': quantity,
      'sellerID': sellerID,
      'farmerID': farmerID,
      'productID': productID,
      'farmerName': farmerName,
      'phoneNumber': phoneNumber,
      'farmerAddress': farmerAddress,
      'status': 'pending',
      'requested date': date,
      'totalPrice': totalPrice,
    };
  }
}
