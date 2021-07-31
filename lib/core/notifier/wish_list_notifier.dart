import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:thought_factory/core/data/local/app_shared_preference.dart';
import 'package:thought_factory/core/data/remote/repository/wish_list_repository.dart';
import 'package:thought_factory/core/data/remote/request_response/cart/add_cart_item_product/add_cart_response.dart';
import 'package:thought_factory/core/data/remote/request_response/wishlist/ShareWishListRequest.dart';
import 'package:thought_factory/core/data/remote/request_response/wishlist/ShareWishListResponse.dart';
import 'package:thought_factory/core/data/remote/request_response/wishlist/add_to_cart_request.dart';
import 'package:thought_factory/core/data/remote/request_response/wishlist/wish_list_item_response.dart';
import 'package:thought_factory/core/data/remote/request_response/wishlist/wish_list_response.dart';
import 'package:thought_factory/core/notifier/base/base_notifier.dart';
import 'package:thought_factory/core/notifier/common_notifier.dart';
import 'package:thought_factory/utils/app_constants.dart';
import 'package:thought_factory/utils/app_log_helper.dart';

class WishListNotifier extends BaseNotifier {
  final log = getLogger('WishListNotifier');

  bool showButton = true;
  final _wishRepository = WishListRepository();
  WishListResponse _wishListResponse = WishListResponse();
  String _currencySymbol = "";

  WishListNotifier(context) {
    super.context = context;
    // get wish item list
    callApiGetWishList();
  }

  WishListResponse get wishListResponse => _wishListResponse;

  set wishListResponse(WishListResponse value) {
    _wishListResponse = value;
    notifyListeners();
  }

  String get currencySymbol => _currencySymbol;

  set currencySymbol(String value) {
    _currencySymbol = value;
    notifyListeners();
  }


  // get wish list
  Future callApiGetWishList() async {
    log.i('api ::: GetWishList called');
    _currencySymbol = await _getCurrencySymbol();
    super.isLoading = true;
    WishListResponse response =
        await _wishRepository.apiGetWishList(CommonNotifier().userToken);
    onNewWishListResponse(response);
    super.isLoading = false;
  }

  // remove wish list item
  Future callApiRemoveWishListItem(String wishListItemId) async {
    log.i('api ::: callApiRemoveWishListItem called');
    super.isLoading = true;
    WishListItemResponse response = await _wishRepository.apiRemoveWishListItem(
        CommonNotifier().userToken, wishListItemId);
    onNewRemoveWishListResponse(response);
    super.isLoading = false;
  }

  // add wish list item to cart
  Future callApiAddWishListItem(String sku, int qty) async {
    log.i('api ::: callApiAddWishListItem called');
    AddToCartRequest addToCartRequest = AddToCartRequest(
        cartItem:
            CartItem(sku: sku, qty: qty, quoteId: (CommonNotifier().quoteId)));
    super.isLoading = true;
    log.i("^^^^^^^^^^^^^^^^^^^ $addToCartRequest");
    AddToCartResponse response = await _wishRepository.apiAddWishListItemToCart(
        CommonNotifier().userToken, addToCartRequest);
    CommonNotifier().callApiGetCartList();
    onNewAddWishListResponse(response);
    super.isLoading = false;
  }

  // share wish list api
  Future callApiShareWishList(ShareWishListRequest shareWishListRequest, BuildContext context) async {
    log.i('api ::: callApiShareWishList called');
    super.isLoading = true;
    ShareWishListResponse response = await _wishRepository.apiShareWishList(
        CommonNotifier().userToken, shareWishListRequest);
    onNewShareWishListResponse(response,context);
    super.isLoading = false;
  }

  void onNewWishListResponse(WishListResponse response) {
    if (response != null) {
      log.i(
          "onNewWishListResponse ------------------------> ${response.wishList}");
      wishListResponse = response;
    }
  }

  void onNewRemoveWishListResponse(WishListItemResponse response) {
    if (response != null) {
      log.i("api ::: onNewRemoveWishListResponse ----------> $response");
      if (response.success == "true") {
        callApiGetWishList();
      }
    }
  }

  void onNewAddWishListResponse(AddToCartResponse response) {
    if (response != null) {
      if (response.quoteId != null) {
        showSnackBarMessageWithContext("Item added to cart");
      }
    }
  }

  void onNewShareWishListResponse(ShareWishListResponse response, BuildContext context) {
    if (response != null) {
      showSnackBarMessageWithContext(response.message);
          Navigator.pop(context);
    }
  }

  Future<String> _getCurrencySymbol() async {
    return AppSharedPreference().getPreferenceData(AppConstants.KEY_CURRENCY_CODE);
  }
}
