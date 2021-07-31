import 'dart:convert';
import 'dart:io';

import 'package:thought_factory/core/data/remote/network/app_url.dart';
import 'package:thought_factory/core/data/remote/network/method.dart';
import 'package:thought_factory/core/data/remote/request_response/forgot_password/forgot_pwd_request.dart';
import 'package:thought_factory/core/data/remote/request_response/forgot_password/forgot_pwd_response.dart';
import 'package:thought_factory/core/data/remote/request_response/login/login_response.dart';
import 'package:thought_factory/core/data/remote/request_response/login/request.dart';
import 'package:thought_factory/core/data/remote/request_response/register/register_request.dart';
import 'package:thought_factory/core/data/remote/request_response/register/register_response.dart';
import 'package:thought_factory/utils/app_constants.dart';
import 'package:thought_factory/utils/app_network_check.dart';

import 'base/base_repository.dart';

import 'package:thought_factory/otpverification.dart';
class AuthRepository extends BaseRepository {
  AuthRepository._internal();

  static final AuthRepository _singleInstance = AuthRepository._internal();

  factory AuthRepository() => _singleInstance;

  //api: Registration
  Future<RegisterResponse> userRegistration(RegisterRequest requestParams) async {
    bool isNetworkAvail = await NetworkCheck().check();
    if (isNetworkAvail) {
      final response = await networkProvider.call(
          method: Method.POST,
          pathUrl: AppUrl.pathRegister,
          body: requestParams.toJson(),
          headers: headerContentTypeAndAccept);

      if (response.statusCode == HttpStatus.ok) {
        return RegisterResponse.fromJson(json.decode(response.body));
      } else if (response.statusCode == HttpStatus.badRequest) {
        return RegisterResponse.fromJson(json.decode(response.body));
      } else {
        //need to handel network connection error
        return null;
      }
    } else {
      return RegisterResponse(message: AppConstants.ERROR_INTERNET_CONNECTION);
    }
  }

  //api: Login
  Future<LoginResponse> apiUserLogin(LoginRequest requestParams) async {
    bool isNetworkAvail = await NetworkCheck().check();
    if (isNetworkAvail) {
      final response = await networkProvider.call(
          method: Method.POST,
          pathUrl: AppUrl.pathLogin,
          body: requestParams.toJson(),
          headers: headerContentTypeAndAccept);
      if(tokenfromotp != "" && tokenfromotp != null){
        return LoginResponse(token: tokenfromotp);
      }else
      if (response.statusCode == HttpStatus.ok) {
        String token = json.decode(response.body);

        if (token.isEmpty) {
          return LoginResponse(message: 'Server error: Token is empty');
        } else {
          return LoginResponse(token: token);
        }
      } else if (response.statusCode == HttpStatus.unauthorized) {
        return LoginResponse.fromJson(json.decode(response.body));
      }
      else if (response.statusCode == HttpStatus.notFound) {
        return LoginResponse.fromJson(json.decode(response.body));
      }else {
        //need to handel network connection error
        return null;
      }
    } else {
      return LoginResponse(message: AppConstants.ERROR_INTERNET_CONNECTION);
    }
  }

  //api: getAdminToken
  Future<LoginResponse> apiAdminToken(LoginRequest requestParams) async {
    bool isNetworkAvail = await NetworkCheck().check();
    if (isNetworkAvail) {
      final response = await networkProvider.call(
          method: Method.POST,
          pathUrl: AppUrl.pathAdminToken,
          body: requestParams.toJson(),
          headers: headerContentTypeAndAccept);

      if (response.statusCode == HttpStatus.ok) {
        String token = json.decode(response.body);

        if (token.isEmpty) {
          return LoginResponse(message: 'Server error: Token is empty');
        } else {
          return LoginResponse(token: token);
        }
      } else if (response.statusCode == HttpStatus.unauthorized) {
        return LoginResponse.fromJson(json.decode(response.body));
      } else {
        //need to handel network connection error
        return null;
      }
    } else {
      return LoginResponse(message: AppConstants.ERROR_INTERNET_CONNECTION);
    }
  }

  //api: Forgot Password
  Future<ForgotPwdResponse> apiForgotPwd(ForgotPwdRequest requestParams) async {
    bool isNetworkAvail = await NetworkCheck().check();
    if (isNetworkAvail) {
      final response = await networkProvider.call(
          method: Method.PUT,
          pathUrl: AppUrl.pathForgotPwd,
          body: requestParams.toJson(),
          headers: headerContentTypeAndAccept);

      if (response.statusCode == HttpStatus.ok) {
        bool isSuccess = json.decode(response.body);
        if (isSuccess == null) {
          return ForgotPwdResponse(message: 'Server error: Operation Failed');
        } else {
          return ForgotPwdResponse(isSuccess: isSuccess);
        }
      } else if (response.statusCode == HttpStatus.unauthorized) {
        return ForgotPwdResponse.fromJson(json.decode(response.body));
      } else if (response.body != null) {
        return ForgotPwdResponse.fromJson(json.decode(response.body));
      } else {
        //need to handel network connection error
        return null;
      }
    } else {
      return ForgotPwdResponse(message: AppConstants.ERROR_INTERNET_CONNECTION);
    }
  }
}
