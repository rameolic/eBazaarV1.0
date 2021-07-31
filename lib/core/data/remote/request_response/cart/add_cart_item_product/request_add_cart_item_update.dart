class AddCartItemQtyUpdateRequest {
  CartItem cartItem;

  AddCartItemQtyUpdateRequest({this.cartItem});

  AddCartItemQtyUpdateRequest.fromJson(Map<String, dynamic> json) {
    cartItem = json['cartItem'] != null ? new CartItem.fromJson(json['cartItem']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cartItem != null) {
      data['cartItem'] = this.cartItem.toJson();
    }
    return data;
  }
}

class CartItem {
  int itemId;
  int qty;
  int quoteId;

  CartItem({this.itemId, this.qty, this.quoteId});

  CartItem.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    qty = json['qty'];
    quoteId = json['quote_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_id'] = this.itemId;
    data['qty'] = this.qty;
    data['quote_id'] = this.quoteId;
    return data;
  }

  @override
  String toString() {
    return 'CartItem{itemId: $itemId, qty: $qty, quoteId: $quoteId}';
  }


}
