import 'package:flutter/cupertino.dart';
import 'package:thought_factory/core/data/local/app_shared_preference.dart';
import 'package:thought_factory/core/data/remote/repository/product_repository.dart';
import 'package:thought_factory/core/data/remote/request_response/home/category/response_custom_category.dart';
import 'package:thought_factory/core/model/category_model.dart';
import 'package:thought_factory/core/model/helper/info_home_tap.dart';
import 'package:thought_factory/core/notifier/base/base_notifier.dart';
import 'package:thought_factory/ui/main/drawer/item_content.dart';
import 'package:thought_factory/utils/app_constants.dart';
import 'package:thought_factory/utils/app_network_check.dart';

import '../router.dart';

class StateDrawer extends BaseNotifier {
  String _selectedDrawerItem = AppConstants.DRAWER_ITEM_HOME;
  final _repository = ProductRepository();
  List<CategoryModel> _lstCategory = List();
  String get selectedDrawerItem => _selectedDrawerItem;
  String _selectedId = "0";
  ItemContent _itemContent;
  String _imageUrl = "";
  String userToken = "";
  ValueNotifier<InfoHomeTap> onValueChange = ValueNotifier<InfoHomeTap>(InfoHomeTap(id: null, toolBarName: null)) ;

  StateDrawer() {
    initSetUp();
  }

  initSetUp() async {
    userToken = await AppSharedPreference().getUserToken();
    await callCategoryApi();
  }

  set selectedDrawerItem(String value) {
    _selectedDrawerItem = value;
    notifyListeners();
  }

  String get selectedId => _selectedId;

  set selectedId(String value) {
    _selectedId = value;
    notifyListeners();
  }


  ItemContent get itemContent => _itemContent;

  set itemContent(ItemContent value) {
    _itemContent = value;
    notifyListeners();
  }


  String get imageUrl => _imageUrl;

  set imageUrl(String value) {
    _imageUrl = value;
    notifyListeners();
  }
  //setter getter: for category
  List<CategoryModel> get lstCategory => _lstCategory;

  set lstCategory(List<CategoryModel> value) {
    _lstCategory = value;
    notifyListeners();
  }

  //api: get all category list
  void callCategoryApi() async {
    log.i('api ::: apiGetCustomCategoryList called');
    bool isNetworkAvail = await NetworkCheck().check();
    if (isNetworkAvail) {
      ResponseCustomCategory response =
          await _repository.getCustomProductCategories(userToken);
      onNewGetCustomCategoryResponse(response);
    } else {
      //show error toast
      showSnackBarMessageWithContext(AppConstants.ERROR_INTERNET_CONNECTION);
    }
  }

  //on new data: getCustomCategory List
  void onNewGetCustomCategoryResponse(ResponseCustomCategory response) {
    if (lstCategory != null) {
      lstCategory.clear();
    }
    try {
      if (response != null &&
          response.data != null &&
          response.data.length > 0) {
        lstCategory.clear();
        List<CategoryModel> lstTempCategory = List();
        lstTempCategory.add(CategoryModel(
          id: 122,
          name: "",
          imageUrl: "",
          imageIconUrl: "",
        ));
        for (int i = 0; i < response.data.length; i++) {
          lstTempCategory.add(CategoryModel(
            id: int.parse(response.data[i].entityId) ?? 0,
            name: response.data[i].name,
            imageUrl: response.data[i].imagePath,
            imageIconUrl: response.data[i].imageIconPath
          ));
        }
        lstCategory = lstTempCategory;
      }
    } catch (exception) {
      log.e('onNewGetCategoryResponse : ${exception.toString()}');
    }
  }

}
