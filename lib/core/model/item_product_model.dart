import 'package:flutter/foundation.dart';

class ItemProduct with ChangeNotifier {
  int _id;
  String _itemCartId;
  String _sku;
  String _productType;
  String _quoteId;
  String _name;
  double _price;
  String _imageUrl;
  String _description;
  int _minQuantity = 1;
  int _maxQuantity;
  int _chosenQuantity;
  bool _isFavourite;
  bool _isAddedToCompare;
  bool _productAvailability;
  bool _isCustomProduct;
  String _wishListItemId;
  double _specialPrice;

   //constructor
  ItemProduct(
      {int id,
      String itemCartId,
      String sku,
      String productType,
      String quoteId,
      String name,
      double price,
      String imageUrl = '',
      String description,
      int minQuantity,
      int maxQuantity,
      int chosenQuantity = 0,
      bool isFavourite = false,
      bool isAddedToCompare = true,
      bool productAvailability,
      bool isCustomProduct,
      String wishListItemId,
      double specialPrice}) {
    this._id = id;
    this._itemCartId = itemCartId;
    this._sku = sku;
    this._productType = productType;
    this._quoteId = quoteId;
    this._name = name;
    this._price = price;
    this._imageUrl = imageUrl;
    this._description = description;
    this._minQuantity = minQuantity;
    this._maxQuantity = maxQuantity;
    this._chosenQuantity = chosenQuantity;
    this._isFavourite = isFavourite;
    this._isAddedToCompare = isAddedToCompare;
    this._productAvailability = productAvailability;
    this._isCustomProduct = isCustomProduct;
    this._wishListItemId = wishListItemId;
    this._specialPrice = specialPrice;
  }


  double get specialPrice => _specialPrice;

  set specialPrice(double value) {
    _specialPrice = value;
  }

  String get wishListItemId => _wishListItemId;

  set wishListItemId(String value) {
    _wishListItemId = value;
  }

  bool get productAvailability => _productAvailability;

  set productAvailability(bool value) {
    _productAvailability = value;
  }

  bool get isCustomProduct => _isCustomProduct;

  set isCustomProduct(bool value) {
    _isCustomProduct = value;
  }

  //getter setter

  int get minQuantity => _minQuantity;

  set minQuantity(int value) {
    _minQuantity = value;
  }

  int get maxQuantity => this._maxQuantity;

  set maxQuantity(int value) => this._maxQuantity = value;

  String get description => this._description;

  set description(String value) => this._description = value;

  String get imageUrl => this._imageUrl;

  set imageUrl(String value) => this._imageUrl = value;

  String get name => this._name;

  set name(String value) => this._name = value;

  int get id => this._id;

  set id(int value) => this._id = value;

  double get price => this._price;

  set price(double value) => this._price = value;

  int get chosenQuantity => this._chosenQuantity;

  bool get isFavourite => this._isFavourite;

  bool get isAddedToCompare => this._isAddedToCompare;

  set isFavourite(bool value) {
    this._isFavourite = value;
    notifyListeners();
  }

  set chosenQuantity(int value) {
    this._chosenQuantity = value;
    notifyListeners();
  }

  set isAddedToCompare(bool value) {
    this._isAddedToCompare = value;
    notifyListeners();
  }

  String get sku => _sku;

  set sku(String value) {
    _sku = value;
  }

  String get quoteId => _quoteId;

  set quoteId(String value) {
    _quoteId = value;
  }

  String get productType => _productType;

  set productType(String value) {
    _productType = value;
  }

  String get itemCartId => _itemCartId;

  set itemCartId(String value) {
    _itemCartId = value;
    notifyListeners();
  }

  @override
  String toString() {
    return 'ItemProduct{_id: $_id, _itemCartId: $_itemCartId, _sku: $_sku, _productType: $_productType, _quoteId: $_quoteId, _name: $_name, _price: $_price, _imageUrl: $_imageUrl, _description: $_description, _maxQuantity: $_maxQuantity, _chosenQuantity: $_chosenQuantity, _isFavourite: $_isFavourite, _isAddedToCompare: $_isAddedToCompare, _productAvailability: $_productAvailability, _isCustomProduct: $_isCustomProduct, _wishListItemId: $_wishListItemId, _specialPrice: $_specialPrice}';
  }
}
