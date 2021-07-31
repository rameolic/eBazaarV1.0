import 'package:flutter/foundation.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:thought_factory/core/data/remote/repository/change_password_repository.dart';
import 'package:thought_factory/core/data/remote/request_response/change_password/change_password_request.dart';
import 'package:thought_factory/core/data/remote/request_response/change_password/change_password_response.dart';
import 'package:thought_factory/core/notifier/base/base_notifier.dart';
import 'package:thought_factory/core/notifier/common_notifier.dart';
import 'package:thought_factory/utils/app_constants.dart';

class StateChangePassword extends BaseNotifier {
  String _current_pwd = "";
  String _new_pwd = "";
  String _confirm_pwd = "";

  ChangePasswordRepository _repository = ChangePasswordRepository();

  bool _current_pwd_enabled = true;
  bool _new_pwd_enabled = true;
  bool _confirm_pwd_enabled = true;

  StateChangePassword(BuildContext context){
    //update scaffold context
    super.context = context;
  }

  String get current_pwd => _current_pwd;

  set current_pwd(String value) {
    _current_pwd = value;
    notifyListeners();
  }

  String get new_pwd => _new_pwd;

  set new_pwd(String value) {
    _new_pwd = value;
    notifyListeners();
  }

  String get confirm_pwd => _confirm_pwd;

  set confirm_pwd(String value) {
    _confirm_pwd = value;
    notifyListeners();
  }

  bool get current_pwd_enabled => _current_pwd_enabled;

  set current_pwd_enabled(bool value) {
    _current_pwd_enabled = value;
    notifyListeners();
  }

  bool get confirm_pwd_enabled => _confirm_pwd_enabled;

  set confirm_pwd_enabled(bool value) {
    _confirm_pwd_enabled = value;
    notifyListeners();
  }

  bool get new_pwd_enabled => _new_pwd_enabled;

  set new_pwd_enabled(bool value) {
    _new_pwd_enabled = value;
    notifyListeners();
  }

  ///============== api related works ============///
  //api: change password
  Future<ChangePasswordResponse> callChangePassword(String currentPassword, String newPassword) async {
    log.i('api ::: changePassword called');
    super.isLoading = true;
    ChangePasswordResponse changePasswordResponse = await _repository.changePassword(buildRequest(currentPassword, newPassword), CommonNotifier().userToken);
    super.isLoading = false;
    if (changePasswordResponse != null && changePasswordResponse.message != null) {
      //showSnackBarMessageWithContext(changePasswordResponse.message);
      return changePasswordResponse;
    } else {
      //showSnackBarMessageWithContext("You're password has been changed successfully");
      return null;
    }
  }

  void showMessage(BuildContext context, String message) {
    showSnackBarMessageParamASContext(context, message);
  }

  ChangePasswordRequest buildRequest(currentPassword, newPassword) {
    return ChangePasswordRequest(
      currentPassword: currentPassword,
      newPassword: newPassword
    );
  }
}
