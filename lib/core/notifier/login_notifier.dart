import 'package:thought_factory/core/data/local/app_shared_preference.dart';
import 'package:thought_factory/core/data/remote/repository/auth_repository.dart';
import 'package:thought_factory/core/data/remote/repository/common_repository.dart';
import 'package:thought_factory/core/data/remote/request_response/login/login_response.dart';
import 'package:thought_factory/core/data/remote/request_response/login/request.dart';
import 'package:thought_factory/core/data/remote/request_response/user/user_detail_response.dart';
import 'package:thought_factory/core/notifier/common_notifier.dart';
import 'package:thought_factory/utils/app_constants.dart';
import 'package:thought_factory/utils/app_log_helper.dart';

import 'base/base_notifier.dart';

class LoginNotifier extends BaseNotifier {
  final log = getLogger('LoginNotifier');

  final _repository = AuthRepository();

  bool _isPasswordVisible = false;
  bool _isTokenAvailable = false;
  String _emailId = '';
  String _password = '';

  //constructor
  LoginNotifier() {
    //get admin token & save in sp for future use
    initSetUp();
  }

  void initSetUp() async {
    //await callApiGetAdminToken("admin", "admin123");
    await callApiGetAdminToken("admin", "admin123");
  }

  // Getter Setter for Variables
  bool get isPasswordVisible => _isPasswordVisible;

  set isPasswordVisible(bool value) {
    _isPasswordVisible = value;
    notifyListeners();
  }

  bool get isTokenAvailable => _isTokenAvailable;

  set isTokenAvailable(bool value) {
    _isTokenAvailable = value;
    notifyListeners();
  }

  String get emailId => _emailId;

  set emailId(String value) {
    _emailId = value;
    notifyListeners();
  }

  String get password => _password;

  set password(String value) {
    _password = value;
    notifyListeners();
  }

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

  //api getAdminToken
  Future<LoginResponse> callApiGetAdminToken(
      String email, String password) async {
    log.i('api ::: apiGetAdminToken called');
    LoginResponse response = await _repository
        .apiAdminToken(LoginRequest(username: email, password: password));
    String token = response.token;
    if (token != null && token.trim().length > 0) {
      log.i('GetAdminToken success with token : $token');
      //save user token to shared preference
      saveAdminToken(token);
    }
    return response;
  }

  //api registration
  Future<UserDetailResponse> callApiGetUserDetailByToken(String token) async {
    log.i('api ::: GetUserDetailByToken called');
    super.isLoading = true;
    UserDetailResponse response =
        await CommonRepository().apiGetUserDetailByToken(token);
    AppSharedPreference().saveCustomerId(response.id.toString());
    AppSharedPreference().setPreferenceData(
        AppConstants.KEY_CUSTOMER_NAME,
        (response.firstname != null)
            ? response.firstname
            : "" + " " + (response.lastname != null ? response.lastname : ""));
    AppSharedPreference().setPreferenceData(AppConstants.KEY_CUSTOMER_MAILID,
        (response.email != null) ? response.email : "");
    AppSharedPreference().setPreferenceData(
        AppConstants.KEY_MOBILE_NUMBER,
        (response.addresses != null && response.addresses.length > 0)
            ? response.addresses[0].telephone
            : "");
    super.isLoading = false;
    return response;
  }

  void saveUserToken(String token) async {
    CommonNotifier().userToken = token;
    bool isTokenSaved = await AppSharedPreference().saveUserToken(token);
    log.i('user token saved status: $isTokenSaved');
    String spUserToken = await AppSharedPreference().getUserToken();
    //update to common model for app use
    //CommonNotifier().userToken = spUserToken;
    log.i('test saved value from SP: $spUserToken');
  }

  void saveAdminToken(String token) async {
    bool isTokenSaved = await AppSharedPreference().saveAdminToken(token);
    log.i('Admin token saved satus: $isTokenSaved');
    String spAdminToken = await AppSharedPreference().getAdminToken();
    //update to common model for app use
    CommonNotifier().adminToken = spAdminToken;
    log.i('Admin saved value : $spAdminToken');
    print('Admin saved value : $spAdminToken');
  }

  void saveUserCredential(
      bool shouldRemember, String emailId, String password) async {
    if (shouldRemember) {
      // if yes remember
      AppSharedPreference()
          .saveStringValue(AppConstants.KEY_USER_EMAIL_ID, emailId);
      AppSharedPreference()
          .saveStringValue(AppConstants.KEY_USER_PASSWORD, password);
      AppSharedPreference()
          .saveBooleanValue(AppConstants.KEY_SHOULD_REMEMBER, true);
    }
//    else {
//      // No Remember
//      AppSharedPreference().saveStringValue(AppConstants.KEY_USER_EMAIL_ID, '');
//      AppSharedPreference().saveStringValue(AppConstants.KEY_USER_PASSWORD, '');
//      AppSharedPreference().saveBooleanValue(AppConstants.KEY_SHOULD_REMEMBER, false);
//    }
  }
}
