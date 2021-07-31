import 'dart:collection';

import 'package:thought_factory/core/data/local/app_shared_preference.dart';
import 'package:thought_factory/core/data/remote/repository/common_repository.dart';
import 'package:thought_factory/core/data/remote/repository/manage_payment_repository.dart';
import 'package:thought_factory/core/data/remote/request_response/basic_info/basic_info_response.dart';
import 'package:thought_factory/core/data/remote/request_response/cart/add_cart_item_product/add_cart_response.dart';
import 'package:thought_factory/core/data/remote/request_response/cart/add_cart_item_product/request_add_cart_item_update.dart';
import 'package:thought_factory/core/data/remote/request_response/cart/cart_list/response_cart_list.dart';
import 'package:thought_factory/core/data/remote/request_response/cart/cart_list/response_remove_cart.dart';
import 'package:thought_factory/core/data/remote/request_response/cart/quote_id/cart_quote_id_response.dart';
import 'package:thought_factory/core/data/remote/request_response/cart/set_shipping/set_shipping_response.dart';
import 'package:thought_factory/core/data/remote/request_response/common/country_list_response.dart';
import 'package:thought_factory/core/data/remote/request_response/manage_payment/add_new_card_request.dart';
import 'package:thought_factory/core/data/remote/request_response/manage_payment/remove_card_response.dart';
import 'package:thought_factory/core/data/remote/request_response/product/filter/response_filter.dart';
import 'package:thought_factory/core/data/remote/request_response/product/popular_product/PopularProductsResponse.dart'
    as DataMatch;
import 'package:thought_factory/core/data/remote/request_response/sub_category/response_sub_category_list.dart';
import 'package:thought_factory/core/data/remote/request_response/termsandcondition/terms_condition_response.dart';
import 'package:thought_factory/core/data/remote/request_response/user/user_detail_response.dart';
import 'package:thought_factory/core/data/remote/request_response/wishlist/wish_list_item_response.dart';
import 'package:thought_factory/core/data/remote/request_response/wishlist/wish_list_response.dart';
import 'package:thought_factory/core/model/BasicWishListInfo.dart';
import 'package:thought_factory/core/model/basic_cart_info.dart';
import 'package:thought_factory/core/model/basic_popular_product_info.dart';
import 'package:thought_factory/core/model/filter/filter_state_model.dart';
import 'package:thought_factory/core/model/item_product_model.dart';
import 'package:thought_factory/utils/app_constants.dart';
import 'package:thought_factory/utils/app_log_helper.dart';
import 'package:thought_factory/core/data/remote/request_response/product/productResponse.dart'
    as ItemMatch;

import 'base/base_notifier.dart';

class CommonNotifier extends BaseNotifier {
  CommonNotifier._internal();

  static final CommonNotifier _singleInstance = CommonNotifier._internal();

  factory CommonNotifier() => _singleInstance;

  final _log = getLogger('CommonNotifier');

  //common needed values for app
  final _commonRepository = CommonRepository();
  String _adminToken = '';
  String _userToken = '';
  String _quoteId = '';
  String _userCountry;
  String _userState;
  String _cartCount;
  String _termsandCondition = "";
  String _privacyPolicy = "";
  UserDetailResponse _userDetail;
  CountryListResponse _countryListResponse;
  List<PaymentMethods> _lstPaymentMethods = List();
  FilterResponse _filterDetailResponse = FilterResponse();
  FilterStateModel _filterStateModel = FilterStateModel();
  String _cookieIdShipmentTax = "";

  CartListResponse _cartListResponse;
  SubCategoryListResponse _subCategoryListResponse;
  HashMap<String, BasicCartInfo> hmCartBasicInfo = HashMap();
  HashMap<String, BasicPopularProductInfo> hmPopularProductInfo = HashMap();
  HashMap<String, BasicWishListInfo> hmWishListInfo = HashMap();

  CartListResponse get cartListResponse => _cartListResponse;

  String get termsandCondition => _termsandCondition;

  set termsandCondition(String token) {
    this._termsandCondition = token.isNotEmpty ? token : '';
  }

  String get privacyPolicy => _privacyPolicy;

  set privacyPolicy(String token) {
    this._privacyPolicy = token.isNotEmpty ? token : '';
  }

  set cartListResponse(CartListResponse value) {
    _cartListResponse = value;
    notifyListeners();
  }

  List<PaymentMethods> get lstPaymentMethods => _lstPaymentMethods;

  set lstPaymentMethods(List<PaymentMethods> value) {
    _lstPaymentMethods = value;
    log.i('updated : lstPaymentMethods');
  }

  FilterResponse get filterDetailResponse => _filterDetailResponse;

  set filterDetailResponse(FilterResponse value) {
    _filterDetailResponse = value;
    //notifyListeners();
  }

  FilterStateModel get filterStateModel => _filterStateModel;

  set filterStateModel(FilterStateModel value) {
    _filterStateModel = value;
    // notifyListeners();
  }

  UserDetailResponse get userDetail => _userDetail;

  set userDetail(UserDetailResponse value) {
    _userDetail = value;
    log.i('updated : userProfileInfo');
  }

  String get adminToken => _adminToken;

  set adminToken(String token) {
    this._adminToken = token.isNotEmpty ? token : '';
    log.i('updated : admin token = ${this._adminToken}');
  }

  String get userToken => _userToken;

  set userToken(String token) {
    this._userToken = token.isNotEmpty ? token : '';
    log.i('updated : user token = ${this._userToken}');
  }

  String get cookieIdShipmentTax => _cookieIdShipmentTax;

  set cookieIdShipmentTax(String value) {
    _cookieIdShipmentTax = value;
    log.i(
        'updated : Cookie id of EstimateShippmentTax = ${this._cookieIdShipmentTax}');
  }

  String get quoteId => _quoteId;

  set quoteId(String quoteId) {
    this._quoteId = quoteId.isNotEmpty ? quoteId : '';
    log.i('updated : quoteId = ${this._quoteId}');
  }

  String get userCountry => _userCountry;

  set userCountry(String value) {
    this._userCountry = value.isNotEmpty ? value : '';
    log.i('updated : userCountry = ${this._userCountry}');
  }

  String get userState => _userState;

  set userState(String value) {
    this._userState = value.isNotEmpty ? value : '';
    log.i('updated : userState = ${this._userState}');
  }

  CountryListResponse get countryListResponse => _countryListResponse;

  set countryListResponse(CountryListResponse value) {
    _countryListResponse = value;
    log.i(
        'updated : countryListResponse with count = ${this._countryListResponse.listCountryInfo.length}');
  }

  String get cartCount => _cartCount;

  set cartCount(String value) {
    _cartCount = value;
    notifyListeners();
    log.i('updated : cartCount = $value');
  }

  SubCategoryListResponse get subCategoryListResponse =>
      _subCategoryListResponse;

  set subCategoryListResponse(SubCategoryListResponse value) {
    _subCategoryListResponse = value;
    notifyListeners();
  }

  //api: add to cart
  Future<AddToCartResponse> callApiChangeCartItemQuantity(
      ItemProduct itemProduct) async {
    _log.i('api ::: callApiChangeCartItemQuantity called');
    super.isLoading = true;
    AddCartItemQtyUpdateRequest request = AddCartItemQtyUpdateRequest(
        cartItem: CartItem(
            itemId: itemProduct.id,
            qty: itemProduct.chosenQuantity,
            quoteId: int.parse(quoteId)));

    AddToCartResponse response = await _commonRepository.changeCartItemQty(
        request, itemProduct.itemCartId, adminToken);
    super.isLoading = false;
    //refresh for cart count
    callApiGetCartList();
    return response;
  }

  // api:

  //api: get cart qoute id
  Future<void> callApiBasicInfoResponse() async {
    _log.i('api ::: callApiBasicInfoResponse called');
    super.isLoading = true;
    log.d("AdminToken : $adminToken");
    BasicInfoResponse response =
        await _commonRepository.getBasicInfo(adminToken);
    if (response != null) {
      AppSharedPreference().save(AppConstants.KEY_CURRENCY_CODE,
          response.basicInfo[0].baseCurrencyCode);
    } else {
      print("failed ------>");
    }
  }

  //api: get cart qoute id
  Future<void> callApiGetCartQuoteIdResponse(String userToken) async {
    _log.i('api ::: apiCartQuoteId called');
    super.isLoading = true;
    CartQuoteIDResponse response =
        await _commonRepository.getCartQuoteID(userToken);
    if (response.message == null && response.quoteId.isNotEmpty) {
      //success case, save it in share pref for future use
      AppSharedPreference().saveCartQuoteId(response.quoteId);
      //update quote id in local variable
      quoteId = await AppSharedPreference().getCartQuoteId();
    } else {
      //failure case
      _log.e('api ::: apiCartQuoteId failed');
    }
  }

  //for Termsandcondition
  Future<TermsConditionResponse> callTermsAndCondition(String id) async {
    isLoading = true;
    TermsConditionResponse response = await _commonRepository
        .apiTermsAndCondition(CommonNotifier().adminToken, id);
    isLoading = false;
    return response;
  }

  // get wish list
  Future<WishListResponse> callApiGetWishList() async {
    log.i('api ::: GetWishList called');
    super.isLoading = true;
    WishListResponse response =
        await _commonRepository.apiGetWishList(CommonNotifier().userToken);
    onNewWishListResponse(response);
    super.isLoading = false;
    return response;
  }

  callListUrlResponse() async {
    await _commonRepository.apiAllListURL().then((value) {
      if (value != null) {
        _termsandCondition = value.items[0].data.termsConditionId.toString();
        _privacyPolicy = value.items[0].data.privacyPolicId.toString();
      }
    });
  }

  //api: get country list
  Future<CountryListResponse> callApiGetCountriesList() async {
    log.i('api ::: apiGetCountriesList called');
    CountryListResponse response = await _commonRepository.getCountriesList();
    onNewGetCountryListResponse(response);
    return response;
  }

  //api: get add to cart list
  Future<AddToCartResponse> callApiAddToCart(ItemProduct itemProduct) async {
    log.i('api ::: callApiAddToCart called');
    AddToCartResponse response = await _commonRepository.apiAddItemToCart(
        CommonNotifier().userToken, itemProduct);
    callApiGetCartList();
    return response;
  }

  //api: get add to wish list
  Future<WishListItemResponse> callApiAddToWishList(String productId) async {
    log.i('api ::: callApiAddToWishList called');
    WishListItemResponse response = await _commonRepository.addToWishList(
        CommonNotifier().userToken, productId);
    return response;
  }

  //api: get add to wish list
  Future<WishListItemResponse> callApiRemoveFromWishList(
      String productId) async {
    log.i('api ::: callApiRemoveFromWishList called');
    WishListItemResponse response = await _commonRepository
        .removeItemFromWishList(CommonNotifier().userToken, productId);
    return response;
  }

  //api removeCart item
  Future<RemoveCartResponse> callApiRemoveCartItem(String itemId) async {
    log.i('api ::: apiRemoveCart called');
    RemoveCartResponse response =
        await _commonRepository.apiRemoveCartItem(itemId);
    return response;
  }

  //api removeCard item
  Future<RemoveCardResponse> callApiRemoveCardItem(String itemId) async {
    log.i('api ::: apiRemoveCart called');
    RemoveCardRequest removeCardRequest = RemoveCardRequest(
        removeCard: RemoveCard(
      card_id: itemId,
      //   phoneNumber: textEditConPhoneNumber.text,
    ));
    RemoveCardResponse response =
        await _commonRepository.apiRemoveCardItem(removeCardRequest);
    return response;
  }

  //api: get cart list
  Future<CartListResponse> callApiGetCartList() async {
    log.i('api ::: GetCartList called');
    try {
      CartListResponse response = await _commonRepository.getCartList(
          CommonNotifier().userToken, CommonNotifier().quoteId);
      onNewCartListResponse(response);
      return response;
    } catch (e) {
      return CartListResponse(status: 0);
    }
  }

  // get sub category list
  Future<SubCategoryListResponse> callApiGetSubCategoryList() async {
    log.i('api ::: GetSubCategoryList called');
    super.isLoading = true;
    subCategoryListResponse = await _commonRepository
        .apiGetSubCategoryDetail(CommonNotifier().adminToken);
    super.isLoading = false;
    return subCategoryListResponse;
  }

  //on new data: of get cart list API
  void onNewCartListResponse(CartListResponse response) {
    try {
      if (response != null) {
        print("cartitem --------------------------> $response");
        cartListResponse = response;
        cartCount = '${response.cartCount ?? '0'}';
        fillCartItemHashMapValues(response);
      }
    } catch (e) {
      log.e(e.toString());
    }
  }

  //helper: fill cartHashMap for easy match product & update its values
  void fillCartItemHashMapValues(CartListResponse response) {
    hmCartBasicInfo.clear();
    response.data.forEach((item) {
      item.productList.forEach((product) {
        hmCartBasicInfo[product.productId] = BasicCartInfo(
            cartItemId: int.parse(product.itemId),
            quantity: product.productQty);
      });
    });
    log.i("hmCartBasicInfo updated: $hmCartBasicInfo");
  }

  void onNewWishListResponse(WishListResponse response) {
    hmWishListInfo.clear();
    response.wishList.forEach((item) {
      hmWishListInfo[item.productId] = BasicWishListInfo(
          productId: item.productId, wishListItemId: item.wishlistItemId);
    });
  }

  //on new data: of get country list
  void onNewGetCountryListResponse(CountryListResponse response) {
    if (response != null &&
        response.listCountryInfo != null &&
        response.listCountryInfo.length > 0) {
      for (int i = 0; i < response.listCountryInfo.length; i++) {
        if (response.listCountryInfo[i].fullNameEnglish == null ||
            response.listCountryInfo[i].id == null) {
          response.listCountryInfo.removeAt(i);
        }
      }
      countryListResponse = response;
    }
  }

  //clear common model resource
  cleanResource() {
    log.i('resourse clean : started');
    _userToken = null;
    _quoteId = null;
    userCountry = null;
    userState = null;
    countryListResponse = null;
    log.i('resourse cleaned');
  }

  //helper: match with h-map & update item product values
  void matchProductId(ItemMatch.Items item, ItemProduct itemProduct) {
    try {
      if (hmCartBasicInfo.containsKey(item.id.toString())) {
        BasicCartInfo basicCartInfo =
            CommonNotifier().hmCartBasicInfo[item.id.toString()];
        itemProduct.itemCartId = basicCartInfo.cartItemId != null
            ? basicCartInfo.cartItemId.toString()
            : '0';
        itemProduct.chosenQuantity = basicCartInfo.quantity ?? 0;
        print(
            "=====================================> ${basicCartInfo.quantity}");
      }
      if (hmWishListInfo.containsKey(item.id.toString())) {
        BasicWishListInfo basicWishListInfo =
            CommonNotifier().hmWishListInfo[item.id.toString()];
        itemProduct.isFavourite =
            basicWishListInfo.productId != null ? true : false;
        itemProduct.wishListItemId = basicWishListInfo.wishListItemId ?? 0;
      }
    } catch (e) {
      log.e(e.toString());
    }
  }

  //helper: match with h-map & update item product values
  void matchProductIdForPopularProducts(
      DataMatch.Data item, ItemProduct itemProduct) {
    try {
      if (hmCartBasicInfo.containsKey(item.productId.toString())) {
        BasicCartInfo basicCartInfo =
            hmCartBasicInfo[item.productId.toString()];
        itemProduct.itemCartId = basicCartInfo.cartItemId != null
            ? basicCartInfo.cartItemId.toString()
            : '0';
        itemProduct.chosenQuantity = basicCartInfo.quantity;
      }
      if (hmWishListInfo.containsKey(item.productId)) {
        BasicWishListInfo basicWishListInfo =
            CommonNotifier().hmWishListInfo[item.productId.toString()];
        itemProduct.isFavourite =
            basicWishListInfo.productId != null ? true : false;
        itemProduct.wishListItemId = basicWishListInfo.wishListItemId ?? 0;
      } else {
        itemProduct.isFavourite = false;
      }
    } catch (e) {
      log.e(e.toString());
    }
  }
}
