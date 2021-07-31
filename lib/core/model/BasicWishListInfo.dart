class BasicWishListInfo {
  String productId;
  String wishListItemId;

  BasicWishListInfo({this.productId, this.wishListItemId});

  @override
  String toString() {
    return 'BasicWishListInfo{productId: $productId, wishListItemId: $wishListItemId}';
  }
}