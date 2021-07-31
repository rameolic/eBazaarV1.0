import 'package:thought_factory/core/data/local/app_shared_preference.dart';
import 'package:thought_factory/core/data/remote/repository/common_repository.dart';
import 'package:thought_factory/core/data/remote/repository/manage_payment_repository.dart';
import 'package:thought_factory/core/data/remote/repository/order_confirmation_repository.dart';
import 'package:thought_factory/core/data/remote/request_response/cart/get_order_by_id/CreateOrderByIdResponse.dart';
import 'package:thought_factory/core/data/remote/request_response/manage_payment/add_new_card_request.dart';
import 'package:thought_factory/core/data/remote/request_response/manage_payment/manage_payment_response.dart';
import 'package:thought_factory/core/data/remote/request_response/product/card/PaymentCardRequest.dart';
import 'package:thought_factory/core/data/remote/request_response/product/card/PaymentCardResponse.dart';
import 'package:thought_factory/core/notifier/common_notifier.dart';
import 'package:thought_factory/utils/app_log_helper.dart';

import 'base/base_notifier.dart';

class PaymentCardNotifier1 extends BaseNotifier {
  final log = getLogger('PaymentCardNotifier');

  final _commonRepository = CommonRepository();
  final _paymentCardsRepository = ManagePaymentRepository();
  final OrderConfirmationRepository _orderConfirmationRepository =
      OrderConfirmationRepository();

  int selectedCardIndex = 1;
  String _cartResponseId = "", grandTotalAmt = "", orderId = "", orderName = "";
  String textCardNumber = "", textExpMonth = "", textExpYear = "", textCvv = "";

  String get cartResponseId => _cartResponseId;

  GetOrderByIdResponse _getOrderByIdResponse = GetOrderByIdResponse();

  List<NewCard> _paymentCardsList = List();

  List<NewCard> get paymentCardsList => _paymentCardsList;

  set paymentCardsList(List<NewCard> value) {
    _paymentCardsList = value;
    notifyListeners();
  }

  //constructor
  PaymentCardNotifier1(context, String cartResponseId) {
    super.context = context;
    this._cartResponseId = cartResponseId;
    callApiGetOrderById(cartResponseId);
    setDataForListCards();
  }

  GetOrderByIdResponse get getOrderByIdResponse => _getOrderByIdResponse;

  set getOrderByIdResponse(GetOrderByIdResponse value) {
    _getOrderByIdResponse = value;
    notifyListeners();
  }

  //api: get order by id
  void callApiGetOrderById(String id) async {
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

  Future setDataForListCards() async {
    super.isLoading = true;
    String customerID = await AppSharedPreference().getCustomerId();
    PaymentCardsListRequest paymentCardRequest = PaymentCardsListRequest(
        paymentcard: PaymentCard(
      customer_id: customerID,
      //   phoneNumber: textEditConPhoneNumber.text,
    ));
    await _paymentCardsRepository
        .apiPaymentCardsListDetail(
            paymentCardRequest, CommonNotifier().userToken)
        .then((value) {
      if (value != null) {
        _onNewPaymentCardsDetailResponse(value);
      }
    });
    super.isLoading = false;
  }

  void _onNewPaymentCardsDetailResponse(ManagePaymentListResponse value) {
    paymentCardsList.clear();
    if (value.status == 1 && value.data.length > 0) {
      paymentCardsList = value.data;
    }
  }

  void onNewGetOrderResponse(GetOrderByIdResponse response) {
    if (response != null) {
      getOrderByIdResponse = response;
      //fill required data orderName, orderID & grandTotalAmt
      if (response.extensionAttributes != null &&
          response.extensionAttributes.shippingAssignments != null &&
          response.extensionAttributes.shippingAssignments[0].items[0] != null)
        orderName =
            response.extensionAttributes.shippingAssignments[0].items[0].name ??
                "";

      orderId = response.incrementId ?? "";

      if (response.baseTotalDue != null) {
        grandTotalAmt = convertToDecimal(response.baseTotalDue.toString(), 2);
      }
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

  bool validateCardDetails() {
    return (textCardNumber.isNotEmpty &&
        textExpMonth.isNotEmpty &&
        textExpYear.isNotEmpty &&
        textCvv.isNotEmpty);
  }

  void updateSelectedCard(NewCard item) {
    textCardNumber = item.card_no;
    textExpMonth = item.exp_month;
    textExpYear = item.exp_year;
    textCvv = item.cvv;
  }

  void resetSelectedCard() {
    selectedCardIndex = -1;
    textCardNumber = "";
    textExpMonth = "";
    textExpYear = "";
    textCvv = "";
  }
}
