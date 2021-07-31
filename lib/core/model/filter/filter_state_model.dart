import 'package:thought_factory/core/data/remote/request_response/product/filter/response_filter.dart';
import 'package:thought_factory/ui/main/drawer/item.dart';
import 'package:thought_factory/utils/app_constants.dart';

import 'filter_item_model.dart';
import 'filter_item_price_model.dart';

class FilterStateModel {
  List<ItemContent> _listFilterMenu = List();
  FilterResponse filterResponse = FilterResponse();
  List<FilterItemModel> _itemsModelList = List();
  FilterPriceItemModel _filterPriceItemModel = FilterPriceItemModel();

  FilterStateModel({FilterResponse filterDetailResponse}) {
    this.filterResponse = filterDetailResponse;
    _setUpData();
  }

  // getter - setter : for Filter State Model

  List<ItemContent> get listFilterMenu => _listFilterMenu;

  set listFilterMenu(List<ItemContent> value) {
    _listFilterMenu = value;
  }

  List<FilterItemModel> get itemsModelList => _itemsModelList;

  set itemsModelList(List<FilterItemModel> value) {
    _itemsModelList = value;
  }

  FilterPriceItemModel get filterPriceItemModel => _filterPriceItemModel;

  set filterPriceItemModel(FilterPriceItemModel value) {
    _filterPriceItemModel = value;
  }

  void _setUpData() {
    if (filterResponse != null &&
        filterResponse.data != null &&
        filterResponse.data.length > 0) {
      var filterNameList =
          filterResponse.data.map((value) => value.name).toList();
      _listFilterMenu.clear();

      _listFilterMenu =
          filterNameList.map((name) => ItemContent(name: name)).toList();
      _setUpDataList(_listFilterMenu);
    }
  }

  void _setUpDataList(List<ItemContent> listFilterMenu) {
    _itemsModelList.clear();
    for (int i = 0; i < filterResponse.data.length; i++) {
      String _name = filterResponse.data[i].name;
      for (int j = 0; j < filterResponse.data[i].items.length; j++) {
        _itemsModelList.add(FilterItemModel(
            id: filterResponse.data[i].items[j].id,
            code: filterResponse.data[i].items[j].code,
            display: filterResponse.data[i].items[j].display,
            minPrice: filterResponse.data[i].items[j].minPrice != null
                ? double.parse(filterResponse.data[i].items[j].minPrice)
                : 0,
            maxPrice: filterResponse.data[i].items[j].maxPrice != null
                ? double.parse(filterResponse.data[i].items[j].maxPrice)
                : 0,
            isSelected: false,
            name: _name));
      }
    }

    try {
      var _priceItemList = _itemsModelList
          .where((itemsModelList) => itemsModelList.name == AppConstants.PRICE);
      if (_priceItemList.isNotEmpty) {
        var priceList = _priceItemList.elementAt(0).display.split(' - ');
        //AED. 0.00 - AED. 999.99
        if (_priceItemList.elementAt(0).minPrice != null &&
            _priceItemList.elementAt(0).maxPrice != null) {
          // (priceList.length == 2 && priceList[0].length > 5 && priceList[1].length > 5) {
//              double minimumPrice =
//                  double.parse(priceList[0].substring(5, priceList[0].length).trim());
//              double maxPrice =
//                  double.parse(priceList[1].substring(5, priceList[1].length).trim());
          double minimumPrice = _priceItemList.elementAt(0).minPrice;
          double maxPrice = _priceItemList.elementAt(0).maxPrice;
          _filterPriceItemModel = FilterPriceItemModel(
              code: _priceItemList.elementAt(0).code,
              maxValue: maxPrice,
              minValue: minimumPrice,
              selectedMaxValue: maxPrice,
              selectedMinValue: minimumPrice);
          print(
              "MaxValue " + _filterPriceItemModel.selectedMaxValue.toString());
        } else {
          _filterPriceItemModel = null;
        }
      } else {
        _filterPriceItemModel = null;
      }
    } catch (e) {
      print("error " + e);
      _filterPriceItemModel = null;
    }
  }
}

class ItemContent extends Item {
  String name;

  ItemContent({this.name});

  @override
  int getViewType() {
    return AppConstants.APP_DRAWER_TYPE_ITEM;
  }
}
