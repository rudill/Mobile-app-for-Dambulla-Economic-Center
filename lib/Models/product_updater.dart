class UpdateOngoingOrder {
  final int quantity;
  final String productID;

  UpdateOngoingOrder({required this.quantity, required this.productID});

  int getUpdatedQuantity() {
    return quantity;
  }

  String getProductID() {
    return productID;
  }
}
