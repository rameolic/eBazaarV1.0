class ItemProductDetail {
  int _id;
  String _name;
  double _price;
  String _imageUrl;
  String _description;
  int _maxQuantity;
  int _chosenQuantity;
  bool _isFavourite;
  List<String> _lstCompareTitle;
  Map<String, String> _mapCompareContent;
  bool _isAddedToCompare;

  //constructor
  ItemProductDetail(
      {int id,
      String name,
      double price,
      String imageUrl,
      String description,
      int maxQuantity,
      int chosenQuantity = 0,
      bool isFavourite = false,
      List<String> lstCompareTitle,
      Map<String, String> mapCompareContent,
      bool isAddedToCompare = false}) {
    this._id = id;
    this._name = name;
    this._price = price;
    this._imageUrl = imageUrl;
    this._description = description;
    this._maxQuantity = maxQuantity;
    this._chosenQuantity = chosenQuantity;
    this._isFavourite = isFavourite;
    this._lstCompareTitle = lstCompareTitle;
    this._mapCompareContent = mapCompareContent;
    this._isAddedToCompare = isAddedToCompare;
  }

  //getter setter

  bool get isFavourite => this._isFavourite;

  set isFavourite(bool value) => this._isFavourite = value;

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

  set chosenQuantity(int value) {
    this._chosenQuantity = value;
  }

  Map<String, String> get mapCompareContent => _mapCompareContent;

  set mapCompareContent(Map<String, String> value) => this._mapCompareContent = value;

  List<String> get lstCompareTitle => _lstCompareTitle;

  set lstCompareTitle(List<String> value) => this._lstCompareTitle = value;
}
