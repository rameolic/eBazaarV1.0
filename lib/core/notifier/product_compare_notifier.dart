import 'package:flutter/cupertino.dart';
import 'package:thought_factory/core/data/local/app_shared_preference.dart';
import 'package:thought_factory/core/data/remote/repository/product_repository.dart';
import 'package:thought_factory/core/data/remote/request_response/compare/add_or_remove_products_to_compare_response.dart';
import 'package:thought_factory/core/data/remote/request_response/compare/compare_product_list_response.dart';
import 'package:thought_factory/core/data/remote/request_response/product/related_product/response_related_product.dart';
import 'package:thought_factory/core/model/item_product_model.dart';
import 'package:thought_factory/core/notifier/base/base_notifier.dart';
import 'package:thought_factory/utils/app_constants.dart';
import 'package:thought_factory/utils/app_log_helper.dart';
import 'package:toast/toast.dart';

import 'common_notifier.dart';

class ProductCompareNotifier extends BaseNotifier {
  final log = getLogger('ProductCompareNotifier');
  final _repository = ProductRepository();
  List<CompareProductItem> _listProductCompared = List();
  List<ItemProduct> _lstRelatedProduct = List();
  List<CompareProductItem> get listProductCompared => _listProductCompared;
  List<ItemProduct> get lstRelatedProduct => _lstRelatedProduct;
  AddOrRemoveProductsToCompareResponse addOrRemoveProductsToCompareResponse =
  AddOrRemoveProductsToCompareResponse();
  String _currency = "";

  set lstRelatedProduct(List<ItemProduct> value) {
    _lstRelatedProduct = value;
    notifyListeners();
  }

  set listProductCompared(List<CompareProductItem> value) {
    _listProductCompared = value;
    notifyListeners();
  }

  ProductCompareNotifier(BuildContext context) {
    //super.context = context;
    _initialSetup();
    callAPICompareProducts();
  }

  _initialSetup() async {
    currency = await _getCurrencySymbol();
  }

  Future<String> _getCurrencySymbol() async {
    return AppSharedPreference()
        .getPreferenceData(AppConstants.KEY_CURRENCY_CODE);
  }

  void removeProducts(int index) {
    _listProductCompared.removeAt(index);
    notifyListeners();
  }

  String get currency => _currency;

  set currency(String value) {
    _currency = value;
    notifyListeners();
  }

  void callAPICompareProducts() async {
    log.i('api ::: callAPICompareProducts called');
    isLoading = true;
    CompareProductListResponse response =
        await _repository.fetchCompareProducts(CommonNotifier().userToken);
    onCompareProductsResponse(response);
    isLoading = false;
  }

  // api remove from compare
  //Note: Send parameters either single or multiple Ex: 1 OR 1,2 OR All to remove all
  void callAPIRemoveProduct(int index) async {
    log.i('api ::: apiRemoveFromCompare called');
    isLoading = true;
    var productId1 = _listProductCompared[index].id;
    var response = await _repository.removeProductsToCompare(
        productId1, CommonNotifier().userToken);
    removeProduct(response, index);
    isLoading = false;
    if (response != null) {
      print("apiAddToCompare --------> $response");
    } else {
      print("apiAddToCompare ----------> failed");
    }
  }

  void removeProduct(AddOrRemoveProductsToCompareResponse response, int index) {
    if (response != null && response.addToCompare != null) {
      if (response.addToCompare[0].status == 1 ||
          response.addToCompare[0].status == 0) {
        removeProducts(index);
      }
    }
  }

  void onCompareProductsResponse(CompareProductListResponse response) {
    if (response != null) {
      if (response.compareProductList != null &&
          response.compareProductList[0].status == 1) {
        _listProductCompared = response.compareProductList[0].data;
        //response.compareProductList[0].data.getRange(0, (response.compareProductList[0].data.length > 1) ? 1 : 0);
      } else {
        Toast.show(response.compareProductList[0].message, this.context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        showSnackBarMessageParamASContext(
            context, response.compareProductList[0].message);
      }
    }
    /*else {
      super.showSnackBarMessageWithContext(
          response.message);
    }*/
  }

  Future callApiRelatedProductList(String productId) async {
    log.i('api ::: GetRelatedProductList called');
    super.isLoading = true;
    RelatedProductResponse lstRelatedProductResponse =
    await _repository.getRelatedProducts(productId);
    log.i("Related Product data is : " +
        lstRelatedProductResponse.toJson().toString());
    onNewResponseOfGetRelatedProducts(lstRelatedProductResponse);
    super.isLoading = false;
  }

  void onNewResponseOfGetRelatedProducts(RelatedProductResponse response) {
    //clear old records if exists
    if (lstRelatedProduct.isNotEmpty) lstRelatedProduct.clear();

    if (response != null &&
        response.status == AppConstants.RESPONSE_STATUS_SUCCESS &&
        response.data != null &&
        response.data.length > 0) {
      lstRelatedProduct = response.data
          .map((product) => ItemProduct(
          name: product.name,
          id: int.parse(product.productId) ?? 0,
          price: double.parse(product.price) ?? 0.00,
          imageUrl: product.productImage ?? "",
          productType: product.productType ?? "",
          sku: product.sku,
          maxQuantity: product.productQtyStock))
          .toList();
    }
    /*else {
     super.showSnackBarMessageWithContext(response.message);
    }*/
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


  Future addProductCompare(String productId) async {
    //Remove Product from Compare  apiAddToCompare
    await apiAddToCompare(productId);
    if (addOrRemoveProductsToCompareResponse != null &&
        addOrRemoveProductsToCompareResponse.addToCompare != null) {
      if (addOrRemoveProductsToCompareResponse.addToCompare[0].status == 1 ||
          addOrRemoveProductsToCompareResponse.addToCompare[0].status == 0) {
        callAPICompareProducts();
      } else
        showToast(addOrRemoveProductsToCompareResponse.addToCompare[0].message);
      /*super.showSnackBarMessageWithContext(
          addOrRemoveProductsToCompareResponse.addToCompare[0].message);
    */
    } else
      showToast(addOrRemoveProductsToCompareResponse.message);
  }

}
