class ReservationDetails {
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
    required this.status
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
      'status': status,
      'requested date': date,
      'totalPrice': totalPrice,
    };
  }
}
