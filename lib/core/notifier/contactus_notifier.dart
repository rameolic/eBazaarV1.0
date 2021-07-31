
import 'package:flutter/src/widgets/framework.dart';
import 'package:thought_factory/core/data/remote/repository/contactus_repository.dart';
import 'package:thought_factory/core/data/remote/request_response/contact_us/ContactUsAddressResponse.dart';
import 'package:thought_factory/core/data/remote/request_response/contact_us/ContactUsFormRequest.dart';
import 'package:thought_factory/core/data/remote/request_response/contact_us/ContactUsFormResponse.dart';
import 'base/base_notifier.dart';


class ContactUsNotifier extends BaseNotifier {
  final _repository = ContactUsRepository();
  ContactAddressResponse _addressResponse = ContactAddressResponse();
  ContactAddressResponse get addressResponse => _addressResponse;

  set addressResponse(ContactAddressResponse value) {
    _addressResponse = value;
    notifyListeners();
  }
  ContactUsNotifier(BuildContext context) {
    super.context=context;
    callAddressList();
  }

  callAddressList() async {
    try {
      log.i('api ::: GetUserDetailByToken called');
      super.isLoading = true;
      ContactAddressResponse response = await _repository.apiGetContactAddress();
      settingData(response);
      super.isLoading = false;
    } on Exception catch (_) {
      print('Exception');
      super.isLoading = false;
    }

  }

  settingData(ContactAddressResponse response) {
    _addressResponse=response;
    //super.showSnackBarMessageWithContext(_addressResponse.contactAddResponse1[0].message);
   }

  Future<ContactUsFormResponse> callPostContactUsData(ContactUsFormRequest requestParams) async {
    super.isLoading = true;
    ContactUsFormResponse response = await _repository.apiContactUsForm(requestParams);
    super.isLoading = false;
    return response;
  }

}





