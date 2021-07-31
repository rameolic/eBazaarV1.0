import 'package:flutter/foundation.dart';
import 'package:thought_factory/utils/app_constants.dart';

class StateFilter with ChangeNotifier{

  String _selectedFilterItem = AppConstants.PRICE;
  bool _priceAvailable;
  bool _brandAvailable;
  bool _colorAvailable;
  bool _sizeAvailable;

  var _priceObj = PriceObject();
  var _brandObj = BrandObject();
  var _colorObject = ColorObject();
  var _sizeObject = SizeObject();

  StateFilter(
      {
        String selectedFilterItem,
        bool priceAvailable = false,
        bool brandAvailable = false,
        bool colorAvailable = false,
        bool sizeAvailable = false,
        PriceObject priceObj,
        BrandObject brandObj,
        ColorObject colorObj,
        SizeObject sizeObj
      }) {
    this._selectedFilterItem = selectedFilterItem;
    this._priceAvailable = priceAvailable;
    this._brandAvailable = brandAvailable;
    this._colorAvailable = colorAvailable;
    this._sizeAvailable = sizeAvailable;
    this._priceObj = priceObj;
    this._brandObj = brandObj;
    this._colorObject = colorObj;
    this._sizeObject = sizeObj;

  }

  String get selectedFilterItem => _selectedFilterItem;

  set selectedFilterItem(String value) {
    _selectedFilterItem = value;
    notifyListeners();
  }

  /// Project Object
  get projectObj => _priceObj;

  set projectObj(value) {
    _priceObj = value;
    notifyListeners();
  }

  /// Brand Object
  get brandObj => _brandObj;

  set brandObj(value) {
    _brandObj = value;
    notifyListeners();
  }

  /// Color Object
  get colorObject => _colorObject;

  set colorObject(value) {
    _colorObject = value;
    notifyListeners();
  }

  /// Size Object
  get sizeObject => _sizeObject;

  set sizeObject(value) {
    _sizeObject = value;
    notifyListeners();
  }

  bool get priceAvailable => _priceAvailable;

  set priceAvailable(bool value) {
    _priceAvailable = value;
    notifyListeners();
  }

  bool get brandAvailable => _brandAvailable;

  set brandAvailable(bool value) {
    _brandAvailable = value;
    notifyListeners();
  }

  bool get sizeAvailable => _sizeAvailable;

  set sizeAvailable(bool value) {
    _sizeAvailable = value;
    notifyListeners();
  }

  bool get colorAvailable => _colorAvailable;

  set colorAvailable(bool value) {
    _colorAvailable = value;
    notifyListeners();
  }

}


class PriceObject with ChangeNotifier{
  double _minPrice;
  double _maxPrice;
  double _selectedMinPrice;
  double _selectedMaxPrice;

  PriceObject({double minPrice, double maxPrice, double selectedMinPrice, double selectedMaxPrice}){
    this._minPrice = minPrice;
    this._maxPrice = maxPrice;
    this._selectedMinPrice = selectedMinPrice;
    this._selectedMaxPrice = selectedMaxPrice;
  }

  /// Min Price
  double get minPrice => _minPrice;

  set minPrice(double value) {
    _minPrice = value;
    notifyListeners();
  }

  /// Max Price
  double get maxPrice => _maxPrice;

  set maxPrice(double value) {
    _maxPrice = value;
    notifyListeners();
  }

  /// Min Selected Price
  double get selectedMinPrice => _selectedMinPrice;

  set selectedMinPrice(double value) {
    _selectedMinPrice = value;
    notifyListeners();
  }

  /// Max Selected Price
  double get selectedMaxPrice => _selectedMaxPrice;

  set selectedMaxPrice(double value) {
    _selectedMaxPrice = value;
    notifyListeners();
  }

}

class BrandObject with ChangeNotifier{
    List<String> _brandList;
    List<String> _selectedBrandsList;
    Map<String, bool> _brandCheckBoxList;
    //    {
//      'foo': true,
//      'bar': false,
//    };

    BrandObject({List<String> brandList, List<String> selectedBrandsList, Map<String, bool> brandCheckBoxList}){
      this._brandList = brandList;
      this._selectedBrandsList = selectedBrandsList;
      this._brandCheckBoxList = brandCheckBoxList;
    }

    List<String> get brandList => _brandList;

    set brandList(List<String> value) {
      _brandList = value;
      notifyListeners();
    }

    List<String> get selectedBrandsList => _selectedBrandsList;

    set selectedBrandsList(List<String> value) {
      _selectedBrandsList = value;
      notifyListeners();
    }

    Map<String, bool> get brandCheckBoxList => _brandCheckBoxList;

    set brandCheckBoxList(Map<String, bool> value) {
      _brandCheckBoxList = value;
      notifyListeners();
    }
}

class ColorObject with ChangeNotifier{
  List<String> _colorList;
  List<String> _selectedColorsList;

  ColorObject({List<String> colorList, List<String> selectedColorsList}){
    this._colorList = colorList;
    this._selectedColorsList = selectedColorsList;
  }

  List<String> get colorList => _colorList;

  set colorList(List<String> value) {
    _colorList = value;
    notifyListeners();
  }

  List<String> get selectedColorsList => _selectedColorsList;

  set selectedColorsList(List<String> value) {
    _selectedColorsList = value;
    notifyListeners();
  }

}

class SizeObject with ChangeNotifier{
  List<String> _sizeList;
  List<String> _selectedSizeList;

  SizeObject({List<String> sizeList, List<String> selectedSizeList}){
    this._sizeList = sizeList;
    this._selectedSizeList = selectedSizeList;
  }

  List<String> get sizeList => _sizeList;

  set sizeList(List<String> value) {
    _sizeList = value;
    notifyListeners();
  }

  List<String> get selectedSizeList => _selectedSizeList;

  set selectedSizeList(List<String> value) {
    _selectedSizeList = value;
    notifyListeners();
  }

}