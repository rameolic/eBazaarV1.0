class BasicPopularProductInfo {
  int cartItemId;
  int quantity;

  BasicPopularProductInfo({this.cartItemId, this.quantity});

  @override
  String toString() {
    return 'BasicCartInfo{cartItemId: $cartItemId, quantity: $quantity}';
  }
}