import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:thought_factory/core/data/remote/network/app_url.dart';
import 'package:thought_factory/core/data/remote/repository/edit_profile_repository.dart';
import 'package:thought_factory/core/data/remote/request_response/update_profile/update_profile_request.dart';
import 'package:thought_factory/core/model/profile/profile_info.dart';
import 'package:thought_factory/utils/app_constants.dart';
import 'package:thought_factory/utils/app_network_check.dart';
import 'base/base_notifier.dart';
import 'common_notifier.dart';

class MyProfileUpdateNotifier extends BaseNotifier {
  CommonNotifier commonNotifier = CommonNotifier();
  TextEditingController _textEditConEmail = TextEditingController();
  TextEditingController _textEditConFirstName = TextEditingController();
  TextEditingController _textEditConLastName = TextEditingController();
  TextEditingController textEditConPhoneNumber = TextEditingController();

  TextEditingController get textEditConEmail => _textEditConEmail;
  EditProfileRepository _editProfileRepository = EditProfileRepository();
  ProfileInfo profileInfo;
  File _imageLocalFile = null;

  File get imageLocalFile => _imageLocalFile;

  set imageLocalFile(File value) {
    _imageLocalFile = value;
    notifyListeners();
  }


  set textEditConEmail(TextEditingController value) {
    _textEditConEmail = value;
  }

  TextEditingController get textEditConFirstName => _textEditConFirstName;

  TextEditingController get textEditConLastName => _textEditConLastName;

  set textEditConLastName(TextEditingController value) {
    _textEditConLastName = value;
  }

  set textEditConFirstName(TextEditingController value) {
    _textEditConFirstName = value;
  }

  MyProfileUpdateNotifier(BuildContext context, ProfileInfo profileInfo) {
    super.context = context;
    this.profileInfo = profileInfo;
    setUpData(profileInfo);
  }

  EditProfileRepository get editProfileRepository => _editProfileRepository;

  set editProfileRepository(EditProfileRepository value) {
    _editProfileRepository = value;
    notifyListeners();
  }

  callApiUpdateProfile(BuildContext context) async {
    if (profileInfo.firstName != textEditConFirstName.text ||
        profileInfo.lastName != textEditConLastName.text ||
        profileInfo.mailID != textEditConEmail.text || imageLocalFile != null
     //   || profileInfo.mobileNumber != textEditConPhoneNumber.text
    ) {
      super.isLoading = true;
      UpdateProfileRequest updateRequest = UpdateProfileRequest(
          customer: Customer(
              storeId: profileInfo.storeId,
              email: textEditConEmail.text,
              firstname: textEditConFirstName.text,
              id: profileInfo.id,
              lastname: textEditConLastName.text,
           //   phoneNumber: textEditConPhoneNumber.text,
              websiteId: profileInfo.websSiteid));
      await _editProfileRepository
          .updateProfile(updateRequest, CommonNotifier().userToken)
          .then((onValue) {
        if (onValue.message != AppConstants.ERROR) {
          super.isLoading = false;
          if (imageLocalFile != null) {
            callImageUploadApi(imageLocalFile,context);
          } else {
            Navigator.pop(context, 'onValue');
          }
        } else {
          super.isLoading = false;
         // super.showSnackBarMessageWithContext(onValue.message);
        }
      });

    }
  }

  void setUpData(ProfileInfo profileInfo) async {
    log.d(">>> " + profileInfo.mobileNumber ?? "");
    textEditConFirstName.text = profileInfo.firstName;
    textEditConLastName.text = profileInfo.lastName;
    _textEditConEmail.text = profileInfo.mailID;
    textEditConPhoneNumber.text = profileInfo.mobileNumber;
  }

//api : upload profile image
  Future<void> callImageUploadApi(File profileImageFile, BuildContext context) async {
    log.i('api ::: callApiUploadProfileImage called');

    bool isNetworkAvail = await NetworkCheck().check();
    if (isNetworkAvail) {
      super.isLoading = true;
      Dio dio = Dio();
      dio.options.baseUrl = AppUrl.baseUrl;
     /* dio.options.contentType =
          ContentType.parse("application/x-www-form-urlencoded");*/
      FormData formData = FormData.fromMap({
        "customer_id": profileInfo.id,
        "profile_picture": await MultipartFile.fromFile(profileImageFile.path,
            filename: DateTime.now().toString().substring(0, 10) + ".png")
      });
      var response = await dio.post(AppUrl.postProfileImage, data: await formData);
      if (response.statusCode == 200) {
        try {
          log.d(response.data.toString());
        } catch (e) {
          super.isLoading = false;
          log.d("Error is :" + e.toString());
        }
        super.isLoading = false;
        Navigator.pop(context, 'onValue1');

      } else {
        //showSnackBarMessageWithContext("Upload Failed. Please Try again.");
        showSnackBarMessageParamASContext(context , "Upload Failed. Please Try again.");
      }
    }
    else{
      showSnackBarMessageWithContext(AppConstants.ERROR_INTERNET_CONNECTION);
    }

  }


//  Future callImageUploadApi(File imageLocalFile) async {
//    bool isNetworkAvail = await NetworkCheck().check();
//    if (isNetworkAvail) {
//      Dio dio = Dio();
//      dio.options.contentType = ContentType.parse('text/plain');
//      FormData formData = FormData.from({
//        "profile_picture": new UploadFileInfo(_imageLocalFile,
//            DateTime.now().toString().substring(0, 10) + ".jpg"),
//         "customer_id": profileInfo.id
//      });
//       await dio.post(
//          AppUrl.postProfileImage, data: formData).then((value){
//         super.isLoading = false;
//            if(value!=null){
//              if (value.statusCode == 200) {
//                showSnackBarMessageWithContext("Company logo uploaded successfully.");
//                Navigator.pop(context, 'onValue');
//              } else {
//                showSnackBarMessageWithContext("Upload Failed. Please Try again.");
//              }
//            }
//      });
//
//
//    }
//  }
}