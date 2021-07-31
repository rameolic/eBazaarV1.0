import 'item_product_model.dart';

class CategoryShowOffData {
  int _id;
  String _name;
  List<ItemProduct> _listItemProduct = List();

  //constructor
  CategoryShowOffData({int id, String name, List<ItemProduct> listItemProduct}) {
    this._id = id;
    this._name = name;
    this._listItemProduct = listItemProduct;
  }

  //getter setter
  int get id => this._id;

  set id(int value) => this._id = value;

  String get name => this._name;

  set name(String value) => this._name = value;

  List<ItemProduct> get listItemProduct => _listItemProduct;

  set listItemProduct(List<ItemProduct> value) {
    _listItemProduct = value;
  }
}
