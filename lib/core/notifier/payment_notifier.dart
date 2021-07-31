import 'dart:io';

import 'package:thought_factory/core/data/local/app_shared_preference.dart';
import 'package:thought_factory/core/data/remote/repository/cart_repository.dart';
import 'package:thought_factory/core/data/remote/repository/common_repository.dart';
import 'package:thought_factory/core/data/remote/request_response/cart/add_cart_item_product/add_cart_response.dart';
import 'package:thought_factory/core/data/remote/request_response/cart/create_order/CreateOrderRequest.dart';
import 'package:thought_factory/core/data/remote/request_response/cart/create_order/create_order_response.dart';
import 'package:thought_factory/core/data/remote/request_response/cart/set_shipping/set_shipping_request.dart';
import 'package:thought_factory/core/data/remote/request_response/cart/set_shipping/set_shipping_response.dart';
import 'package:thought_factory/core/data/remote/request_response/user/user_detail_response.dart';
import 'package:thought_factory/core/model/cart_total_items.dart';
import 'package:thought_factory/core/model/item_product_model.dart';
import 'package:thought_factory/core/model/payment_methods_model.dart';
import 'package:thought_factory/core/model/payment_model.dart';
import 'package:thought_factory/core/model/shipping_method_model.dart';
import 'package:thought_factory/core/notifier/common_notifier.dart';
import 'package:thought_factory/utils/app_constants.dart';
import 'package:thought_factory/utils/app_log_helper.dart';

import 'base/base_notifier.dart';

class PaymentNotifier extends BaseNotifier {
  final log = getLogger('CartPaymentNotifier');

  PaymentModel _paymentModel = PaymentModel();
  CommonRepository _commonRepository = CommonRepository();
  List<PaymentMethodsModel> _lstPaymentMethods;
  List<ShippingMethodModel> _lstShippingMethod;
  List<TotalSegmentsModel> _listTotalSegmentsModel = List();
  final _cartRepository = CartRepository();

  int _selectedRadioPaymentMethod = -1;
  int _selectedRadioShippingMethod = -1;

  Addresses _shippingAddress = Addresses();
  Addresses _billingAddress = Addresses();

  bool _shippingAddressAvailable = false;
  bool _billingAddressAvailable = false;

  String _currencyCode = '';



  //constructor
  PaymentNotifier(context, PaymentModel paymentModel) {
    //update scaffold context
    super.context = context;
    updateInitialValue(paymentModel);
    callApiGetUserProfileDetail();
  }

  void updateInitialValue(PaymentModel paymentModel) {
    if (null != paymentModel) {
      //lstPaymentMethods = paymentModel.lstPaymentMethods;
      lstShippingMethod = paymentModel.lstShippingMethod;
      listTotalSegmentsModel = paymentModel.listTotalSegmentsModel;
      selectedRadioShippingMethod = paymentModel.selectedShippingMethod;
    }
  }

  ///============== getter & setter  ============///
  Addresses get shippingAddress => _shippingAddress;

  set shippingAddress(Addresses value) {
    _shippingAddress = value;
    notifyListeners();
  }

  Addresses get billingAddress => _billingAddress;

  set billingAddress(Addresses value) {
    _billingAddress = value;
    notifyListeners();
  }

  PaymentModel get paymentModel => _paymentModel;

  set paymentModel(PaymentModel value) {
    _paymentModel = value;
    notifyListeners();
  }

  int get selectedRadioShippingMethod => _selectedRadioShippingMethod;

  set selectedRadioShippingMethod(int value) {
    _selectedRadioShippingMethod = value;
    notifyListeners();
  }

  List<PaymentMethodsModel> get lstPaymentMethods => _lstPaymentMethods;

  set lstPaymentMethods(List<PaymentMethodsModel> value) {
    _lstPaymentMethods = value;
    notifyListeners();
  }

  List<ShippingMethodModel> get lstShippingMethod => _lstShippingMethod;

  set lstShippingMethod(List<ShippingMethodModel> value) {
    _lstShippingMethod = value;
    notifyListeners();
  }

  List<TotalSegmentsModel> get listTotalSegmentsModel =>
      _listTotalSegmentsModel;

  set listTotalSegmentsModel(List<TotalSegmentsModel> value) {
    _listTotalSegmentsModel = value;
    notifyListeners();
  }

  int get selectedRadioPaymentMethod => _selectedRadioPaymentMethod;

  set selectedRadioPaymentMethod(int value) {
    _selectedRadioPaymentMethod = value;
    notifyListeners();
  }

  bool get billingAddressAvailable => _billingAddressAvailable;

  set billingAddressAvailable(bool value) {
    _billingAddressAvailable = value;
    notifyListeners();
  }

  bool get shippingAddressAvailable => _shippingAddressAvailable;

  set shippingAddressAvailable(bool value) {
    _shippingAddressAvailable = value;
    notifyListeners();
  }

  String get currencyCode => _currencyCode;

  set currencyCode(String value) {
    _currencyCode = value;
    notifyListeners();
  }
  ///============== api related works ============///

  //api: proceed to check out item
  void callApiPayNow(ItemProduct itemProduct) async {
    log.i('api ::: callAPIAddItemToCart called');
    super.isLoading = true;
    AddToCartResponse response =
    await CommonNotifier().callApiChangeCartItemQuantity(itemProduct);
    //onNewAddItemToCartResponse(response);
    super.isLoading = false;
  }

  //api get user profile details
  void callApiGetUserProfileDetail() async {
    _currencyCode = await _getCurrencySymbol();
    log.i('api ::: GetUserProfileDetail called');
    super.isLoading = true;
    UserDetailResponse response = await _commonRepository
        .apiGetUserDetailByToken(CommonNotifier().userToken);
    super.isLoading = false;
    onNewGetUserProfileDetails(response);
  }

  //get: create Order
  Future<CreateOrderResponse> callApiCreateOrder(String paymentMethod,
      String shippingCode, String carrierCode) async {
    super.isLoading = true;
    CreateOrderResponse response =
    await _commonRepository.apiCreateOrderResponse(
        buildCreateOrderRequest(paymentMethod, shippingCode, carrierCode));
    super.isLoading = false;
    if (response != null) {
      return response;
    } else {
      return null;
    }
  }


  //get: payment Information
  Future<CreateOrderResponse> callApiPayment(String paymentMethod,
      String shippingCode, String carrierCode) async {
    super.isLoading = true;
    CreateOrderResponse response =
    await _commonRepository.apiPaymentInformation(
        buildCreateOrderRequest(paymentMethod, shippingCode, carrierCode));
    super.isLoading = false;
    if (response != null) {
      return response;
    } else {
      return null;
    }
  }

  // build create order request
  CreateOrderRequest buildCreateOrderRequest(paymentMethod, shippingCode,
      carrierCode) {
    return CreateOrderRequest(
      cartId: CommonNotifier().quoteId,
      paymentMethod: PaymentMethod(method: paymentMethod),
      /*shippingMethod: ShippingMethod(
            methodCode: shippingCode,
            carrierCode: carrierCode,
            additionalProperties: AdditionalProperties())*/);
  }

  void onNewGetUserProfileDetails(UserDetailResponse response) {
    if (response != null && response.addresses != null &&
        response.addresses.length > 0) {
      _shippingAddressAvailable = false;
      _billingAddressAvailable = false;

      List<Addresses> shippingAddressList = response.addresses.where((item) =>
      (item.defaultShipping == true)).toList();
      if (shippingAddressList != null && shippingAddressList.length > 0) {
        shippingAddress = shippingAddressList.elementAt(0);
        _shippingAddressAvailable = true;
      }

      List<Addresses> billingAddressList = response.addresses.where((item) =>
      (item.defaultBilling == true)).toList();
      if (billingAddressList != null && billingAddressList.length > 0) {
        billingAddress = billingAddressList.elementAt(0);
        _billingAddressAvailable = true;
      }

      /*     response.addresses.forEach((address) {
          if (address.defaultShipping) {
            shippingAddress = address;
            _shippingAddressAvailable = true;
          }
          if (address.defaultBilling) {
            billingAddress = address;
            _billingAddressAvailable = true;
          }
        });*/
        if (_shippingAddressAvailable && _billingAddressAvailable) {
          //call SetShippingMethod to set Billing and Sgipping Address
          callApiSetShippingMethod();
        }
      } else {
        _shippingAddressAvailable = false;
        _billingAddressAvailable = false;
      }
    }

    Future<String> _getCurrencySymbol() async {
      return AppSharedPreference()
          .getPreferenceData(AppConstants.KEY_CURRENCY_CODE);
    }

    //api: set shipping method
    void callApiSetShippingMethod() async {
      log.i('api ::: apiSetShippingMethod called');
      super.isLoading = true;
      SetShippingMethodResponse response = await _cartRepository
          .apiSetShippingMethod(_buildSetShippingMethodRequest(), CommonNotifier().cookieIdShipmentTax);
      onSetShippingMethod(response);
      super.isLoading = false;
    }

    /*
   *build request: for set shipping method
   * billing Address
   * Shipping Address
   * shipping method code and carrier code
   * */

    SetShippingMethodRequest _buildSetShippingMethodRequest() {
      String shippingMethodCode;
      String shippingCarrierCode;
      SetShippingAddress setShippingAddress;
      SetShippingAddress setBillingAddress;

      try {
        if (_shippingAddressAvailable != null)
          setShippingAddress = SetShippingAddress(
              region: shippingAddress.region.region,
              regionId: shippingAddress.region.regionId,
              countryId: shippingAddress.countryId,
              street: shippingAddress.street,
              company: shippingAddress.company,
              telephone: shippingAddress.telephone,
              postcode: shippingAddress.postcode,
              city: shippingAddress.city,
              firstname: shippingAddress.firstname,
              lastname: shippingAddress.lastname,
              customerAddressId: shippingAddress.id,
              customerId: shippingAddress.customerId,
              regionCode: shippingAddress.region.regionCode);

        if (_billingAddressAvailable != null)
          setBillingAddress = SetShippingAddress(
              region: billingAddress.region.region,
              regionId: billingAddress.region.regionId,
              countryId: billingAddress.countryId,
              street: billingAddress.street,
              company: billingAddress.company,
              telephone: billingAddress.telephone,
              postcode: billingAddress.postcode,
              city: billingAddress.city,
              firstname: billingAddress.firstname,
              lastname: billingAddress.lastname,
              customerAddressId: billingAddress.id,
              customerId: billingAddress.customerId,
              regionCode: billingAddress.region.regionCode);

        if (lstShippingMethod != null && lstShippingMethod.length > 0) {
          shippingMethodCode =
              lstShippingMethod[selectedRadioShippingMethod].methodCode;
          shippingCarrierCode =
              lstShippingMethod[selectedRadioShippingMethod].carrierCode;
        }

        return SetShippingMethodRequest(
            cartId: CommonNotifier().quoteId,
            addressInformation: AddressInformation(
                shippingAddress: setShippingAddress,
                billingAddress: setBillingAddress,
                shippingCarrierCode: shippingCarrierCode,
                shippingMethodCode: shippingMethodCode));
      } catch (e) {
        log.e(e.toString());
        return null;
      }
    }

    void onSetShippingMethod(SetShippingMethodResponse response) {
      if (response != null) {
        if (response.paymentMethods != null &&
            response.paymentMethods.length > 0)
          CommonNotifier().lstPaymentMethods = response.paymentMethods;
        lstPaymentMethods = response.paymentMethods.map((item) =>
            PaymentMethodsModel(code: item.code, title: item.title))
            .toList();
      }
    }
  }