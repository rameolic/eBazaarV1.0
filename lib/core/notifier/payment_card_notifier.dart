import 'package:flutter/cupertino.dart';
import 'package:thought_factory/core/data/local/app_shared_preference.dart';
import 'package:thought_factory/core/data/remote/network/app_url.dart';
import 'package:thought_factory/core/data/remote/network/method.dart';
import 'package:thought_factory/core/data/remote/repository/auth_repository.dart';
import 'package:thought_factory/core/data/remote/repository/common_repository.dart';
import 'package:thought_factory/core/data/remote/repository/order_confirmation_repository.dart';
import 'package:thought_factory/core/data/remote/request_response/cart/get_order_by_id/CreateOrderByIdResponse.dart';
import 'package:thought_factory/core/data/remote/request_response/login/login_response.dart';
import 'package:thought_factory/core/data/remote/request_response/login/request.dart';
import 'package:thought_factory/core/data/remote/request_response/product/card/PaymentCardRequest.dart';
import 'package:thought_factory/core/data/remote/request_response/product/card/PaymentCardResponse.dart';
import 'package:thought_factory/core/data/remote/request_response/user/user_detail_response.dart';
import 'package:thought_factory/core/notifier/common_notifier.dart';
import 'package:thought_factory/utils/app_constants.dart';
import 'package:thought_factory/utils/app_log_helper.dart';
import 'package:thought_factory/utils/app_network_check.dart';

import 'base/base_notifier.dart';

class PaymentCardNotifier extends BaseNotifier {
  final log = getLogger('PaymentCardNotifier');

  final _repository = AuthRepository();
  final _commonRepository = CommonRepository();
  OrderConfirmationRepository _orderConfirmationRepository =
      OrderConfirmationRepository();

  bool _isPasswordVisible = false;
  bool _isTokenAvailable = false;

  TextEditingController _textCardNumber = TextEditingController();
  TextEditingController _textCardHolderName = TextEditingController();
  TextEditingController _textCvv = TextEditingController();
  TextEditingController _textExpMonth = TextEditingController();
  TextEditingController _textExpYear = TextEditingController();
  FocusNode _focusNodeCardHolderName = FocusNode();
  FocusNode _focusNodeCardNumber = FocusNode();
  FocusNode _focusNodeCvv = FocusNode();
  FocusNode _focusNodeExpMonth = FocusNode();
  FocusNode _focusNodeExpYear = FocusNode();
  GetOrderByIdResponse _getOrderByIdResponse = GetOrderByIdResponse();

  //constructor
  PaymentCardNotifier(context, String cartResponseId) {
    super.context = context;
    log.i("cartResponseid ---------------> $cartResponseId");
    callApiGetOrderById(cartResponseId);
  }

  //////////
  TextEditingController get textCardNumber => _textCardNumber;

  set textEditEmailId(TextEditingController value) {
    _textCardNumber = value;
    notifyListeners();
  }

  TextEditingController get textCardHolderName => _textCardHolderName;

  set textCardHolderName(TextEditingController value) {
    _textCardHolderName = value;
    notifyListeners();
  }

  TextEditingController get textCvv => _textCvv;

  set textCvv(TextEditingController value) {
    _textCvv = value;
    notifyListeners();
  }

  TextEditingController get textExpMonth => _textExpMonth;

  set textExpMonth(TextEditingController value) {
    _textExpMonth = value;
    notifyListeners();
  }

  TextEditingController get textExpYear => _textExpYear;

  set textExpYear(TextEditingController value) {
    _textExpYear = value;
    notifyListeners();
  }

  FocusNode get focusNodeCardHolderName => _focusNodeCardHolderName;

  set focusNodeCardHolderName(FocusNode value) {
    _focusNodeCardHolderName = value;
    notifyListeners();
  }

  FocusNode get focusNodeCardNumber => _focusNodeCardNumber;

  set focusNodeCardNumber(FocusNode value) {
    _focusNodeCardNumber = value;
    notifyListeners();
  }

  FocusNode get focusNodeCvv => _focusNodeCvv;

  set focusNodeCvv(FocusNode value) {
    _focusNodeCvv = value;
    notifyListeners();
  }

  FocusNode get focusNodeExpMonth => _focusNodeExpMonth;

  set focusNodeExpMonth(FocusNode value) {
    _focusNodeExpMonth = value;
    notifyListeners();
  }

  FocusNode get focusNodeExpYear => _focusNodeExpYear;

  set focusNodeExpYear(FocusNode value) {
    _focusNodeExpYear = value;
    notifyListeners();
  }

  GetOrderByIdResponse get getOrderByIdResponse => _getOrderByIdResponse;

  set getOrderByIdResponse(GetOrderByIdResponse value) {
    _getOrderByIdResponse = value;
    notifyListeners();
  }

  ////////
  // Getter Setter for Variables

  //api login
  Future<LoginResponse> callApiLoginUser(String email, String password) async {
    log.i('api ::: apiLoginUser called');
    super.isLoading = true;
    LoginResponse response = LoginResponse();
    try {
      response = await _repository
          .apiUserLogin(LoginRequest(username: email, password: password));
      super.isLoading = false;
    } catch (e) {
      log.e(e.toString());
      super.isLoading = false;
    }
    return response;
  }

  void onNewGetOrderResponse(GetOrderByIdResponse response) {
    if (response != null) {
      getOrderByIdResponse = response;
    }
  }

  //api getAdminToken
  //api: get order by id
  void callApiGetOrderById(String id) async {
    log.i('api ::: callApiGetOrderById called');
    super.isLoading = true;
    try {
      GetOrderByIdResponse response =
          await _orderConfirmationRepository.apiGetOrderByIdResponse(id);
      onNewGetOrderResponse(response);
      super.isLoading = false;
    } catch (e) {
      log.e("Error :" + e.toString());

      super.isLoading = false;
    }
  }

// get sub category list
  Future<PaymentCardResponse> callApiCardPayment(
      PaymentCardRequest paymentCardRequest) async {
    log.i('api ::: GetSubCategoryList called');
    //super.isLoading = true;
    PaymentCardResponse paymentCardResponse =
        await _commonRepository.cardPayment(paymentCardRequest);
    //super.isLoading = false;
    return paymentCardResponse;
  }

  //api: cart quote id
  Future<String> callApiCartQuoteId() async {
    log.i('api ::: callApiCartQuoteId called');
    super.isLoading = true;
    String response = await _orderConfirmationRepository
        .apiCartQuoteIdResponse()
        .whenComplete(() {
      super.isLoading = false;
    });
    if (response != null) {
      return response;
    } else {
      return null;
    }
  }
}
