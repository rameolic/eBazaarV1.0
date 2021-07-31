import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thought_factory/core/data/local/app_shared_preference.dart';
import 'package:thought_factory/core/data/remote/repository/product_repository.dart';
import 'package:thought_factory/core/data/remote/request_response/cart/add_cart_item_product/add_cart_response.dart';
import 'package:thought_factory/core/data/remote/request_response/cart/cart_list/response_remove_cart.dart';
import 'package:thought_factory/core/data/remote/request_response/compare/add_or_remove_products_to_compare_response.dart';
import 'package:thought_factory/core/data/remote/request_response/compare/compare_product_list_response.dart';
import 'package:thought_factory/core/data/remote/request_response/product/filter/response_filter.dart';
import 'package:thought_factory/core/data/remote/request_response/product/popular_product/PopularProductsResponse.dart';
import 'package:thought_factory/core/data/remote/request_response/product/popular_product/PopularProductsResponse.dart'
    as prefix0;
import 'package:thought_factory/core/data/remote/request_response/product/productResponse.dart'
    as prodListResp;
import 'package:thought_factory/core/data/remote/request_response/wishlist/wish_list_response.dart';
import 'package:thought_factory/core/model/BasicWishListInfo.dart';
import 'package:thought_factory/core/model/basic_cart_info.dart';
import 'package:thought_factory/core/model/filter/filter_state_model.dart';
import 'package:thought_factory/core/model/item_product_model.dart';
import 'package:thought_factory/utils/app_common_helper_methods.dart';
import 'package:thought_factory/utils/app_constants.dart';
import 'package:thought_factory/utils/app_log_helper.dart';
import 'package:thought_factory/ui/product/build_filter_screen.dart';

import '../model/helper/info_home_tap.dart';
import 'base/base_notifier.dart';
import 'common_notifier.dart';

class ProductListNotifier extends BaseNotifier {
  final log = getLogger('ProductListNotifier');
  final _repository = ProductRepository();
  bool _isCompareModeOn = false;
  List<ItemProduct> _lstProducts = List();
  InfoHomeTap infoHomeTap = InfoHomeTap();
  bool _listVisible = true;

  TextEditingController _searchProductEditText = TextEditingController();
  bool _btnCancelVisible = false;

  WishListResponse _wishListResponse = WishListResponse();
  AddOrRemoveProductsToCompareResponse addOrRemoveProductsToCompareResponse =
      AddOrRemoveProductsToCompareResponse();
  List<ItemProduct> lstCompareProduct = List();
  List<String> _productID = List();

  List<String> get productID => _productID;
  String adminToken = '';
  var _randomKey;

  set productID(List<String> value) {
    _productID = value;
    notifyListeners();
  }

  bool get isCompareModeOn => _isCompareModeOn;

  set isCompareModeOn(bool value) {
    _isCompareModeOn = value;
    notifyListeners();
  }

  WishListResponse get wishListResponse => _wishListResponse;

  set wishListResponse(WishListResponse value) {
    _wishListResponse = value;
    notifyListeners();
  }

  TextEditingController get searchProductEditText => _searchProductEditText;

  set searchProductEditText(TextEditingController value) {
    _searchProductEditText = value;
  }

  bool get btnCancelVisible => _btnCancelVisible;

  set btnCancelVisible(bool value) {
    _btnCancelVisible = value;
    notifyListeners();
  }

  bool get listVisible => _listVisible;

  set listVisible(bool value) {
    _listVisible = value;
    notifyListeners();
  }

  List<ItemProduct> get lstProducts => _lstProducts;

  set lstProducts(List<ItemProduct> value) {
    _lstProducts = value;
    notifyListeners();
  }

  get randomKey => _randomKey;

  set randomKey(value) {
    _randomKey = value;
    notifyListeners();
  }

  ProductListNotifier(InfoHomeTap infoHomeTap, context) {
    this.context = context;
    randomKey = Key(randomString(20));
    this.infoHomeTap = infoHomeTap;
//    if (infoHomeTap.type == AppConstants.FIELD_SELLER_ID) {
//      log.i("Id --------------------> ${infoHomeTap.id}");
//      apiGetProductBySellerId(infoHomeTap.id);
//    } else if (infoHomeTap.type == AppConstants.FIELD_POPULAR_PRODUCT) {
//      apiGetPopularProducts();
//    } else {
//      apiGetProductByCategoryId(infoHomeTap.id);
//    }
    refreshProductList(infoHomeTap);
    CommonNotifier().filterDetailResponse = null;
    CommonNotifier().filterStateModel = null;
    _searchProductEditText.addListener(_searchController);
    initSetUp();
  }

  initSetUp() async {
    adminToken = await AppSharedPreference().getAdminToken();
  }

  //api calls
  void apiGetProductByCategoryId(int stCategoryID) async {
    log.i('api ::: apiGetProductByCategoryId called');
    isLoading = true;
    try{
      await CommonNotifier().callApiGetWishList();
      prodListResp.ProductResponse response =
      await _repository.getProductListByCategory(stCategoryID, adminToken);
      onNewGetProductByCategoryIdResponse(response);
      isLoading = false;
    } catch (e) {
      isLoading = false;
      log.e("Error :" + e.toString());
    }

  }

  //api get filtered products
  void apiGetProductFiltered(Map<String, String> stringParams, ) async {
    log.i('api ::: apiGetProductFiltered called');
    isLoading = true;
    prodListResp.ProductResponse response =
        await _repository.getProductListByCategoryFiltered(stringParams, adminToken);
    onNewGetProductByCategoryIdResponse(response);
    isLoading = false;
  }

  //api searchBar
  Future apiGetProductBySearchName(String productName) async {
    log.i('api ::: apiGetProductBySearchName called');
    isLoading = true;
    prodListResp.ProductResponse response =
        await _repository.getProductBySearchName(productName, adminToken);
    onNewGetProductByCategoryIdResponse(response);
    isLoading = false;
  }

  //api searchBar
  Future apiGetProductBySearchNameDistributorWise(
      String sellerID, String productName) async {
    log.i('api ::: apiGetProductBySearchNameDistributorWise called');
    isLoading = true;
    prodListResp.ProductResponse response = await _repository
        .getProductBySearchNameDistributorWise(sellerID, productName);
    onNewGetProductByCategoryIdResponse(response);
    isLoading = false;
  }

  //api filterFormDetail
  Future callAPIFilterFormDetail(String categoryId) async {
    log.i('api ::: filterFormDetail called');
    super.isLoading = true;
    try {
      if (CommonNotifier().filterDetailResponse == null) {
        FilterResponse filterDetailResponse =
            await _repository.getFiltersCategory(categoryId);
        onNewGetFilterFormDetailResponse(filterDetailResponse);
      } else {
        log.d("filterDetailResponse " +
            CommonNotifier().filterDetailResponse.data.toString());
        navigateToFilterScreen();
      }
      super.isLoading = false;
    } catch (e) {
      super.isLoading = false;
      log.e(e.toString());
    }
  }

  //api Add Products to compare
  Future apiAddToCompare(String productId) async {
    log.i('api ::: apiAddToCompare called');
    isLoading = true;
    addOrRemoveProductsToCompareResponse = null;
    addOrRemoveProductsToCompareResponse = await _repository
        .addProductsToCompare(productId, CommonNotifier().userToken);
    isLoading = false;
  }

  //api compare product list
  void apiCompareProductList(String productId1, String productId2) async {
    log.i('api ::: apiRemoveCompareProduct called');
    isLoading = true;
    CompareProductListResponse response =
        await _repository.fetchCompareProducts(CommonNotifier().userToken);
    isLoading = false;
    if (response != null) {
      // Todo
      // handle response here
      print("CompareProductList --------------> $response");
    }
  }

  // api remove from compare
  //Note: Send parameters either single or multiple Ex: 1 OR 1,2 OR All to remove all
  Future apiRemoveFromCompare(String productId1) async {
    log.i('api ::: apiRemoveFromCompare called');
    isLoading = true;
    addOrRemoveProductsToCompareResponse = null;
    addOrRemoveProductsToCompareResponse = await _repository
        .removeProductsToCompare(productId1, CommonNotifier().userToken);
    isLoading = false;
  }

  void clearCompareProductsList() async {
    //Remove Product from Compare  apiAddToCompare
    await apiRemoveFromCompare("all");
    if (addOrRemoveProductsToCompareResponse != null &&
        addOrRemoveProductsToCompareResponse.addToCompare != null) {
      if (addOrRemoveProductsToCompareResponse.addToCompare[0].status == 1 ||
          addOrRemoveProductsToCompareResponse.addToCompare[0].status == 0) {
        isCompareModeOn = !isCompareModeOn;
        lstProducts.forEach((value) => value.isAddedToCompare = true);
        _productID.clear();
      } else
        showToast(addOrRemoveProductsToCompareResponse.addToCompare[0].message);
      /*super.showSnackBarMessageWithContext(
          addOrRemoveProductsToCompareResponse.addToCompare[0].message);
    */
    } else
      showToast(addOrRemoveProductsToCompareResponse.message);
  }

  //api add to wish list
  void callApiAddToWishList(ItemProduct itemProduct) async {
    log.i('api ::: callApiAddToWishList called');
    super.isLoading = true;
    await CommonNotifier().callApiAddToWishList(itemProduct.id.toString());
    itemProduct.isFavourite = true;
    super.isLoading = false;
    //onNewAddToWishListResponse(response);
  }

  //api remove item from wish list
  void callApiRemoveFromWishList(
      ItemProduct itemProduct, String wishListItemId) async {
    log.i('api ::: callApiRemoveFromWishList called');
    super.isLoading = true;
    await CommonNotifier().callApiRemoveFromWishList(wishListItemId ?? '0');
    itemProduct.isFavourite = false;
    super.isLoading = false;
    //onNewAddToWishListResponse(response);
  }

  Future callApiGetWishList() async {
    isLoading = true;
    WishListResponse response = await CommonNotifier().callApiGetWishList();
    onNewWishListResponse(response);
  }

  void onNewWishListResponse(WishListResponse response) {
    if (response != null) {
      wishListResponse = response;
    }
  }

  // Distributor Api call
  void apiGetProductBySellerId(int sellerId) async {
    log.i('api ::: apiGetProductBySellerId called');
    isLoading = true;
    try {
      prodListResp.ProductResponse response =
          await _repository.getProductListBySellerID(sellerId, CommonNotifier().adminToken);
      onNewGetProductByCategoryIdResponse(response);
      isLoading = false;
    } catch (e) {
      log.e(e.toString());
      isLoading = false;
    }
  }

  // Popular products
  void apiGetPopularProducts() async {
    log.i('api ::: apiGetProductBySellerId called');
    isLoading = true;
    PopularProductsResponse response =
        await _repository.getPopularProductsList();
    onNewGetPopularProductResponse(response);
    isLoading = false;
  }

  Future callApiFirstTimeAddToCart(
      itemProduct, GlobalKey<ScaffoldState> scaffoldKey) async {
    //isLoading = true;
    AddToCartResponse response =
        await CommonNotifier().callApiAddToCart(itemProduct);
    onNewFirstTimeAddToCart(response, itemProduct, scaffoldKey);
    // isLoading = false;
  }

  //api removeCart item
  void callApiRemoveCartItem(ItemProduct itemProduct) async {
    log.i('api ::: apiRemoveCart called');
    // super.isLoading = true;
    RemoveCartResponse response =
        await CommonNotifier().callApiRemoveCartItem(itemProduct.itemCartId);
    //super.isLoading = false;
    if (response.status == true) {
      --itemProduct.chosenQuantity;
      //refresh cart list to get count
      CommonNotifier().callApiGetCartList();
    }
  }

  void callApiChangeCartItemQuantity(ItemProduct itemProduct, int qty) async {
    itemProduct.chosenQuantity = qty;
    //  isLoading = true;
    AddToCartResponse response =
        await CommonNotifier().callApiChangeCartItemQuantity(itemProduct);
    onNewDataChangeCartItemQuantity(response, itemProduct, qty);
    //isLoading = false;
  }

  void onNewDataChangeCartItemQuantity(
      AddToCartResponse response, ItemProduct itemProduct, int qty) {
    if (response != null) {
      if (response.message == null) {
        itemProduct.chosenQuantity = qty;
      } else {
        super.showSnackBarMessageWithContext(response.message);
      }
    } else {
      super.showSnackBarMessageWithContext('Response is null');
    }
  }

  void onNewFirstTimeAddToCart(AddToCartResponse response, itemProduct,
      GlobalKey<ScaffoldState> scaffoldKey) {
    if (response != null) {
      if (response.message == null) {
        itemProduct.chosenQuantity++;
        log.i("api cart------------> ${response.message}");
        itemProduct.itemCartId = response.itemId.toString();
      } else {
        // super.showSnackBarMessageWithContext(response.message);//_scaffoldKey
        final snackBar = new SnackBar(
          content: new Text(response.message),
          duration: Duration(seconds: 2),
        );
        scaffoldKey.currentState.showSnackBar(snackBar);
      }
    }
  }

  //on new data
  void onNewGetProductByCategoryIdResponse(
      prodListResp.ProductResponse response) {
    try {
      if (response != null &&
          response.items != null &&
          response.items.length > 0) {
        lstProducts.clear();
        List<ItemProduct> products = List();
        response.items.forEach((item) {
          if (item.visibility == AppConstants.PRODUCT_VISIBILITY_SHOW &&
              item.typeId == AppConstants.PRODUCT_TYPE_SIMPLE && item.status == 1) {
            double specialPrice = _getSpecialPrice(item);
            ItemProduct itemProduct = ItemProduct(
                id: item.id,
                sku: item.sku,
                name: item.name,
                productType: item.typeId,
                price: (item.price.toDouble()) ?? 0,
                isCustomProduct: (item.customAttributes.length > 0 ? true : false),
                imageUrl: super.getThumbnailImageUrlForProduct(item),
                minQuantity: getMinQuantity(item.customAttributes),
                specialPrice: specialPrice != null ? specialPrice : 0.0);
            CommonNotifier().matchProductId(item, itemProduct);
            if (item.customAttributes != null &&
                item.customAttributes.length > 0) {
              for (int i = 0; i < item.customAttributes.length; i++) {
                if ((item.customAttributes[i].attributeCode == "has_options") &&
                    (item.customAttributes[i].value == "1")) {
                  itemProduct.isCustomProduct = true;
                  break;
                } else {
                  //itemProduct.isCustomProduct = false;
                }
              }
            }
            products.add(itemProduct);
          }
        });
        lstProducts.addAll(products);
      }
    } catch (exception) {
      log.e('onNewGetProductByCategoryIdResponse : ${exception.toString()}');
    }
  }

  void onNewGetPopularProductResponse(PopularProductsResponse response) {
    if (response != null && response.data != null && response.data.length > 0) {
      lstProducts.clear();
      List<ItemProduct> products = List();
      response.data.forEach((value) {
        ItemProduct itemProduct = ItemProduct(
            id: int.parse(value.productId),
            name: value.productName,
            sku: value.productSku,
            price: double.parse(value.productPrice),
            productAvailability: value.productAvability,
            imageUrl: value.productImage[0],
            isCustomProduct: value.customProduct != null && value.customProduct == "true" ? true : false,
            productType: value.productType);

        matchProductId(value, itemProduct);
        products.add(itemProduct);
      });
      lstProducts.addAll(products);
    }
  }

  void onNewGetFilterFormDetailResponse(FilterResponse filterDetailResponse) {
    if (filterDetailResponse != null &&
        filterDetailResponse.data != null &&
        filterDetailResponse.data.length > 0) {
      CommonNotifier().filterDetailResponse = filterDetailResponse;
      CommonNotifier().filterStateModel =
          FilterStateModel(filterDetailResponse: filterDetailResponse);
      navigateToFilterScreen();
    }
  }

  void onCompareProductChanged(List<String> listProductID) {
    isLoading = true;
    lstProducts.forEach((value) {
      if (listProductID.contains(value.id.toString())) {
        value.isAddedToCompare = false;
      } else {
        value.isAddedToCompare = true;
      }
    });
    _productID.clear();
    _productID.addAll(listProductID);
    notifyListeners();
    isLoading = false;
  }

  //helper: match with h-map & update item product values
  void matchProductId(prefix0.Data data, ItemProduct itemProduct) {
    try {
      if (CommonNotifier().hmCartBasicInfo.containsKey(data.productId)) {
        BasicCartInfo basicCartInfo =
            CommonNotifier().hmCartBasicInfo[data.productId.toString()];
        itemProduct.itemCartId = basicCartInfo.cartItemId != null
            ? basicCartInfo.cartItemId.toString()
            : '0';
        itemProduct.chosenQuantity = basicCartInfo.quantity ?? 0;
      }

      if (CommonNotifier().hmWishListInfo.containsKey(data.productId)) {
        BasicWishListInfo basicWishListInfo =
            CommonNotifier().hmWishListInfo[data.productId];
        log.i("hmwishlist -------------> $basicWishListInfo");
        itemProduct.isFavourite =
            basicWishListInfo.productId != null ? true : false;
        itemProduct.wishListItemId = basicWishListInfo.wishListItemId ?? 0;
      }
    } catch (e) {
      log.e(e.toString());
    }
  }

  _searchController() async {
    print("Second text field: ${_searchProductEditText.text}");
    if (_searchProductEditText.text.length > 0) {
      btnCancelVisible = true;
      if (_searchProductEditText.text.length > 2) {
        if (infoHomeTap.type == AppConstants.FIELD_SELLER_ID) {
          log.d("seller based api hit");
          apiGetProductBySearchNameDistributorWise(
              infoHomeTap.id.toString(), _searchProductEditText.text.trim());
        } else {
          log.d("api hit");
          apiGetProductBySearchName(_searchProductEditText.text.trim());
        }
      }
    } else {
      btnCancelVisible = false;
      refreshProductList(infoHomeTap);
    }
  }

  Future refreshProductList(InfoHomeTap infoHomeTap) {
    if (infoHomeTap.type == AppConstants.FIELD_SELLER_ID) {
      log.i("Id --------------------> ${infoHomeTap.id}");
      apiGetProductBySellerId(infoHomeTap.id);
    } else if (infoHomeTap.type == AppConstants.FIELD_POPULAR_PRODUCT) {
      apiGetPopularProducts();
    } else {
      apiGetProductByCategoryId(infoHomeTap.id);
    }
    return null;
  }

  void navigateToFilterScreen() {
    Navigator.pushNamed(context, BuildFilterScreen.routeName).then((val) {
      updateList(val);
    });
  }

  void updateList(int val) async {
    if (val != null) {
      try {
        int length = CommonNotifier()
            .filterStateModel
            .itemsModelList
            .where((obj) => obj.isSelected == true)
            .toList()
            .length;
        if (val == 1) {
          //applyButton
          log.d("applyPressed");
          if (length > 0 ||
              (CommonNotifier().filterStateModel.filterPriceItemModel !=
                      null) &&
                  ((CommonNotifier()
                              .filterStateModel
                              .filterPriceItemModel
                              .minValue !=
                          CommonNotifier()
                              .filterStateModel
                              .filterPriceItemModel
                              .selectedMinValue) ||
                      (CommonNotifier()
                              .filterStateModel
                              .filterPriceItemModel
                              .maxValue !=
                          CommonNotifier()
                              .filterStateModel
                              .filterPriceItemModel
                              .selectedMaxValue))) {
            _loadFilteredProducts(length);
          }
        } else {
          //resetButton
          log.d("resetPressed");
          //if(length > 0) {
          refreshProductList(infoHomeTap);
          //}
        }
      } catch (e) {
        log.e("Error :" + e);
      }
    } else {
      log.d("Pressed but null");
    }
  }

  void _loadFilteredProducts(int length) {
    int index = 1;
    Map<String, String> stringParams = {};

    //category params
    stringParams['searchCriteria[filterGroups][0][filters][0][field]'] =
        '${AppConstants.FIELD_CATEGORY_ID}';
    stringParams['searchCriteria[filterGroups][0][filters][0][value]'] =
        '${infoHomeTap.id}';
    stringParams['searchCriteria[filterGroups][0][filters][0][conditionType]'] =
        '${AppConstants.CONDITION_TYPE_EQUAL}';

    //filter params
    CommonNotifier().filterStateModel.itemsModelList.forEach((filterItem) {
      if (filterItem.isSelected == true &&
          filterItem.name != AppConstants.PRICE) {
        stringParams[
                'searchCriteria[filterGroups][$index][filters][0][field]'] =
            '${filterItem.code}';
        stringParams[
                'searchCriteria[filterGroups][$index][filters][0][value]'] =
            '${filterItem.id}';
        stringParams[
                'searchCriteria[filterGroups][$index][filters][0][conditionType]'] =
            '${AppConstants.CONDITION_TYPE_EQUAL}';
        ++index;
      }
    });

    //price params
    if (CommonNotifier().filterStateModel.filterPriceItemModel != null &&
        ((CommonNotifier().filterStateModel.filterPriceItemModel.minValue !=
                CommonNotifier()
                    .filterStateModel
                    .filterPriceItemModel
                    .selectedMinValue) ||
            (CommonNotifier().filterStateModel.filterPriceItemModel.maxValue !=
                CommonNotifier()
                    .filterStateModel
                    .filterPriceItemModel
                    .selectedMaxValue))) {
      var filterItem = CommonNotifier().filterStateModel.filterPriceItemModel;
      stringParams['searchCriteria[filterGroups][$index][filters][0][field]'] =
          '${filterItem.code}';
      stringParams['searchCriteria[filterGroups][$index][filters][0][value]'] =
          '${filterItem.selectedMinValue}';
      stringParams[
              'searchCriteria[filterGroups][$index][filters][0][conditionType]'] =
          '${AppConstants.CONDITION_TYPE_FROM}';
      ++index;
      stringParams['searchCriteria[filterGroups][$index][filters][0][field]'] =
          '${filterItem.code}';
      stringParams['searchCriteria[filterGroups][$index][filters][0][value]'] =
          '${filterItem.selectedMaxValue}';
      stringParams[
              'searchCriteria[filterGroups][$index][filters][0][conditionType]'] =
          '${AppConstants.CONDITION_TYPE_TO}';
    }

    stringParams['searchCriteria[pageSize]'] = '50';
    stringParams['searchCriteria[currentPage]'] = '1';
    print('filter params ' + stringParams.toString());
    apiGetProductFiltered(stringParams);
  }

  double _getSpecialPrice(prodListResp.Items item) {
    if (item.customAttributes != null && item.customAttributes.length > 0) {
      for (int i = 0; i < item.customAttributes.length; i++) {
        if (item.customAttributes[i].attributeCode ==
                AppConstants.CUSTOM_ATTRIBUTE_SPECIAL_PRICE &&
            _isValidSpecialPrice(item, i)) {
          return double.parse(item.customAttributes[i].value ?? null);
        } else {
          return null;
        }
      }
      return 0.0;
    } else {
      return null;
    }
  }

  bool _isValidSpecialPrice(prodListResp.Items item, int position) {
    if (item.customAttributes[position].attributeCode ==
        AppConstants.CUSTOM_ATTRIBUTE_SPECIAL_PRICE) {
      String fromDate = "";
      String toDate = "";
      for (int index = 0; index < item.customAttributes.length; index++) {
        if (item.customAttributes[index].attributeCode ==
            AppConstants.CUSTOM_ATTRIBUTE_SPECIAL_FROM_DATE) {
          fromDate = item.customAttributes[index].value;
        }

        if (item.customAttributes[index].attributeCode ==
            AppConstants.CUSTOM_ATTRIBUTE_SPECIAL_TO_DATE) {
          toDate = item.customAttributes[index].value;
        }
      }
      if (fromDate.isNotEmpty && toDate.isNotEmpty) {
        return _isDateExpired(fromDate, toDate);
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  bool _isDateExpired(String fromDateInString, String toDateInString) {
    try {
      DateTime fromDate, toDate, currentDate;
      DateFormat dateFormat =
          DateFormat("yyyy-MM-dd hh:mm:ss"); // 2019-09-12 00:00:00
      fromDate = dateFormat.parse(fromDateInString);
      toDate = dateFormat.parse(toDateInString);
      currentDate = DateTime.now();

      log.d(
          "differ From " + fromDate.difference(currentDate).inDays.toString());
      log.d("differ To " + toDate.difference(currentDate).inDays.toString());
      log.d("differ current " + toDate.day.toString());

      if (currentDate.isAfter(fromDate) &&
          (currentDate.isBefore(toDate) ||
              toDate.difference(currentDate).inDays == 0)) {
        log.d("differ : Offer available");
        return true;
      } else {
        log.d("differ : Offer Expired");
        return false;
      }
    } catch (e) {
      log.e("Error " + e.toString());
      return false;
    }
  }

  String randomString(int length) {
    var rand = new Random();
    var codeUnits = new List.generate(
        length,
            (index){
          return rand.nextInt(33)+89;
        }
    );
    return new String.fromCharCodes(codeUnits);
  }
}
