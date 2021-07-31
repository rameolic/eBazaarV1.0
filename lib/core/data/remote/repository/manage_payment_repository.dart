import 'package:thought_factory/core/data/remote/network/app_url.dart';
import 'package:thought_factory/core/data/remote/network/method.dart';
import 'package:thought_factory/core/data/remote/request_response/cart/cart_list/response_remove_cart.dart';
import 'package:thought_factory/core/data/remote/request_response/manage_payment/add_new_card_request.dart';
import 'package:thought_factory/core/data/remote/request_response/manage_payment/add_new_card_response.dart';
import 'package:thought_factory/core/data/remote/request_response/manage_payment/manage_payment_response.dart';
import 'package:thought_factory/core/data/remote/request_response/manage_payment/remove_card_response.dart';

import 'package:thought_factory/utils/app_constants.dart';
import 'package:thought_factory/utils/app_network_check.dart';
import 'base/base_repository.dart';
import 'dart:convert';
import 'dart:io';

class ManagePaymentRepository extends BaseRepository {
  ManagePaymentRepository._internal();

  static final ManagePaymentRepository _singleInstance = ManagePaymentRepository._internal();

  factory ManagePaymentRepository() => _singleInstance;

  Future<AddNewCardResponse> addNewCard(AddNewCardRequest addNewCardRequest, String userToken) async {
    bool isNetworkAvail = await NetworkCheck().check();
    if (isNetworkAvail) {
      final response = await networkProvider.call(
          method: Method.POST,
          pathUrl: AppUrl.addNewCard,
          body: addNewCardRequest.toJson(),
          headers: buildDefaultHeaderWithToken(userToken));
      if (response.statusCode == HttpStatus.ok) {
        return AddNewCardResponse.fromJson(json.decode(response.body));
      } else if (response.statusCode == HttpStatus.badRequest) {
        return AddNewCardResponse(message: AppConstants.ERROR);
      } else {
        //need to handel network connection error
        return AddNewCardResponse(message: AppConstants.ERROR);
      }
    } else {
      return AddNewCardResponse(message: AppConstants.ERROR_INTERNET_CONNECTION);
    }
  }


  Future<ManagePaymentListResponse> apiPaymentCardsListDetail(PaymentCardsListRequest paymentCardsListRequest, String userToken) async {
    bool isNetworkAvail = await NetworkCheck().check();
    if (isNetworkAvail) {
      final response = await networkProvider.call(
        method: Method.POST,
        body: paymentCardsListRequest.toJson(),
        headers: buildDefaultHeaderWithToken(userToken),
        pathUrl: AppUrl.managePaymentList,
      );

      if (response.statusCode == HttpStatus.ok) {
        if (response.body != null) {
          return ManagePaymentListResponse.fromJson(
              json.decode(response.body));
        } else {
          return ManagePaymentListResponse(
              message: AppConstants.ERROR, status: 0);
        }
      } else {
        return ManagePaymentListResponse(
            message: AppConstants.ERROR, status: 0);
      }
    } else {
      return ManagePaymentListResponse(
          message: AppConstants.ERROR_INTERNET_CONNECTION, status: 0);
    }
  }

}