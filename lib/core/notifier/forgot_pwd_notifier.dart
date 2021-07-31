import 'package:thought_factory/core/data/remote/repository/auth_repository.dart';
import 'package:thought_factory/core/data/remote/request_response/forgot_password/forgot_pwd_response.dart';
import 'package:thought_factory/core/data/remote/request_response/forgot_password/forgot_pwd_request.dart';
import 'package:thought_factory/utils/app_log_helper.dart';
import 'base/base_notifier.dart';

class ForgotPwdNotifier extends BaseNotifier {
  final log = getLogger('ForgotPwdNotifier');

  final _repository = AuthRepository();

  //api Forgot Pwd
  Future<ForgotPwdResponse> callApiForgotPwd(String email, String template) async {
    log.i('api ::: apiForgotPwd called');
    super.isLoading = true;
    ForgotPwdResponse response = await _repository.apiForgotPwd(ForgotPwdRequest(email: email, template: template));
    super.isLoading = false;
    return response;
  }
}
