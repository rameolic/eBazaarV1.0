import 'package:flutter/cupertino.dart';
import 'package:thought_factory/core/data/local/app_shared_preference.dart';
import 'package:thought_factory/core/data/remote/request_response/manage_payment/remove_card_response.dart';
import 'package:thought_factory/core/data/remote/request_response/manage_payment/add_new_card_request.dart';
import 'package:thought_factory/core/data/remote/repository/manage_payment_repository.dart';
import 'package:thought_factory/core/notifier/base/base_notifier.dart';
import 'package:thought_factory/core/data/remote/request_response/manage_payment/manage_payment_response.dart';
import 'common_notifier.dart';

class ManagePaymentListNotifier extends BaseNotifier {
  List<NewCard> _paymentCardsList = List();

  List<NewCard> get paymentCardsList => _paymentCardsList;

  String _message = "";

  String get message => _message;

  set message(String value) => this._message = value;

  set paymentCardsList(List<NewCard> value) {
    _paymentCardsList = value;
    notifyListeners();
  }

  final _paymentCardsRepository = ManagePaymentRepository();

  ManagePaymentListNotifier(BuildContext context) {
    super.context = context;
    setData();
  }

  Future setData() async {
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
        _onPaymentCardsDetailResponse(value);
      }
    });
    super.isLoading = false;
  }

  void _onPaymentCardsDetailResponse(ManagePaymentListResponse value) {
    if (value.status == 1 && value.data.length > 0) {
      paymentCardsList.clear();
      paymentCardsList = value.data;
    } else {
      _message = value.message;
      _paymentCardsList.clear();
    }
  }

  //api removeCart item
  void callApiRemoveCardItem(String itemId) async {
    log.i('api ::: apiRemoveCard called');
    super.isLoading = true;
    try {
      RemoveCardResponse response =
          await CommonNotifier().callApiRemoveCardItem(itemId);
      super.isLoading = false;
      if (response.status == 1) {
        setData();
      }
    } catch (e) {
      log.e(e.toString());
      super.isLoading = false;
    }
  }
}
