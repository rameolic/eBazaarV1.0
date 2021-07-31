import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:thought_factory/core/data/local/app_shared_preference.dart';
import 'package:thought_factory/core/data/remote/repository/cart_repository.dart';
import 'package:thought_factory/core/data/remote/repository/common_repository.dart';
import 'package:thought_factory/core/data/remote/request_response/cart/add_cart_item_product/add_cart_response.dart';
import 'package:thought_factory/core/data/remote/request_response/cart/cart_list/response_cart_list.dart';
import 'package:thought_factory/core/data/remote/request_response/cart/cart_list/response_remove_cart.dart';
import 'package:thought_factory/core/data/remote/request_response/cart/cookie/request_web_form_login.dart';
import 'package:thought_factory/core/data/remote/request_response/cart/cookie/response_form_key.dart';
import 'package:thought_factory/core/data/remote/request_response/cart/coupon/response_add_coupon.dart';
import 'package:thought_factory/core/data/remote/request_response/cart/coupon/response_remove_coupon.dart';
import 'package:thought_factory/core/data/remote/request_response/cart/set_shipping/set_shipping_request.dart';
import 'package:thought_factory/core/data/remote/request_response/cart/set_shipping/set_shipping_response.dart';
import 'package:thought_factory/core/data/remote/request_response/cart/shipping_method/shipping_method_request.dart';
import 'package:thought_factory/core/data/remote/request_response/cart/shipping_method/shipping_method_response.dart';
import 'package:thought_factory/core/data/remote/request_response/cart/total/cart_total_reques.dart';
import 'package:thought_factory/core/data/remote/request_response/cart/total/cart_total_response.dart';
import 'package:thought_factory/core/data/remote/request_response/common/country_list_response.dart';
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

class CartNotifier extends BaseNotifier {
  final log = getLogger('CartNotifier');

  final _cartRepository = CartRepository();
  var scaffoldKey = GlobalKey<ScaffoldState>(debugLabel: "cart_screen");
  CartListResponse _lstCartResponse = CartListResponse();
  CountryListResponse _countryListResponse;
  String _selectedCountry;
  bool isRegionAvailableForSelectedCountry;
  List<AvailableRegions> _listRegion;
  List<ShippingMethodModel> _lstShippingMethod = List();
  String _selectedRegion;
  String _zipCode;
  int _selectedRadioShippingMethod = -1;
  List<TotalSegmentsModel> _listTotalSegmentsModel = List();
  TextEditingController textEditConCoupon = TextEditingController(text: '');
  bool _isLoadingCartTotalData = false;
  String _couponCode;
  CommonRepository _commonRepository = CommonRepository();
  Addresses _addresses = Addresses();
  String _currencyCode = '';

  String get currencyCode => _currencyCode;

  set currencyCode(String value) {
    _currencyCode = value;
    notifyListeners();
  }

  //constructor
  CartNotifier(context) {
    //update scaffold context
    super.context = context;

    _initialSetup();
  }

  _initialSetup() async {
    _currencyCode = await _getCurrencySymbol();
    //get cart items list
    await callApiGetCartList();
    await callApiGetUserProfileDetail();
    //get country list
    CommonNotifier commonNotifier = CommonNotifier();
    if (commonNotifier.countryListResponse != null) {
      this.countryListResponse = commonNotifier.countryListResponse;
      this.selectedCountry =
          this.countryListResponse.listCountryInfo[0].fullNameEnglish;
      commonNotifier.userCountry;
    } else {
      getCountryListValues(commonNotifier);
    }
    //callApiGetCartTotal();
  }

  ///============== getter & setter ================///

  String get zipCode => _zipCode;

  set zipCode(String value) {
    _zipCode = value;
    notifyListeners();
  }

  String get couponCode => _couponCode;

  set couponCode(String value) {
    _couponCode = value;
    notifyListeners();
  }

  Addresses get addresses => _addresses;

  set addresses(Addresses value) {
    _addresses = value;
    notifyListeners();
  }

  bool get isLoadingCartTotalData => _isLoadingCartTotalData;

  set isLoadingCartTotalData(bool value) {
    _isLoadingCartTotalData = value;
    notifyListeners();
  }

  String get selectedCountry => _selectedCountry;

  set selectedCountry(String value) {
    _selectedCountry = value;
    updateRegionForSelectedCountry(value);
    notifyListeners();
  }

  List<AvailableRegions> get listRegion => _listRegion;

  set listRegion(List<AvailableRegions> value) {
    _listRegion = value;
    notifyListeners();
  }

  String get selectedRegion => _selectedRegion;

  set selectedRegion(String value) {
    _selectedRegion = value;
    callApiEstimateShippingAndTax(value, zipCode);
    notifyListeners();
  }

  CountryListResponse get countryListResponse => _countryListResponse;

  set countryListResponse(CountryListResponse value) {
    _countryListResponse = value;
    notifyListeners();
  }

  CartListResponse get lstCartResponse => _lstCartResponse;

  set lstCartResponse(CartListResponse value) {
    _lstCartResponse = value;
    notifyListeners();
  }

  List<ShippingMethodModel> get lstShippingMethod => _lstShippingMethod;

  set lstShippingMethod(List<ShippingMethodModel> value) {
    _lstShippingMethod = value;
    notifyListeners();
  }

  int get selectedRadioShippingMethod => _selectedRadioShippingMethod;

  set selectedRadioShippingMethod(int value) {
    _selectedRadioShippingMethod = value;
    notifyListeners();
  }

  List<TotalSegmentsModel> get listTotalSegmentsModel =>
      _listTotalSegmentsModel;

  set listTotalSegmentsModel(List<TotalSegmentsModel> value) {
    _listTotalSegmentsModel = value;
    notifyListeners();
  }

  ///============== api related works ============///
  //api: get cart list
  Future callApiGetCartList() async {
    log.i('api ::: GetCartList called');
    super.isLoading = true;
    try {
      lstCartResponse = await CommonNotifier().callApiGetCartList();
      super.isLoading = false;
    } catch (e) {
      log.e(e.toString());
      super.isLoading = false;
    }
  }

  //api: addCart item
  void callAPIAddItemToCart(ItemProduct itemProduct) async {
    log.i('api ::: callAPIAddItemToCart called');
    super.isLoading = true;
    try {
      AddToCartResponse response =
          await CommonNotifier().callApiChangeCartItemQuantity(itemProduct);
      onNewAddItemToCartResponse(response);
      super.isLoading = false;
    } catch (e) {
      log.e(e.toString());
      super.isLoading = false;
    }
  }

  //api removeCart item
  void callApiRemoveCartItem(String itemId) async {
    log.i('api ::: apiRemoveCart called');
    super.isLoading = true;
    try {
      RemoveCartResponse response =
          await CommonNotifier().callApiRemoveCartItem(itemId);
      super.isLoading = false;
      if (response.status == true) {
        callApiGetCartList().whenComplete(() {
          callApiEstimateShippingAndTax(selectedRegion ?? "", zipCode);
        });
      }
    } catch (e) {
      log.e(e.toString());
      super.isLoading = false;
    }
  }

  //api: estimate shipping & tax
  void callApiEstimateShippingAndTax(String region, String zipCode) async {
    log.i('api ::: apiEstimateShippingAndTax called');
    super.isLoading = true;
    String emailId = await AppSharedPreference()
        .getStringValue(AppConstants.KEY_USER_EMAIL_ID);
    String password = await AppSharedPreference()
        .getStringValue(AppConstants.KEY_USER_PASSWORD);
    await _cartRepository.apiFormKey().then((formKeyResponse) {
      _cartRepository
          .apiWebFormLogin(_buildWebFormLoginRequest(
              formKey: formKeyResponse.data,
              userName: emailId==null?"ryanttf@yopmail.com":emailId,
              password: password==null?"Magento@1234":password))
          .then((webFormLoginResponse) {
        if (webFormLoginResponse.errors != null &&
            webFormLoginResponse.errors == false) {
          selectedRadioShippingMethod =
              -1; //reset value of radio selection to none which is -1

          _cartRepository
              .apiEstimateShippingAndTax(
                  _buildShippingMethodRequest(region, zipCode),
                  CommonNotifier().cookieIdShipmentTax)
              .then((response) {
            onNewShippingMethodResponse(response);
          });
        }
      });
    });

    super.isLoading = false;
  }

  //api: set shipping method
  void callApiSetShippingMethod(String region, String zipCode) async {
    log.i('api ::: apiSetShippingMethod called');
    super.isLoading = true;
    try {
      SetShippingMethodResponse response =
          await _cartRepository.apiSetShippingMethod(
              _buildSetShippingMethodRequest(region, zipCode),
              CommonNotifier().cookieIdShipmentTax);
      onNewSetShippingMethodResponse(response);
      super.isLoading = false;
    } catch (e) {
      log.e(e.toString());
      super.isLoading = false;
    }
  }

  //api get user profile details
  Future callApiGetUserProfileDetail() async {
    log.i('api ::: GetUserProfileDetail called');
    super.isLoading = true;
    try {
      UserDetailResponse response = await _commonRepository
          .apiGetUserDetailByToken(CommonNotifier().userToken);
      log.i("userdetailresponse ----------------------> $response");
      onNewGetUserProfileDetails(response);
      super.isLoading = false;
    } catch (e) {
      log.e(e.toString());
      super.isLoading = false;
    }
  }

  Future<String> _getCurrencySymbol() async {
    return AppSharedPreference()
        .getPreferenceData(AppConstants.KEY_CURRENCY_CODE);
  }

  void onNewGetUserProfileDetails(UserDetailResponse response) {
    if (response != null) {
      if (response.addresses != null && response.addresses.length > 0) {
        List<Addresses> lstAddress = response.addresses
            .where((item) => (item.defaultBilling == true))
            .toList();
        if (lstAddress != null && lstAddress.length > 0) {
          addresses = lstAddress[0];
          log.i("userdetailresponse 1111----------------------> $addresses");
        }
      }
    } else {
      showMessage('Response id null');
      //showSnackBarMessageWithContext('Response id null');
    }
  }

  //api: get cart total information
  void callApiGetCartTotal() async {
    log.i('api ::: apiGetCartTotal called');
    isLoadingCartTotalData = true;
    try {
      CartTotalResponse response =
          await _cartRepository.apiGetCartTotalInfoResponse(
              _buildTotalRequest(), CommonNotifier().cookieIdShipmentTax);
      onNewGetCartTotalResponse(response);
      isLoadingCartTotalData = false;
    } catch (e) {
      log.e(e.toString());
      super.isLoading = false;
    }
  }

  /*//api: get cart total
  void callApiGetCartTotal() async {
    log.i('api ::: apiGetCartTotal called');
    isLoadingCartTotalData = true;
    CartTotalResponse response = await _cartRepository.apiGetCartTotalResponse();
    onNewGetCartTotalResponse(response);
    isLoadingCartTotalData = false;
  }*/

  //api: add coupon
  void callApiAddCoupon(String couponCode) async {
    log.i('api ::: apiAddCoupon called');
    super.isLoading = true;
    try {
      AddCouponResponse response =
          await _cartRepository.apiAddCoupon(couponCode);
      onNewAddCouponResponse(response);
      super.isLoading = false;
    } catch (e) {
      log.e(e.toString());
      super.isLoading = false;
    }
  }

  //api: remove coupon
  void callApiRemoveCoupon() async {
    log.i('api ::: apiRemoveCoupon called');
    super.isLoading = true;
    try {
      RemoveCouponResponse response = await _cartRepository.apiRemoveCoupon();
      onNewRemoveCouponResponse(response);
      super.isLoading = false;
    } catch (e) {
      log.e(e.toString());
      super.isLoading = false;
    }
  }

  //get: country list
  void getCountryListValues(CommonNotifier commonNotifier) async {
    CountryListResponse response =
        await commonNotifier.callApiGetCountriesList();
    onNewGetCountryListResponse(response);
  }

  //build request: for set shipping method
  SetShippingMethodRequest _buildSetShippingMethodRequest(region, zipCode) {
    String countryId;
    String regionId;
    String regionCode;
    var street;
    String company;
    String telephone;
    String postcode;
    String city;
    String firstName;
    String lastName;

    String shippingMethodCode;
    String shippingCarrierCode;

    try {
      //get country id
      List<CountryInfo> listCountryInfo = countryListResponse.listCountryInfo
          .where((item) => item.fullNameEnglish == selectedCountry)
          .toList();
      if (listCountryInfo != null && listCountryInfo.isNotEmpty) {
        countryId = listCountryInfo[0].id; //set country id
        //get region id if region list ter for country
        if (listCountryInfo[0].availableRegions != null &&
            listCountryInfo[0].availableRegions.isNotEmpty) {
          List<AvailableRegions> listAvailRegion = listCountryInfo[0]
              .availableRegions
              .where((item) => item.name == selectedRegion)
              .toList();
          if (listAvailRegion != null && listAvailRegion.isNotEmpty) {
            regionId = listAvailRegion[0].id;
            regionCode = listAvailRegion[0].code;
          }
        }
      }
      //get address info
      CommonNotifier commonNotifier = CommonNotifier();
      if (commonNotifier.userDetail != null) {
        firstName = commonNotifier.userDetail.firstname;
        lastName = commonNotifier.userDetail.lastname;
      }
      if (addresses != null) {
        street = addresses.street;
        city = addresses.city;
        telephone = addresses.telephone;
        zipCode = addresses.postcode;
      }
      SetShippingAddress setShippingAddress = SetShippingAddress(
        region: region,
        regionId: int.parse(regionId ?? '0'),
        countryId: countryId,
        street: street,
        company: '',
        telephone: telephone,
        postcode: zipCode,
        city: city,
        firstname: firstName,
        lastname: lastName,
      );

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
              billingAddress: setShippingAddress,
              shippingCarrierCode: shippingCarrierCode,
              shippingMethodCode: shippingMethodCode));
    } catch (e) {
      log.e(e.toString());
    }

    return null;
  }

  //build request: for shipping method request
  ShippingMethodRequest _buildShippingMethodRequest(region, zipCode) {
    String countryId;
    String regionName = region;
    String regionId;
    String regionCode;
    String zipPinCode = zipCode;
    var street;
    String city;
    String firstName;
    String lastName;
    int customerId;
    String email;
    int sameAsBilling = 1;

    try {
      //get country id
      List<CountryInfo> listCountryInfo = countryListResponse.listCountryInfo
          .where((item) => item.fullNameEnglish == selectedCountry)
          .toList();
      if (listCountryInfo != null && listCountryInfo.isNotEmpty) {
        countryId = listCountryInfo[0].id;
        //get region id if region list ter for country
        if (listCountryInfo[0].availableRegions != null &&
            listCountryInfo[0].availableRegions.isNotEmpty) {
          List<AvailableRegions> listAvailRegion = listCountryInfo[0]
              .availableRegions
              .where((item) => item.name == selectedRegion)
              .toList();
          if (listAvailRegion != null && listAvailRegion.isNotEmpty) {
            regionId = listAvailRegion[0].id;
            regionCode = listAvailRegion[0].code;
          }
        }
      }
      //get address info
      CommonNotifier commonNotifier = CommonNotifier();
      if (commonNotifier.userDetail != null) {
        firstName = commonNotifier.userDetail.firstname;
        lastName = commonNotifier.userDetail.lastname;
        customerId = commonNotifier.userDetail.id;
        email = commonNotifier.userDetail.email;

        if (commonNotifier.userDetail.addresses != null &&
            commonNotifier.userDetail.addresses.length > 0) {
          Addresses itemAddress = commonNotifier.userDetail.addresses[0];
          street = itemAddress.street;
          city = itemAddress.city;
          zipCode = itemAddress.postcode;
        }
      }

      return ShippingMethodRequest(
          cardId: int.parse(commonNotifier.quoteId),
          address: Address(
              region: regionName,
              regionId: regionId,
              regionCode: regionCode,
              countryId: countryId,
              street: street,
              postcode: zipCode,
              city: city,
              firstname: firstName,
              lastname: lastName,
              customerId: customerId,
              email: email));
    } catch (e) {
      log.e(e.toString());
    }

    return null;
  }

  //build request: for set web form login request
  WebFormLoginRequest _buildWebFormLoginRequest(
      {String formKey, String userName, String password}) {
    try {
      return WebFormLoginRequest(
          formKey: formKey, username: userName, password: password);
    } catch (e) {
      log.e("Error : " + e.toString());
    }
    return null;
  }

  //on new data: for add item
  void onNewAddItemToCartResponse(AddToCartResponse response) async {
    if (response != null) {
      await callApiGetCartList();
      callApiGetCartTotal();
      showMessage('Quatity changed !');
      //showSnackBarMessageWithContext('Quatity changed !');
    } else if (response != null && response.message != null) {
      showMessage(response.message ?? '');
      //showSnackBarMessageWithContext(response.message);
    }
  }

  //on new data: for country list
  void onNewGetCountryListResponse(CountryListResponse response) {
    if (response != null &&
        response.listCountryInfo != null &&
        response.listCountryInfo.length > 0) {
      countryListResponse = response;
      selectedCountry = countryListResponse.listCountryInfo[0].fullNameEnglish;
    }
  }

  //on new data: list shipping | delivery methods
  void onNewShippingMethodResponse(ShippingMethodResponse response) {
    if (response != null) {
      if (response.lstShippingMethod != null &&
          response.lstShippingMethod.length > 0) {
        lstShippingMethod = response.lstShippingMethod
            .map((item) => ShippingMethodModel(
                amount: item.amount,
                methodTitle: item.methodTitle,
                carrierCode: item.carrierCode,
                methodCode: item.methodCode))
            .toList();
        callApiGetCartTotal();
      } else {
        lstShippingMethod.clear();
      }
    } else {
      lstShippingMethod.clear();
    }
  }

  //on new data: set shipping methods
  void onNewSetShippingMethodResponse(SetShippingMethodResponse response) {
    if (response != null) {
      if (response.paymentMethods != null && response.paymentMethods.length > 0)
        CommonNotifier().lstPaymentMethods = response.paymentMethods;
      callApiGetCartTotal();
    }
  }

  //on new data: get cart total response
  void onNewGetCartTotalResponse(CartTotalResponse response) {
    try {
      if (response != null) {
        if (response.message == null) {
          //get cart total response
          if (response.totalSegments != null &&
              response.totalSegments.length > 0) {
            print("currency code ---------> ${response.baseCurrencyCode}");
            currencyCode = 'AED';
            listTotalSegmentsModel = response.totalSegments
                .map((item) => TotalSegmentsModel(
                    area: item.area,
                    title: item.title,
                    code: item.code,
                    value: item.value))
                .toList();
          }
          //get coupon details
          couponCode = response.couponCode;
          textEditConCoupon.text = response.couponCode ?? '';
        } else {
          showMessage(response.message);
          //super.showSnackBarMessageWithContext(response.message);
        }
      } else {
        showMessage('Response is NULL');
        //super.showSnackBarMessageWithContext('Response is NULL');
      }
    } catch (e) {
      log.i(e.toString());
    }
  }

  //on new data: add coupon code
  void onNewAddCouponResponse(AddCouponResponse response) {
    try {
      if (response != null && response.message == null) {
        callApiGetCartTotal();
      } else {
        showMessage(response.message);
        //super.showSnackBarMessageWithContext(response.message);
      }
    } catch (e) {
      log.e(e.toString());
    }
  }

  //on new data: remove coupon code
  void onNewRemoveCouponResponse(RemoveCouponResponse response) {
    try {
      if (response != null) {
        callApiGetCartTotal();
      }
    } catch (e) {
      log.e(e.toString());
    }
  }

  //helper: to update region in spinner
  void updateRegionForSelectedCountry(String selectedCountry) {
    CountryInfo itemCountryInfo = countryListResponse.listCountryInfo
        .firstWhere((item) => item.fullNameEnglish == selectedCountry,
            orElse: () => null);

    if (itemCountryInfo != null &&
        itemCountryInfo.availableRegions != null &&
        itemCountryInfo.availableRegions.length > 0) {
      isRegionAvailableForSelectedCountry = true;
      listRegion = itemCountryInfo.availableRegions;
      selectedRegion = itemCountryInfo.availableRegions[0].name;
    } else {
      log.d(">> $selectedCountry -> Region is null");
      isRegionAvailableForSelectedCountry = false;
      selectedRegion = null;
      listRegion = null;
    }
  }

  //helper: build & send payment notifier value for payment screeen
  PaymentModel getPaymentNotifierValue() {
    List<PaymentMethodsModel> lstPaymentModel = CommonNotifier()
        .lstPaymentMethods
        .map((item) => PaymentMethodsModel(code: item.code, title: item.title))
        .toList();

    return PaymentModel(
        lstPaymentMethods: lstPaymentModel,
        listTotalSegmentsModel: listTotalSegmentsModel,
        lstShippingMethod: lstShippingMethod,
        selectedShippingMethod: selectedRadioShippingMethod);
  }

  //build request: for Total information request
  TotalInfoRequest _buildTotalRequest() {
    String countryId;
    String regionName = selectedRegion;
    String regionId;
    String zipPinCode = zipCode;
    String shippingMethodCode;
    String shippingCarrierCode;

    try {
      //get country id
      List<CountryInfo> listCountryInfo = countryListResponse.listCountryInfo
          .where((item) => item.fullNameEnglish == selectedCountry)
          .toList();
      if (listCountryInfo != null && listCountryInfo.isNotEmpty) {
        countryId = listCountryInfo[0].id;
        //get region id if region list ter for country
        if (listCountryInfo[0].availableRegions != null &&
            listCountryInfo[0].availableRegions.isNotEmpty) {
          List<AvailableRegions> listAvailRegion = listCountryInfo[0]
              .availableRegions
              .where((item) => item.name == selectedRegion)
              .toList();
          if (listAvailRegion != null && listAvailRegion.isNotEmpty) {
            regionId = listAvailRegion[0].id;
            //regionCode = listAvailRegion[0].code;
          }
        }
      }

      if (lstShippingMethod != null && lstShippingMethod.length > 0) {
        shippingMethodCode = (selectedRadioShippingMethod == -1)
            ? null
            : lstShippingMethod[selectedRadioShippingMethod].methodCode;
        shippingCarrierCode = (selectedRadioShippingMethod == -1)
            ? null
            : lstShippingMethod[selectedRadioShippingMethod].carrierCode;
      }

      return TotalInfoRequest(
          addressInformation: AddressInfo(
              address: AddressDetails(
                countryId: countryId,
                region: regionName,
                regionId: regionId,
                postcode: zipCode,
              ),
              shippingCarrierCode: shippingCarrierCode,
              shippingMethodCode: shippingMethodCode));
    } catch (e) {
      log.e(e.toString());
    }

    return null;
  }

  showMessage(String content) {
    scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(content)));
  }
}
