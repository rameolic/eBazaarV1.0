import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:thought_factory/core/data/remote/request_response/update_profile/update_profile_request.dart';
import 'package:thought_factory/core/model/profile/profile_info.dart';
import 'package:thought_factory/core/notifier/myprofile_update_notifier.dart';
import 'package:thought_factory/utils/app_colors.dart';
import 'package:thought_factory/utils/app_constants.dart';
import 'package:thought_factory/utils/app_font.dart';
import 'package:thought_factory/utils/app_images.dart';
import 'package:thought_factory/utils/app_log_helper.dart';
import 'package:thought_factory/utils/app_screen_dimen.dart';
import 'package:thought_factory/utils/app_text_style.dart';
import 'package:thought_factory/utils/app_validators.dart';
import 'package:thought_factory/utils/common_widgets/app_bar.dart';
import 'package:thought_factory/utils/widgetHelper/build_small_caption.dart';

class EditProfile extends StatefulWidget {
  static const routeName = '/EditProfile';

  @override
  EditProfileState createState() => EditProfileState();
}

class EditProfileState extends State<EditProfile> {
  bool isAndroid;
  int currentSelection = 0;
  int countryValue = 0;
  double paddingLeft = 2.0;
  double paddingRight = 2.0;
  double paddingDropRight = 8.0;
  double paddingTop = 5;
  double paddingBottom = 5;
  var fieldFontWeight = AppFont.fontWeightSemiBold;
  var _keyValidationFormEditProfile = GlobalKey<FormState>();
  var phoneController = TextEditingController();
  var trnController = TextEditingController();
  var streetAddressController =
      TextEditingController(text: 'Lorem ipsum is a dummy of the content.');
  var zipCodeController = TextEditingController();
  final FocusNode _focusNodeLastName = FocusNode();
  final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodePhoneNumber = FocusNode();
  final FocusNode _focusNodePhone = FocusNode();
  double radiusValue = 50.0;
  final log = getLogger('Tab-GeneralInfo');
  BuildContext _scfoldContext = null;

  @override
  Widget build(BuildContext context) {
    ProfileInfo profileInfo = ModalRoute.of(context).settings.arguments;
    isAndroid = checkPlatForm(context);
    return ChangeNotifierProvider<MyProfileUpdateNotifier>(
      create: (context) => MyProfileUpdateNotifier(context, profileInfo),
      child: Consumer<MyProfileUpdateNotifier>(
        builder: (BuildContext context, stateEditProfile, _) =>
            ModalProgressHUD(
          inAsyncCall: stateEditProfile.isLoading,
          child: Scaffold(
            backgroundColor: colorGrey,
            body: _buildPageContent(context, profileInfo, stateEditProfile),
            bottomNavigationBar: buildBottom(stateEditProfile),
            appBar: _buildAppbar(),
          ),
        ),
      ),
    );
  }

  Widget _buildAppbar() {
    return buildAppBar(context, "0", AppConstants.DRAWER_ITEM_MY_PROFILE);
  }

  Widget _buildPageContent(BuildContext context, ProfileInfo profileInfo,
      MyProfileUpdateNotifier stateEditProfile) {
    _scfoldContext = context;
    return SingleChildScrollView(
      child: Container(
        color: colorGrey,
        padding:
            EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0, bottom: 40.0),
        child: Column(
          children: <Widget>[
            _buildProfileImage(profileInfo, context, stateEditProfile),
            SizedBox(
              height: 20.0,
            ),
            _buildFormContent(context, profileInfo, stateEditProfile),
          ],
        ),
      ),
    );
  }

  Column _buildProfileImage(ProfileInfo profileInfo, BuildContext context,
      MyProfileUpdateNotifier stateEditProfile) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 15.0,
        ),
        GestureDetector(
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) =>
                    _buildPopUpDialogForImageSelection(
                        context, stateEditProfile));
          },
          child: Stack(
            children: <Widget>[
              (stateEditProfile.imageLocalFile == null)
                  ? CachedNetworkImage(
                      imageUrl: profileInfo.imageUrl ?? "",
                      //'http://i.imgur.com/QSev0hg.jpg',
                      imageBuilder: (context, imageProvider) => Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              alignment: Alignment.center,
                              image: imageProvider,
                              fit: BoxFit.cover),
                          //borderRadius: BorderRadius.all(Radius.circular(50.0)),
                          border: Border.all(
                            color: colorPrimary,
                            width: 3.0,
                          ),
                        ),
                      ),
                      //placeholder: (context, url) => CircularProgressIndicator(),
                      placeholder: (context, url) => _buildPlaceHolder(context),
                      //CircularProgressIndicator(strokeWidth: 4.0, backgroundColor: colorGMailRed, ),
                      errorWidget: (context, url, error) =>
                          _buildPlaceHolder(context),
                    )
                  : Container(
                      height: 100.0,
                      width: 100.0,
                      margin: EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            alignment: Alignment.center,
                            image: FileImage(stateEditProfile.imageLocalFile),
                            fit: BoxFit.cover),
                        border: Border.all(
                          color: colorDividerGrey,
                          width: 1.0,
                        ),
                      ),
                    ),
              Positioned(
                  top: 70.0,
                  left: 65.0,
                  height: 30.0,
                  width: 30.0,
                  child: Container(
                      padding: EdgeInsets.all(3.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Padding(
                          padding: EdgeInsets.all(3.0),
                          child: Icon(
                            Icons.camera_enhance,
                            color: colorPrimary,
                            size: 16.0,
                          )))),
            ],
          ),
        ),
        SizedBox(
          height: 0.0,
        ),
      ],
    );
  }

  Widget _buildFormContent(BuildContext context, ProfileInfo profileInfo,
      MyProfileUpdateNotifier stateEditProfile) {
    var _textFieldStyle =
        getStyleSubHeading(context).copyWith(fontWeight: fieldFontWeight);
    return Container(
      child: Form(
        key: _keyValidationFormEditProfile,
        child: Column(
          children: <Widget>[
            buildSmallCaption("Company Name ", context),
            Container(
              margin: EdgeInsets.only(top: 7.0, bottom: 16.0),
              //padding: EdgeInsets.only(left: paddingLeft,right: paddingRight, top: paddingTop, bottom: paddingBottom),
              child: TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  controller: stateEditProfile.textEditConFirstName,
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  style: _textFieldStyle,
                  onFieldSubmitted: (String value) {
                    FocusScope.of(context).requestFocus(_focusNodeLastName);
                  },
                  //validator: (value) => validateEmptyCheck(value, "${AppConstants.NEW_PASSWORD} can\'t be empty"),
                  validator: (value) => validateEmptyCheck(
                      value, AppConstants.FIRST_NAME + " Can't be empty"),
                  decoration: _buildTextDecoration()),
            ),
            buildSmallCaption("Location ", context),
            Container(
              margin: EdgeInsets.only(top: 7.0, bottom: 16.0),
              child: TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  controller: stateEditProfile.textEditConLastName,
                  maxLines: 1,
                  focusNode: _focusNodeLastName,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  style: _textFieldStyle,
                  onFieldSubmitted: (String value) {
                    FocusScope.of(context).requestFocus(_focusNodeEmail);
                  },
                  validator: (value) => validateEmptyCheck(
                      value, AppConstants.LAST_NAME + " Can't be empty"),
                  decoration: _buildTextDecoration()),
            ),
            buildSmallCaption("Email Address ", context),
            Container(
              margin: EdgeInsets.only(top: 7.0, bottom: 16.0),
              child: TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  controller: stateEditProfile.textEditConEmail,
                  maxLines: 1,
                  focusNode: _focusNodeEmail,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  style: _textFieldStyle,
                  onFieldSubmitted: (String value) {
                    FocusScope.of(context).requestFocus(_focusNodePhone);
                  },
                  validator: (value) => _validateEmail(value),
                  decoration: _buildTextDecoration()),
            ),
            Visibility(
                visible: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    buildSmallCaption("Phone Number ", context),
                    Container(
                      margin: EdgeInsets.only(top: 7.0, bottom: 16.0),
                      child: TextFormField(
                          textCapitalization: TextCapitalization.sentences,
                          controller: stateEditProfile.textEditConPhoneNumber,
                          maxLines: 1,
                          focusNode: _focusNodePhone,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            WhitelistingTextInputFormatter(RegExp("[0-9]"))
                          ],
                          textInputAction: TextInputAction.done,
                          style: _textFieldStyle,
                          onFieldSubmitted: (String value) {
                            //  FocusScope.of(context).requestFocus(_focusNodePhone);
                          },
                          validator: (value) => validateEmptyCheck(value,
                              AppConstants.PHONE_NUMBER + " Can't be empty"),
                          decoration: _buildTextDecoration()),
                    ),
                  ],
                )),
            Visibility(
              visible: false,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(
                    left: paddingLeft,
                    right: paddingRight,
                    top: 15,
                    bottom: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.add,
                      color: colorPrimary,
                    ),
                    Text(' Add New Address',
                        style: getStyleSubHeading(context).copyWith(
                            color: colorPrimary,
                            fontWeight: AppFont.fontWeightSemiBold))
                  ],
                ),
                decoration: BoxDecoration(
                    color: colorWhite,
                    borderRadius: BorderRadius.all(Radius.circular(50.0))),
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBottom(MyProfileUpdateNotifier stateEditProfile) {
    return Container(
      margin: EdgeInsets.only(bottom: 24),
      height: 80,
      color: Colors.transparent,
      alignment: Alignment.topCenter,
      child: Center(
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              flex: 1,
              child: Builder(
                builder: (BuildContext context) => RaisedButton(
                  onPressed: () {
                    if (_keyValidationFormEditProfile.currentState.validate()) {
                      stateEditProfile.callApiUpdateProfile(context);
                    }
                  },
                  child: Text(
                    AppConstants.UPDATE,
                    style: getStyleButtonText(context),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0))),
                  color: colorPrimary,
                  padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                ),
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              flex: 1,
              child: RaisedButton(
                onPressed: () {
                  onBackPress();
                },
                child: Text(
                  AppConstants.CANCEL,
                  style: getStyleButtonText(context),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0))),
                color: colorLightGrey,
                padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
          ],
        ),
      ),
    );
  }

  UpdateProfileRequest buildRequest(
      id, firstName, lastName, email, storeId, websiteId) {
    return UpdateProfileRequest(
        customer: Customer(
            id: id,
            firstname: firstName,
            lastname: lastName,
            email: email,
            storeId: storeId,
            websiteId: websiteId));
  }

  InputDecoration _buildTextDecoration() {
    return InputDecoration(
        isDense: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radiusValue),
            borderSide: BorderSide(width: 0, style: BorderStyle.none)),
        filled: true,
        fillColor: colorWhite,
        contentPadding: EdgeInsets.all(16));
  }

  void onBackPress() {
    Navigator.of(context).pop();
  }

  Container _buildPlaceHolder(BuildContext context) {
    return Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
            alignment: Alignment.center,
            image: AssetImage(AppImages.IMAGE_PROFILE_IMAGE_PLACE_HOLDER),
            fit: BoxFit.cover),
        //borderRadius: BorderRadius.all(Radius.circular(50.0)),
        border: Border.all(
          color: colorPrimary,
          width: 3.0,
        ),
      ),
    );
  }

  String _validateEmail(String value) {
    return value.trim().length == 0
        ? 'Email is required'
        : validateEmail(value);
  }

  Widget _buildPopUpDialogForImageSelection(
      BuildContext context, MyProfileUpdateNotifier stateEditProfile) {
    double widget = getScreenWidth(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(16),
          child: Center(
            child: SizedBox(
              //height: height / 3.0,
              width: widget - 32,
              child: Card(
                color: colorWhite,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                elevation: 10.0,
                child: Padding(
                    padding: const EdgeInsets.only(
                        top: 24.0, bottom: 32.0, left: 24.0, right: 24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Choose Option ',
                            textAlign: TextAlign.center,
                            style: getStyleSubHeading(context).copyWith(
                                color: Colors.black,
                                fontWeight: AppFont.fontWeightSemiBold)),
                        verticalSpace(8),
                        Divider(
                          height: 1.0,
                          color: colorDividerGrey,
                        ),
                        verticalSpace(16),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Icon(
                              Icons.photo_library,
                              color: colorPrimary,
                            ),
                            RaisedButton(
                              color: colorWhite,
                              textColor: colorBlack,
                              padding: EdgeInsets.only(left: 16),
                              elevation: 0.0,
                              child: Text(
                                AppConstants.GALLERY,
                                style: getStyleButtonText(context)
                                    .copyWith(color: colorBlack),
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                              ),
                              onPressed: () {
                                try {
                                  openGallery(stateEditProfile, context);
                                } catch (e) {
                                  log.e('Error Camera : ' + e.toString());
                                }
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Icon(
                              Icons.camera_enhance,
                              color: colorPrimary,
                            ),
                            RaisedButton(
                              color: colorWhite,
                              textColor: colorBlack,
                              padding: EdgeInsets.only(left: 16),
                              elevation: 0.0,
                              child: Text(
                                AppConstants.CAMERA,
                                style: getStyleButtonText(context)
                                    .copyWith(color: colorBlack),
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                              ),
                              onPressed: () {
                                try {
                                  openCamera(stateEditProfile, context);
                                } catch (e) {
                                  log.e('Error Camera : ' + e.toString());
                                }
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget verticalSpace(double height) {
    return SizedBox(
      height: height,
    );
  }

  _onPressChooseImage(
      BuildContext context, MyProfileUpdateNotifier stateEditProfile) {}

  Future openGallery(
      MyProfileUpdateNotifier stateEditProfile, BuildContext context) async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        //  stateEditProfile.imageLocalFile = value;
        _validateCompanyImage(value, stateEditProfile);
      }
    });
  }

  Future openCamera(
      MyProfileUpdateNotifier stateEditProfile, BuildContext context) async {
    await ImagePicker.pickImage(source: ImageSource.camera).then((value) {
      if (value != null) {
        // stateEditProfile.imageLocalFile = value;
        _validateCompanyImage(value, stateEditProfile);
      }
    });
  }

  Future _validateCompanyImage(
      File file, MyProfileUpdateNotifier profileEditNotifier) async {
    if (file != null) {
      var decodedImage = await decodeImageFromList(file.readAsBytesSync());
      if ((decodedImage.width >= 150 && decodedImage.width <= 256) &&
          (decodedImage.height >= 110 && decodedImage.height <= 256)) {
        profileEditNotifier.imageLocalFile = file;
        log.d(file.path.toString() +
            " " +
            decodedImage.width.toString() +
            " x " +
            decodedImage.height.toString());
      } else {
        profileEditNotifier.imageLocalFile = file;
        log.d("erooorr" +
            file.path.toString() +
            " " +
            decodedImage.width.toString() +
            " x " +
            decodedImage.height.toString());
        // profileEditNotifier.showCustomSnackBarMessageWithContext(AppConstants.IMAGE_PROFILE_PROTOCOL, bgColor: colorGMailRed, txtColor: colorWhite, ctx: _scfoldContext);
      }
    }
  }
}
