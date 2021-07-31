import 'package:thought_factory/core/data/local/app_shared_preference.dart';
import 'package:thought_factory/core/data/remote/repository/common_repository.dart';
import 'package:thought_factory/core/data/remote/request_response/user/user_detail_response.dart';
import 'package:thought_factory/utils/app_log_helper.dart';

import 'base/base_notifier.dart';

class ProfileDetailNotifier extends BaseNotifier {
  final log = getLogger('ProfileDetailNotifier');

  UserDetailResponse _profileDetailResponse = UserDetailResponse();

  UserDetailResponse get profileDetailResponse => _profileDetailResponse;

  set profileDetailResponse(UserDetailResponse value) {
    this._profileDetailResponse = value;
  }

  void callApiGetUserProfileDetail() async {
    log.i('api ::: GetUserProfileDetail called');
    super.isLoading = true;
    String token = await AppSharedPreference().getUserToken();
    profileDetailResponse = await CommonRepository().apiGetUserDetailByToken(token);
    log.d(">>>>>>>>>>>" + profileDetailResponse.toString());
    super.isLoading = false;
  }
}
