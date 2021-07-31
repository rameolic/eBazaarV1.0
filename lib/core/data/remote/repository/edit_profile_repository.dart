import 'dart:convert';
import 'dart:io';

import 'package:thought_factory/core/data/remote/network/app_url.dart';
import 'package:thought_factory/core/data/remote/network/method.dart';
import 'package:thought_factory/core/data/remote/repository/base/base_repository.dart';
import 'package:thought_factory/core/data/remote/request_response/update_profile/profile_image_response.dart';
import 'package:thought_factory/core/data/remote/request_response/update_profile/update_profile_request.dart';
import 'package:thought_factory/core/data/remote/request_response/update_profile/update_profile_response.dart';
import 'package:thought_factory/utils/app_constants.dart';
import 'package:thought_factory/utils/app_network_check.dart';

class EditProfileRepository extends BaseRepository {
  EditProfileRepository._internal();

  static final EditProfileRepository _singleInstance = EditProfileRepository._internal();

  factory EditProfileRepository() => _singleInstance;

  //api: update profile
  Future<UpdateProfileResponse> updateProfile(UpdateProfileRequest updateProfileRequest, String userToken) async {
    bool isNetworkAvail = await NetworkCheck().check();
    if (isNetworkAvail) {
      final response = await networkProvider.call(
          method: Method.PUT,
          pathUrl: AppUrl.pathUpdateProfile,
          body: updateProfileRequest.toJson(),
          headers: buildDefaultHeaderWithToken(userToken));
      if (response.statusCode == HttpStatus.ok) {
        return UpdateProfileResponse.fromJson(json.decode(response.body));
      } else if (response.statusCode == HttpStatus.badRequest) {
        return UpdateProfileResponse(message: AppConstants.ERROR);
      } else {
        //need to handel network connection error
        return UpdateProfileResponse(message: AppConstants.ERROR);
      }
    } else {
      return UpdateProfileResponse(message: AppConstants.ERROR_INTERNET_CONNECTION);
    }
  }

  //api post image
  Future<ProfileImageResponse> callApiUploadCompanyLogo(File companyLogoImageFile,String customerId) async {
//    /* Dio dio = Dio();
//    FormData formData = FormData.from({
//      "store_logo": new UploadFileInfo(companyLogoImageFile, DateTime.now().toString().substring(0, 10) + ".png"),
//      "customer_id": customerId
//    });*/
//    bool isNetworkAvail = await NetworkCheck().check();
//    if (isNetworkAvail) {
//      var match =
//      {"profile_picture":new UploadFileInfo(),
//        "customer_id": customerId};
//      final response = await networkProvider.call(
//          pathUrl: AppUrl.postProfileImage,
//          method: Method.POST,
//          encoding: Encoding.getByName("utf-8"),
//          body: match);
//      if (response.statusCode == 200) {
//        return ProfileImageResponse.fromJson(json.decode(response.body));
//      } else {
//        return ProfileImageResponse(message: "Error", status: 0);
//      }
//    }else {
//      return ProfileImageResponse(message: AppConstants.ERROR_INTERNET_CONNECTION, status: 0);
//    }

  }

}