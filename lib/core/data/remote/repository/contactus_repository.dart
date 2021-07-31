import 'dart:convert';
import 'dart:io';

import 'package:thought_factory/core/data/remote/network/app_url.dart';
import 'package:thought_factory/core/data/remote/network/method.dart';
import 'package:thought_factory/core/data/remote/request_response/contact_us/ContactUsAddressResponse.dart';
import 'package:thought_factory/core/data/remote/request_response/contact_us/ContactUsFormRequest.dart';
import 'package:thought_factory/core/data/remote/request_response/contact_us/ContactUsFormResponse.dart';
import 'package:thought_factory/core/data/remote/request_response/order/order_response.dart';
import 'package:thought_factory/utils/app_constants.dart';
import 'package:thought_factory/utils/app_network_check.dart';

import 'base/base_repository.dart';

class ContactUsRepository extends BaseRepository {
  ContactUsRepository._internal();

  static final ContactUsRepository _singleInstance = ContactUsRepository._internal();

  factory ContactUsRepository() => _singleInstance;

  Future<ContactAddressResponse> apiGetContactAddress() async {
    bool isNetworkAvail = await NetworkCheck().check();
    if (isNetworkAvail) {
      final response = await networkProvider.call(method: Method.GET, pathUrl: AppUrl.getContactUsAddress);
      if (response != null && response.statusCode == HttpStatus.ok) {

        //List<dynamic> list = json.decode(response.toString());
       // return ContactAddressResponse.fromJson(json.decode(response.body));
       // return ContactAddressResponse.fromJson(list[0]);
        List<ContactAddressResponse> listResponse = (json.decode(utf8.decode(response.bodyBytes)) as List).map((i) => ContactAddressResponse.fromJson(i)).toList();
        ContactAddressResponse contactAddressResponse = listResponse[0];
        return  contactAddressResponse;
      } else if (response != null && response.statusCode == HttpStatus.notFound) {
       // return ContactAddressResponse(message: "Error", status: 0);
        return ContactAddressResponse(wishlist: null);
      } else {
        //return ContactAddressResponse(message: "Error", status: 0);
        //throw Exception('failed to load post');
      }
    } else {
     // return ContactAddressResponse(message: AppConstants.ERROR_INTERNET_CONNECTION, status: 0);
      return ContactAddressResponse(wishlist: null);
    }
  }

  Future<ContactUsFormResponse> apiContactUsForm(ContactUsFormRequest requestParams) async {
    bool isNetworkAvail = await NetworkCheck().check();
    if (isNetworkAvail) {
      final response = await networkProvider.call(
          method: Method.POST,
          pathUrl: AppUrl.putContactDetails,
          body: requestParams.toJson(),
          headers: headerContentTypeAndAccept);
      if (response.statusCode == HttpStatus.ok) {
        return ContactUsFormResponse.fromJson(json.decode(response.body));
      } else if (response.statusCode == HttpStatus.unauthorized) {
        return ContactUsFormResponse.fromJson(json.decode(response.body));
      }
      else if (response.statusCode == HttpStatus.notFound) {
        return ContactUsFormResponse.fromJson(json.decode(response.body));
      }else {
        //need to handel network connection error
        return null;
      }
    } else {
      return ContactUsFormResponse(message: AppConstants.ERROR_INTERNET_CONNECTION);
    }
  }
}
