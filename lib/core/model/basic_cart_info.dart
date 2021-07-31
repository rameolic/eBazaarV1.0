class BasicCartInfo {
  int cartItemId;
  int quantity;

  BasicCartInfo({this.cartItemId, this.quantity});

  @override
  String toString() {
    return 'BasicCartInfo{cartItemId: $cartItemId, quantity: $quantity}';
  }
}