import 'dart:convert';
import 'dart:io';

import 'package:thought_factory/core/data/remote/network/app_url.dart';
import 'package:thought_factory/core/data/remote/network/method.dart';
import 'package:thought_factory/core/data/remote/repository/base/base_repository.dart';
import 'package:thought_factory/core/data/remote/request_response/change_password/change_password_request.dart';
import 'package:thought_factory/core/data/remote/request_response/change_password/change_password_response.dart';
import 'package:thought_factory/utils/app_network_check.dart';

class ChangePasswordRepository extends BaseRepository {
  ChangePasswordRepository._internal();

  static final ChangePasswordRepository _singleInstance = ChangePasswordRepository._internal();

  factory ChangePasswordRepository() => _singleInstance;

  //api: Change Password
  Future<ChangePasswordResponse> changePassword(ChangePasswordRequest changePasswordRequest, String userToken) async {
    bool isNetworkAvail = await NetworkCheck().check();
    if (isNetworkAvail) {
      final response = await networkProvider.call(
          method: Method.PUT,
          pathUrl: AppUrl.pathChangePassword,
          body: changePasswordRequest.toJson(),
          headers: buildDefaultHeaderWithToken(userToken));
      if (response.statusCode == HttpStatus.ok) {
        ChangePasswordResponse changePasswordResponse = ChangePasswordResponse();
        changePasswordResponse.isSuccess = json.decode(response.body);
        //return ChangePasswordResponse().isSuccess = json.decode(response.body);
        return changePasswordResponse;
      } else if (response.statusCode == HttpStatus.badRequest) {
        return ChangePasswordResponse.fromJson(json.decode(response.body));
      } else {
        //need to handel network connection error
        return ChangePasswordResponse.fromJson(json.decode(response.body));
      }
    } else {
      return null;
    }
  }
}