class ProductQuantityManager {
  static final ProductQuantityManager _instance = ProductQuantityManager._internal();
  final Map<String, int> _filledQuantities = {};

  factory ProductQuantityManager() {
    return _instance;
  }

  ProductQuantityManager._internal();

  int getFilledQuantity(String productId) {
    return _filledQuantities[productId] ?? 0;
  }

  void updateFilledQuantity(String productId, int quantity) {
    _filledQuantities[productId] = getFilledQuantity(productId) + quantity;
  }
}