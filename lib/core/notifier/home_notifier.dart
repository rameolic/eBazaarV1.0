import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thought_factory/core/data/local/app_shared_preference.dart';
import 'package:thought_factory/core/data/remote/network/app_url.dart';
import 'package:thought_factory/core/data/remote/repository/common_repository.dart';
import 'package:thought_factory/core/data/remote/repository/product_repository.dart';
import 'package:thought_factory/core/data/remote/request_response/cart/add_cart_item_product/add_cart_response.dart';
import 'package:thought_factory/core/data/remote/request_response/cart/cart_list/response_cart_list.dart';
import 'package:thought_factory/core/data/remote/request_response/cart/cart_list/response_remove_cart.dart';
import 'package:thought_factory/core/data/remote/request_response/home/category/response_custom_category.dart';
import 'package:thought_factory/core/data/remote/request_response/home/distributor/response_top_distributor.dart';
import 'package:thought_factory/core/data/remote/request_response/product/popular_product/PopularProductsResponse.dart';
import 'package:thought_factory/core/data/remote/request_response/product/productResponse.dart';
import 'package:thought_factory/core/data/remote/request_response/user/user_detail_response.dart';
import 'package:thought_factory/core/data/remote/request_response/wishlist/wish_list_item_response.dart';
import 'package:thought_factory/core/data/remote/request_response/wishlist/wish_list_response.dart';
import 'package:thought_factory/core/model/category_model.dart';
import 'package:thought_factory/core/model/cateogry_showoff_data.dart';
import 'package:thought_factory/core/model/distributor_model.dart';
import 'package:thought_factory/core/model/item_product_model.dart';
import 'package:thought_factory/state/state_drawer.dart';
import 'package:thought_factory/utils/app_common_helper_methods.dart';
import 'package:thought_factory/utils/app_constants.dart';
import 'package:thought_factory/utils/app_log_helper.dart';
import 'package:thought_factory/utils/app_network_check.dart';

import 'base/base_notifier.dart';
import 'common_notifier.dart';

class HomeNotifier extends BaseNotifier {
  final log = getLogger('HomeNotifier');

  final _repository = ProductRepository();
  final _commonRepository = CommonRepository();
  String imageUrl;
  List<CategoryModel> _lstCategory = List();
  List<DistributorModel> _lstDistributor = List();
  CategoryShowOffData categoryShowOffData;
  UserDetailResponse _userDetailByTokenResponse = UserDetailResponse();
  PopularProductsResponse _popularProductsResponse = PopularProductsResponse();
  List<ItemProduct> _lstPopularProducts = List();
  WishListResponse _wishListResponse = WishListResponse();
  StateDrawer _stateDrawer;
  String adminToken = '';
  String userToken = '';
  var _randomKey;

  String get _imageUrl => imageUrl;

  set _imageUrl(String value) {
    imageUrl = value;
    notifyListeners();
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

  List<ItemProduct> get lstPopularProducts => _lstPopularProducts;

  TextEditingController searchProductEditText = TextEditingController();
  bool _btnCancelVisible = false;
  List<ItemProduct> _lstProducts = List();
  String _currency = "";


  StateDrawer get stateDrawer => _stateDrawer;

  set stateDrawer(StateDrawer value) {
    _stateDrawer = value;
  }

  HomeNotifier () {
    randomKey = Key(randomString(20));
    initSetUp();
  }

  void initSetUp() async {
    adminToken =  await AppSharedPreference().getAdminToken();
    userToken = await AppSharedPreference().getUserToken();
    searchProductEditText.addListener(_searchController);
    callProfileImage();
  }

  set lstPopularProducts(List<ItemProduct> value) {
    _lstPopularProducts = value;
    notifyListeners();
  }

  WishListResponse get wishListResponse => _wishListResponse;

  set wishListResponse(WishListResponse value) {
    _wishListResponse = value;
    notifyListeners();
  }

  CartListResponse _cartListResponse = CartListResponse();
  int _popularProductsCount = 0;

  set popularProductsCount(int value) {
    _popularProductsCount = value;
    notifyListeners();
  }

  bool _isCategoryApiFetching = false;

  int get popularProductsCount => _popularProductsCount;

  bool _isTopDistributorApiFetching = false;

  bool get isCategoryApiFetching => _isCategoryApiFetching;

  set isCategoryApiFetching(bool value) {
    _isCategoryApiFetching = value;
    notifyListeners();
  }

  bool get isTopDistributorApiFetching => _isTopDistributorApiFetching;

  set isTopDistributorApiFetching(bool value) {
    _isTopDistributorApiFetching = value;
    notifyListeners();
  }

  CartListResponse get cartListResponse => _cartListResponse;

  PopularProductsResponse get popularProductsResponse =>
      _popularProductsResponse;

  set popularProductsResponse(PopularProductsResponse value) {
    _popularProductsResponse = value;
    notifyListeners();
  }

  ValueNotifier isCategoryListArrived = ValueNotifier(false);

  //setter getter: for category
  List<CategoryModel> get lstCategory => _lstCategory;

  set lstCategory(List<CategoryModel> value) {
    _lstCategory = value;
    notifyListeners();
  }

  //setter getter: for distributor
  List<DistributorModel> get lstDistributor => _lstDistributor;

  set lstDistributor(List<DistributorModel> value) {
    _lstDistributor = value;
    notifyListeners();
  }

  UserDetailResponse get userDetailByTokenResponse =>
      _userDetailByTokenResponse;

  set userDetailByTokenResponse(UserDetailResponse value) {
    _userDetailByTokenResponse = value;
    notifyListeners();
  }

  //getter setter: for search product
//  TextEditingController get searchProductEditText => _searchProductEditText;
//
//  set searchProductEditText(TextEditingController value) {
//    _searchProductEditText = value;
//  }

  bool get btnCancelVisible => _btnCancelVisible;

  set btnCancelVisible(bool value) {
    _btnCancelVisible = value;
    notifyListeners();
  }

  List<ItemProduct> get lstProducts => _lstProducts;

  set lstProducts(List<ItemProduct> value) {
    _lstProducts = value;
    notifyListeners();
  }

  String get currency => _currency;

  set currency(String value) {
    _currency = value;
    notifyListeners();
  }

  //api: get all category list
  void apiGetCustomCategoryList() async {
    log.i('api ::: apiGetCustomCategoryList called');
    bool isNetworkAvail = await NetworkCheck().check();
    if (isNetworkAvail) {
      isCategoryApiFetching = true;
      ResponseCustomCategory response =
      await _repository.getCustomProductCategories(userToken);
      isCategoryApiFetching = false;
      onNewGetCustomCategoryResponse(response); //category list will be filled
      getSampleCategoryBasedProductList();
    } else {
      //show error toast
      showSnackBarMessageWithContext(AppConstants.ERROR_INTERNET_CONNECTION);
    }
  }

  //api: get popular products
  Future apiGetPopularProducts() async {
    log.i('api ::: apiGetPopularProducts called');
    bool isNetworkAvail = await NetworkCheck().check();
    if (isNetworkAvail) {
      PopularProductsResponse response   =
      await _repository.getPopularProductsList(adminToken: adminToken);
      await CommonNotifier().callApiGetWishList();
      await CommonNotifier().callApiGetSubCategoryList();
      //  lstPopularProducts.clear();
      onNewGetPopularProductsResponse(response);
    } else {
      //show error toast
      showSnackBarMessageWithContext(AppConstants.ERROR_INTERNET_CONNECTION);
    }
  }

  //api: get  top distributor list
  void apiGetTopDistributorsList() async {
    log.i('api ::: apiGetTopDistributorsList called');
    bool isNetworkAvail = await NetworkCheck().check();
    if (isNetworkAvail) {
      isTopDistributorApiFetching = true;
      ResponseTopDistributor response =
      await _repository.getTopDistributorList();
      isTopDistributorApiFetching = false;
      onNewGetTopDistributorResponse(response);
    } else {
      //show error toast
      showSnackBarMessageWithContext(AppConstants.ERROR_INTERNET_CONNECTION);
    }
  }

  //api get user profile details
  Future callApiGetUserProfileDetail() async {
    log.i('api ::: GetUserProfileDetail called');
    super.isLoading = true;
    String token = await AppSharedPreference().getUserToken();
    userDetailByTokenResponse =
    await _commonRepository.apiGetUserDetailByToken(token);
    super.isLoading = false;
  }

  //api get user profile details
  Future callProfileImage() async {
    String token = await AppSharedPreference().getUserToken();
    await _commonRepository.apiGetProfileImage(token).then((value) {
      if (value.status != 0) {
        imageUrl = value.profileImage[0].data;
        stateDrawer.imageUrl = value.profileImage[0].data;
      } else {
        imageUrl = "";
      }
    });
  }

  Future callApiFirstTimeAddToCart(ItemProduct itemProduct) async {
    if (itemProduct.chosenQuantity == 0) {
      itemProduct.chosenQuantity = 1;
    }
     isLoading = true;
    AddToCartResponse response =
    await CommonNotifier().callApiAddToCart(itemProduct);
    onNewFirstTimeAddToCart(response, itemProduct);
    isLoading = false;
  }

  //api searchBar
  Future apiGetProductBySearchName(String productName) async {
    log.i('api ::: apiGetProductBySearchName called');
    ProductResponse response = await _repository.getProductBySearchName(
        productName, adminToken);
    onNewGetProductByCategoryIdResponse(response);
  }

  //api removeCart item
  void callApiRemoveCartItem(ItemProduct itemProduct) async {
    log.i('api ::: apiRemoveCart called');
      super.isLoading = true;
      try {
        RemoveCartResponse response =
        await CommonNotifier().callApiRemoveCartItem(itemProduct.itemCartId);
        super.isLoading = false;
        if (response.status == true) {
          --itemProduct.chosenQuantity;
          popularProductsCount = itemProduct.chosenQuantity;
          //refresh cart list to get count
          CommonNotifier().callApiGetCartList();
        }
      } catch(e) {
        super.isLoading = false;
        log.e(e.toString());
      }
  }

  //api add to wish list
  void callApiAddToWishList(ItemProduct itemProduct) async {
    log.i('api ::: callApiAddToWishList called');
    super.isLoading = true;
    try{
      WishListItemResponse response =
      await CommonNotifier().callApiAddToWishList(itemProduct.id.toString());
      itemProduct.isFavourite = true;
      super.isLoading = false;
      onNewAddToWishListResponse(response);
    } catch(e) {
      super.isLoading = false;
      log.e(e.toString());
    }
  }

  //api remove item from wish list
  void callApiRemoveFromWishList(ItemProduct itemProduct,
      String wishListItemId) async {
    log.i('api ::: callApiRemoveFromWishList called');
    super.isLoading = true;
    try{
      WishListItemResponse response =
      await CommonNotifier().callApiRemoveFromWishList(wishListItemId ?? '0');
      itemProduct.isFavourite = false;
      super.isLoading = false;
      onNewAddToWishListResponse(response);
    } catch(e) {
      super.isLoading = false;
      log.e(e.toString());
    }

  }

  void callApiChangeCartItemQuantity(ItemProduct itemProduct, int qty) async {
    itemProduct.chosenQuantity = qty;
     isLoading = true;
    print("---------------------------------------->   $qty");
    AddToCartResponse response =
    await CommonNotifier().callApiChangeCartItemQuantity(itemProduct);
    onNewDataChangeCartItemQuantity(response, itemProduct, qty);
    isLoading = false;
  }

  Future callApiGetWishList() async {
    isLoading = true;
    WishListResponse response =
    await CommonNotifier().callApiGetWishList();
    onNewWishListResponse(response);
  }

  void onNewDataChangeCartItemQuantity(AddToCartResponse response,
      ItemProduct itemProduct, int qty) {
    if (response != null) {
      if (response.message == null) {
        itemProduct.chosenQuantity = qty;
      } else {
        itemProduct.chosenQuantity--;
        super.showSnackBarMessageWithContext(response.message);
      }
    } else {
      super.showSnackBarMessageWithContext('Response is null');
    }
  }

  void onNewFirstTimeAddToCart(AddToCartResponse response, itemProduct) {
    if (response != null) {
      if (response.message == null) {
        if (itemProduct.chosenQuantity != 1) {
          itemProduct.chosenQuantity++;
        }
        itemProduct.itemCartId = response.itemId.toString();
      } else {
        itemProduct.chosenQuantity--;
        showSnackBarMessageWithContext(response.message);
      }
    }
  }

  void onNewGetPopularProductsResponse(PopularProductsResponse response) {
    lstPopularProducts.clear();
    if (response != null) {
      popularProductsResponse = response;
      response.data.forEach((item) {
          ItemProduct itemProduct = ItemProduct(
              id: int.parse(item.productId),
              sku: item.productSku,
              name: item.productName,
              productType: item.productType,
              isCustomProduct: item.customProduct == "false" ? false : true,
              price: (double.parse(item.productPrice)) ?? 0,
              imageUrl: item.productImage != null && item.productImage.length > 0 ? item.productImage[0] : "");
          //check & update item product if item id matched with cartH-map
          CommonNotifier().matchProductIdForPopularProducts(item, itemProduct);
          lstPopularProducts.add(itemProduct);
          log.e("fdf : " + lstPopularProducts.toString());

      });
    }
  }

  //on new data: getCustomCategory List
  void onNewGetTopDistributorResponse(ResponseTopDistributor response) {
    try {
      if (response != null &&
          response.data != null &&
          response.data.length > 0) {
        lstDistributor.clear();
        List<DistributorModel> lstTempDistributor = List();
        for (int i = 0; i < response.data.length; i++) {
          log.i("TopDistributor ----> ${response.data[i].companyLogoUrl}");
          lstTempDistributor.add(DistributorModel(
            id: int.parse(response.data[i].sellerId) ?? 0,
            name: response.data[i].publicName,
            imageUrl:
            '${AppUrl.distImageUrl}${response.data[i].companyLogoUrl}',
          ));
        }
        lstDistributor = lstTempDistributor;
      }
    } catch (exception) {
      log.e('onNewGetTopDistributorResponse : ${exception.toString()}');
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
        for (int i = 0; i < response.data.length; i++) {
          lstTempCategory.add(CategoryModel(
            id: int.parse(response.data[i].entityId) ?? 0,
            name: response.data[i].name,
            imageUrl: response.data[i].imageIconPath,
          ));
        }
        lstCategory = lstTempCategory;
      }
    } catch (exception) {
      log.e('onNewGetCategoryResponse : ${exception.toString()}');
    }
  }

  //helper: get home show off products collection
  void getSampleCategoryBasedProductList() async {
    if (_lstCategory.isNotEmpty && _lstCategory.length > 0) {
      for (CategoryModel item in _lstCategory) {
        //start api to get products
        log.i('api ::: apiGetProductByCategoryId called');
        log.i('item.id ----> ${item.id}');
        ProductResponse response =
        await _repository.getProductListByCategory(item.id, adminToken);
        log.i('options length ----> }');
        onNewGetProductListByCategoryResponse(item, response);
      }
      /* _lstCategory.forEach((item) async {
      });*/
    }
  }

  // helper: get product response
  void getItemProductList(int productId) async {
    ProductResponse response =
    await _repository.getProductListByCategory(productId, adminToken);
    log.i('options length ----> }');
    onNewGetItemProductListResponse(response);
  }

  //on new data: GetProductListByCategoryResponse
  void onNewGetProductListByCategoryResponse(CategoryModel itemCategory,
      ProductResponse response) {
    if (categoryShowOffData != null &&
        categoryShowOffData.listItemProduct != null) {
      categoryShowOffData.listItemProduct.clear();
      print("Cleared: - ${categoryShowOffData.listItemProduct.length}");
    }

    try {
      if (response != null &&
          response.items != null &&
          response.items.length > 0) {
//        if (categoryShowOffData != null && categoryShowOffData.listItemProduct != null) {
//          categoryShowOffData.listItemProduct.clear();
//        }
        List<ItemProduct> lstProducts = List();
        response.items.forEach((item) {
          log.i("ItemId -----------> $item");
          if (item.visibility == AppConstants.PRODUCT_VISIBILITY_SHOW &&
              item.typeId == AppConstants.PRODUCT_TYPE_SIMPLE && item.status == 1) {
            double specialPrice = _getSpecialPrice(item);
            ItemProduct itemProduct = ItemProduct(
                id: item.id,
                sku: item.sku,
                name: item.name,
                productType: item.typeId,
                price: (item.price.toDouble()) ?? 0,
                minQuantity: getMinQuantity(item.customAttributes),
                imageUrl: super.getThumbnailImageUrlForProduct(item),
                isCustomProduct: (item.customAttributes.length > 0 ? true : false),
                specialPrice: specialPrice != null ? specialPrice : 0.0);
            //check & update item product if item id matched with cartH-map
            CommonNotifier().matchProductId(item, itemProduct);

//            if (item.customAttributes != null &&
//                item.customAttributes.length > 0) {
//              for (int i = 0; i < item.customAttributes.length; i++) {
//                if ((item.customAttributes[i].attributeCode == "has_options") && (item.customAttributes[i].value.toString() == "1")) {
//                  itemProduct.isCustomProduct = true;
//                  break;
//                } else {
//                  itemProduct.isCustomProduct = false;
//                }
//              }
//            }
            lstProducts.add(itemProduct);
            lstProducts = lstProducts;
          }
        });

        log.i("listprodussssssssssssssssssss ----------------> $lstProducts");

        //add response to show off product list
        if (lstProducts != null && lstProducts.length > 0) {
          categoryShowOffData = CategoryShowOffData(
              id: itemCategory.id,
              name: itemCategory.name,
              listItemProduct: lstProducts);
          isCategoryListArrived.value = !isCategoryListArrived.value;
        }
      }
    } catch (exception) {
      log.e('onNewGetProductByCategoryIdResponse : ${exception.toString()}');
    }
  }

  bool isCartListAvailable() {
    if (_cartListResponse != null &&
        _cartListResponse.data != null &&
        _cartListResponse.data.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  void onNewAddToWishListResponse(WishListItemResponse response) {
    if (response != null) {}
  }

  void onNewWishListResponse(WishListResponse response) {
    if (response != null) {
      wishListResponse = response;
    }
  }

  void onNewGetItemProductListResponse(ProductResponse response) {
    if (response != null) {
      log.i("Product response -------------------------------> ");
    } else {
      log.i("Product response -------------------------------> else");
    }
  }

  _searchController() {
    print("Second text field: ${searchProductEditText.text}");
    if (searchProductEditText.text.length > 0) {
      btnCancelVisible = true;
      if (searchProductEditText.text.length > 2) {
       // apiGetProductBySearchName(searchProductEditText.text.trim());
      }
    } else {
      btnCancelVisible = false;
      //FocusScope.of(context).requestFocus(new FocusNode());
    }
  }

  void onNewGetProductByCategoryIdResponse(ProductResponse response) {
    try {
      if (response != null &&
          response.items != null &&
          response.items.length > 0) {
        lstProducts.clear();

        response.items.forEach((item) {
          if (item.visibility == AppConstants.PRODUCT_VISIBILITY_SHOW &&
              item.typeId == AppConstants.PRODUCT_TYPE_SIMPLE && item.status == 1) {
            ItemProduct itemProduct = ItemProduct(
                id: item.id,
                sku: item.sku,
                name: item.name,
                productType: item.typeId,
                price: (item.price.toDouble()) ?? 0,
                isCustomProduct:
                (item.customAttributes.length > 0 ? true : false),
                imageUrl: super.getThumbnailImageUrlForProduct(item));
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
            lstProducts.add(itemProduct);
          }
        });
      } else {
        lstProducts.clear();
      }
    } catch (exception) {
      log.e('Error => onNewGetProductByCategoryIdResponse : ${exception
          .toString()}');
    }
    randomKey = Key(randomString(20));
  }

  double _getSpecialPrice(Items item) {
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

  bool _isValidSpecialPrice(Items item, int position) {
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

  get randomKey => _randomKey;

  set randomKey(value) {
    _randomKey = value;
    notifyListeners();
  }
}
