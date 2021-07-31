import 'package:flutter/cupertino.dart';
import 'package:thought_factory/core/data/local/app_shared_preference.dart';
import 'package:thought_factory/core/model/filter/filter_item_model.dart';
import 'package:thought_factory/core/model/filter/filter_state_model.dart';
import 'package:thought_factory/core/notifier/base/base_notifier.dart';
import 'package:thought_factory/core/notifier/common_notifier.dart';
import 'package:thought_factory/utils/app_constants.dart';
import 'package:thought_factory/utils/app_log_helper.dart';

class BuildFilterNotifier extends BaseNotifier {
  final log = getLogger('BuildFilterNotifier');
  FilterStateModel _filterStateModel = FilterStateModel();
  String _selectedFilterItem;
  List<FilterItemModel> _allItemsList = List();
  List<FilterItemModel> _subItemsList = List();
  String _currencySymbol = "";

  //constructor
  BuildFilterNotifier(context, categoryID) {
    super.context = context;
    _setUpFilterForm();
  }

  //getter - setter : for filter page
  String get selectedFilterItem => _selectedFilterItem;

  set selectedFilterItem(String value) {
    _selectedFilterItem = value;
    notifyListeners();
  }

  List<FilterItemModel> get allItemsList => _allItemsList;

  set allItemsList(List<FilterItemModel> value) {
    _allItemsList = value;
    notifyListeners();
  }

  FilterStateModel get filterStateModel => _filterStateModel;

  set filterStateModel(FilterStateModel value) {
    _filterStateModel = value;
    notifyListeners();
  }

  List<FilterItemModel> get subItemsList => _subItemsList;

  set subItemsList(List<FilterItemModel> value) {
    _subItemsList = value;
    notifyListeners();
  }


  String get currencySymbol => _currencySymbol;

  set currencySymbol(String value) {
    _currencySymbol = value;
    notifyListeners();
  }

  /// Method
  void loadSubItemsListData() async {
    subItemsList.clear();
    var _priceItemList = allItemsList
        .where((itemsModelList) => itemsModelList.name == selectedFilterItem);
    subItemsList.addAll(_priceItemList);
  }

  void _setUpFilterForm() async {
    _currencySymbol = await _getCurrencySymbol();
    filterStateModel = CommonNotifier().filterStateModel;
    selectedFilterItem = filterStateModel.listFilterMenu.elementAt(0).name;
    allItemsList = filterStateModel.itemsModelList;
  }

  Future<String> _getCurrencySymbol() async {
    return AppSharedPreference().getPreferenceData(AppConstants.KEY_CURRENCY_CODE);
  }

  void resetFilter(){
    allItemsList.forEach((items) => items.isSelected = false);
    selectedFilterItem = filterStateModel.listFilterMenu.elementAt(0).name;
    loadSubItemsListData();
    CommonNotifier().filterStateModel.filterPriceItemModel.selectedMaxValue =
        CommonNotifier().filterStateModel.filterPriceItemModel.maxValue;
    CommonNotifier().filterStateModel.filterPriceItemModel.selectedMinValue =
        CommonNotifier().filterStateModel.filterPriceItemModel.minValue;
    Navigator.pop(context, 2);
  }
}
