




import 'package:flutter/cupertino.dart';
import 'package:thought_factory/core/data/remote/request_response/termsandcondition/terms_condition_response.dart';
import 'package:thought_factory/core/notifier/base/base_notifier.dart';

import 'common_notifier.dart';

class TermsAndConditionNotifier extends BaseNotifier {

  TermsConditionResponse _termsAndConditionResponse = TermsConditionResponse();
  TermsConditionResponse get termsAndConditionResponse => _termsAndConditionResponse;
  String id;
  set termsAndConditionResponse(TermsConditionResponse value) {
    _termsAndConditionResponse = value;
    notifyListeners();
  }
  TermsAndConditionNotifier(BuildContext context,String id) {
    super.context=context;
    this.id=id;
    setData();
  }

  Future setData() async {
    super.isLoading=true;
    await  CommonNotifier().callTermsAndCondition(id).then((value){
      if(value!=null){
        termsAndConditionResponse=value;
      }
    });
    super.isLoading=false;
  }


}