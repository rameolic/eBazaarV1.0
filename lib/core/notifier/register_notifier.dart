import 'package:flutter/foundation.dart';
import 'package:thought_factory/core/data/remote/repository/auth_repository.dart';
import 'package:thought_factory/core/data/remote/request_response/register/register_request.dart';
import 'package:thought_factory/core/data/remote/request_response/register/register_response.dart';
import 'package:thought_factory/utils/app_constants.dart';
import 'package:thought_factory/utils/app_log_helper.dart';

class RegisterNotifier extends ChangeNotifier {
  final log = getLogger('RegisterNotifier');

  final _repository = AuthRepository();
  bool _isLoading = false;

  get isLoading => _isLoading;

  set isLoading(value) {
    log.i('loading value is : $value)');
    _isLoading = value;
    notifyListeners();
  }

  //api registration
  Future<RegisterResponse> apiRegisterUser(String firstName, String lastName, String email, String password,String trn) async {
    log.i('api ::: apiRegisterUser called');
    isLoading = true;
    RegisterResponse response =
        await _repository.userRegistration(_buildRequestBodyForRegister(firstName, lastName, email, password, trn));

    log.i('respose : ${response.toString()}');
    isLoading = false;
    return response;
  }

  //build response for api registration
  RegisterRequest _buildRequestBodyForRegister(String firstName, String lastName, String email, String password, String trn) {
    List<CustomAttributes> customAttributes = List();
    customAttributes.add(CustomAttributes(attributeCode: 'trn_no',value: trn));

    return RegisterRequest(
        customer:
            Customer(firstname: firstName, lastname: lastName, email: email, groupId: AppConstants.GROUP_ID_SHOP_OWNER,customAttributes: customAttributes),
        password: password);
  }

}
