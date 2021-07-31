import 'package:thought_factory/core/data/local/app_shared_preference.dart';
import 'package:thought_factory/core/data/remote/repository/manage_payment_repository.dart';
import 'package:thought_factory/core/data/remote/request_response/manage_address/add_address_response.dart';
import 'package:thought_factory/core/data/remote/request_response/manage_payment/add_new_card_response.dart';
import 'package:thought_factory/utils/app_constants.dart';
import 'base/base_notifier.dart';
import 'package:flutter/material.dart';
import 'package:thought_factory/core/model/add_new_card.dart';
import 'package:thought_factory/core/data/remote/request_response/manage_payment/add_new_card_request.dart';
import 'common_notifier.dart';

class AddNewCardNotifier extends BaseNotifier {
  CommonNotifier commonNotifier = CommonNotifier();
  CardInfo cardInfo;
  ManagePaymentRepository _managePaymentRepository = ManagePaymentRepository();

  AddNewCardNotifier(BuildContext context) {
    super.context = context;
  }

  Future<AddNewCardResponse> callApiAddNewReCord(BuildContext context ,CardInfo cardInfo  ) async {
    AddNewCardResponse addNewcardResponse;
      super.isLoading = true;
      String customerID = await AppSharedPreference().getCustomerId();
      AddNewCardRequest addNewCardRequest= AddNewCardRequest(
          newcard: NewCard(
              customer_id: customerID,
              card_no: cardInfo.cardno,
              exp_month: cardInfo.expmonth,
              exp_year: cardInfo.expyear,
              cvv: cardInfo.cvv,
              //   phoneNumber: textEditConPhoneNumber.text,
              ));
    addNewcardResponse = await _managePaymentRepository
          .addNewCard(addNewCardRequest, CommonNotifier().userToken);
    print("message :"+addNewcardResponse.message);
    print("status :"+addNewcardResponse.status.toString());
    super.isLoading = false;
      return addNewcardResponse;
    }


}