import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:thought_factory/state/state_change_password.dart';
import 'package:thought_factory/utils/app_colors.dart';
import 'package:thought_factory/utils/app_constants.dart';
import 'package:thought_factory/utils/app_custom_icon.dart';
import 'package:thought_factory/utils/app_font.dart';
import 'package:thought_factory/utils/app_screen_dimen.dart';
import 'package:thought_factory/utils/app_text_style.dart';
import 'package:thought_factory/utils/app_validators.dart';
import 'package:thought_factory/utils/common_widgets/app_bar.dart';
import 'package:thought_factory/utils/widgetHelper/build_small_caption.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  ChangePasswordContent createState() => ChangePasswordContent();
}

class ChangePasswordContent extends State<ChangePasswordScreen> {
  bool isAndroid;

  var currentPwdController = new TextEditingController();
  var newPwdController = new TextEditingController();
  var confirmPwdController = new TextEditingController();

  var currentController = new TextEditingController();
  var newController = new TextEditingController();
  var confirmController = new TextEditingController();

  final FocusNode _focusNodeNewPassword = FocusNode();
  final FocusNode _focusNodeConfirmNewPassword = FocusNode();

  double paddingLeft = 16.0;
  double paddingRight = 16.0;

  var _keyValidationFormChangePassword = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    isAndroid = checkPlatForm(context);
    return ChangeNotifierProvider(
      create: (context) => StateChangePassword(context),
      child: Consumer<StateChangePassword>(
        builder: (BuildContext context, stateChangePassword, _) =>
            ModalProgressHUD(
          inAsyncCall: stateChangePassword.isLoading,
          child: Scaffold(
            appBar: _appBar(context, stateChangePassword),
            backgroundColor: colorGrey,
            bottomNavigationBar: _buildBottom(stateChangePassword),
            body: _buildContentPage(stateChangePassword.current_pwd, context),
          ),
        ),
      ),
    );
  }

  Widget _appBar(
      BuildContext context, StateChangePassword stateChangePassword) {
    stateChangePassword.showSnackBarMessageParamASContext(context, "done");
    return buildAppBar(context, "0", AppConstants.CHANGE_PASSWORD);
  }

  Widget _buildBottom(StateChangePassword stateChangePassword) {
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
              child: RaisedButton(
                onPressed: () {
                  if (_keyValidationFormChangePassword.currentState
                      .validate()) {
                    if (newController.text == confirmController.text) {
                      stateChangePassword
                          .callChangePassword(
                              currentPwdController.text, newController.text)
                          .then((value) {
                        print("value --------> $value");
                        if (value == null) {
                          stateChangePassword.showSnackBarMessageWithContext(
                              "You're password has been changed successfully");
                        } else {
                          stateChangePassword
                              .showSnackBarMessageWithContext(value.message);
                        }
                        /* if (value) {
                        } else {
                          stateChangePassword.showMessage(context, value.message);
                        }*/
                      });
                    }
                  }
                },
                child: Text(
                  AppConstants.UPDATE,
                  style:
                      getStyleButtonText(context).copyWith(color: Colors.white),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0))),
                color: colorPrimary,
                padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
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
                  style:
                      getStyleButtonText(context).copyWith(color: Colors.white),
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

  Widget _buildContentPage(String name, BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: colorGrey,
        padding:
            EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0, bottom: 40.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            _buildFormContent(context),
          ],
        ),
      ),
    );
  }

  Widget _buildFormContent(BuildContext context) {
    var stateChangePassword = Provider.of<StateChangePassword>(context);
    double tToC = 8.0;
    double cToT = 12.0;
    return Form(
      key: _keyValidationFormChangePassword,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: cToT,
          ),
          buildSmallCaption("Current Password ", context),
          SizedBox(
            height: tToC,
          ),
          TextFormField(
              controller: currentPwdController,
              cursorColor: colorPrimary,
              obscureText: stateChangePassword.current_pwd_enabled,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              style: getStyleSubHeading(context).copyWith(
                  color: Colors.black, fontWeight: AppFont.fontWeightSemiBold),
              decoration: buildTextFieldOutLineDecoration(AppConstants.PASSWORD)
                  .copyWith(
                fillColor: colorWhite,
                suffixIcon: IconButton(
                  icon: Icon(
                    stateChangePassword.current_pwd_enabled
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: stateChangePassword.current_pwd_enabled
                        ? colorLightGrey
                        : colorPrimary,
                  ),
                  onPressed: () {
                    stateChangePassword.current_pwd_enabled =
                        stateChangePassword.current_pwd_enabled ? false : true;
                  },
                ),
              ),
//                  onChanged: (value) {
//                    stateChangePassword.current_pwd = value;
//                  },
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(_focusNodeNewPassword);
              },
              validator: _validateOldPassword),
          SizedBox(
            height: cToT,
          ),
          buildSmallCaption("New Password ", context),
          SizedBox(
            height: tToC,
          ),
          TextFormField(
            controller: newController,
            cursorColor: colorPrimary,
            obscureText: stateChangePassword.new_pwd_enabled,
            keyboardType: TextInputType.text,
            focusNode: _focusNodeNewPassword,
            textInputAction: TextInputAction.next,
            style: getStyleSubHeading(context).copyWith(
                color: Colors.black, fontWeight: AppFont.fontWeightSemiBold),
            decoration:
                buildTextFieldOutLineDecoration(AppConstants.PASSWORD).copyWith(
              fillColor: colorWhite,
              suffixIcon: IconButton(
                icon: Icon(
                  stateChangePassword.new_pwd_enabled
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: stateChangePassword.new_pwd_enabled
                      ? colorLightGrey
                      : colorPrimary,
                ),
                onPressed: () {
                  stateChangePassword.new_pwd_enabled =
                      stateChangePassword.new_pwd_enabled ? false : true;
                },
              ),
            ),
            onEditingComplete: () {
              stateChangePassword.confirm_pwd =
                  confirmController.text.toString();
              FocusScope.of(context).requestFocus(_focusNodeConfirmNewPassword);
            },
            validator: (value) => _validatePassword(value),
          ),
          SizedBox(
            height: cToT,
          ),
          buildSmallCaption("Confirm New Password ", context),
          SizedBox(
            height: tToC,
          ),
          TextFormField(
            controller: confirmController,
            cursorColor: colorPrimary,
            obscureText: stateChangePassword.confirm_pwd_enabled,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            focusNode: _focusNodeConfirmNewPassword,
            style: getStyleSubHeading(context).copyWith(
                color: Colors.black, fontWeight: AppFont.fontWeightSemiBold),
            decoration:
                buildTextFieldOutLineDecoration(AppConstants.PASSWORD).copyWith(
              fillColor: colorWhite,
              suffixIcon: IconButton(
                icon: Icon(
                  stateChangePassword.confirm_pwd_enabled
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: stateChangePassword.confirm_pwd_enabled
                      ? colorLightGrey
                      : colorPrimary,
                ),
                onPressed: () {
                  stateChangePassword.confirm_pwd_enabled =
                      stateChangePassword.confirm_pwd_enabled ? false : true;
                },
              ),
            ),
            onEditingComplete: () {
              stateChangePassword.confirm_pwd =
                  confirmController.text.toString();
              FocusScope.of(context).requestFocus(_focusNodeConfirmNewPassword);
            },
            validator: (value) => _validateConfirmPassword(value),
          ),
        ],
      ),
    );
  }

  InputDecoration buildTextFieldOutLineDecoration(String value) {
    return InputDecoration(
        isDense: true,
        //hintText: value,
        alignLabelWithHint: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(width: 0, style: BorderStyle.none)),
        filled: true,
        fillColor: colorWhite,
        contentPadding: EdgeInsets.all(16));
  }

  void onBackPress() {
    Navigator.of(context).pop();
  }

  String _validateOldPassword(String value) {
    return value.trim().length == 0 ? 'Old Password is required' : null;
  }

  String _validatePassword(String value) {
    if (value.length == 0) {
      return 'Password is required';
    } else if (value.length < 8) {
      return 'Min 8 char required';
    } else {
      return validatePassword(value);
    }
  }

  String _validateConfirmPassword(String value) {
    if (value.length == 0) {
      return 'Confirm password is required';
    } else if (value.length < 8) {
      return 'Min 8 char required';
    } else if (value != newController.text) {
      return 'password is Mismatched';
    } else {
      return null;
    }
  }
}
