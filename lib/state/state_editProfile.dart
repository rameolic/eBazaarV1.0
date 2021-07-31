import 'package:flutter/foundation.dart';
import 'package:thought_factory/core/data/remote/repository/common_repository.dart';
import 'package:thought_factory/core/data/remote/repository/edit_profile_repository.dart';
import 'package:thought_factory/core/data/remote/request_response/update_profile/update_profile_request.dart';
import 'package:thought_factory/core/data/remote/request_response/update_profile/update_profile_response.dart';
import 'package:thought_factory/core/data/remote/request_response/user/user_detail_response.dart';
import 'package:thought_factory/core/notifier/base/base_notifier.dart';
import 'package:thought_factory/core/notifier/common_notifier.dart';
import 'package:thought_factory/utils/app_constants.dart';

class StateEditProfile extends BaseNotifier {
  String _firstName = AppConstants.FIRST_NAME;
  int _radioGender = AppConstants.GENDER;
  int _countryNumber = 0;
  int _stateValue = 0;
  int _city = 0;

  EditProfileRepository _editProfileRepository = EditProfileRepository();
  CommonRepository _commonRepository = CommonRepository();

  String get firstName => _firstName;

  set firstName(String value) {
    _firstName = value;
    notifyListeners();
  }

  int get radioGender => _radioGender;

  set radioGender(int value) {
    _radioGender = value;
    notifyListeners();
  }

  int get countryNumber => _countryNumber;

  set countryNumber(int value) {
    _countryNumber = value;
    notifyListeners();
  }

  int get stateValue => _stateValue;

  set stateValue(int value) {
    _stateValue = value;
    notifyListeners();
  }

  int get city => _city;

  set city(int value) {
    _city = value;
    notifyListeners();
  }

  ///============== api related works ============///
  //api: call Api Update Profile
  Future<UpdateProfileResponse> callApiUpdateProfile(UpdateProfileRequest updateProfileRequest) async {
    log.i('api ::: callApiUpdateProfile called');
    super.isLoading = true;
    UpdateProfileResponse updateProfileResponse =
    await _editProfileRepository.updateProfile(updateProfileRequest, CommonNotifier().userToken);
    super.isLoading = false;
    return updateProfileResponse;
  }

  //api get user profile details
  Future<UserDetailResponse> callApiGetUserProfileDetail() async {
    log.i('api ::: GetUserProfileDetail called');
    super.isLoading = true;
    UserDetailResponse response = await _commonRepository.apiGetUserDetailByToken(CommonNotifier().userToken);
    log.i("userdetailresponse ----------------------> $response");
    super.isLoading = false;
    if (response != null) {
      return response;
    } else {
      return null;
    }
  }

  UpdateProfileRequest buildRequest() {
    return UpdateProfileRequest(customer: Customer(

    ));
  }
}
