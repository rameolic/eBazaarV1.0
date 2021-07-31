import 'package:flutter/material.dart';
import 'package:thought_factory/utils/app_colors.dart';
import 'package:thought_factory/utils/app_constants.dart';
import 'package:thought_factory/utils/app_custom_icon.dart';
import 'package:thought_factory/utils/app_images.dart';
import 'package:thought_factory/utils/app_text_style.dart';
import 'package:thought_factory/utils/widgetHelper/custom_prefix_icon.dart';
import 'package:thought_factory/utils/app_validators.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const routeName = '/reset_password_screen';

   @override
   _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen>{

  TextEditingController _textEditNewPwd = TextEditingController();
  TextEditingController _textEditConfirmPwd = TextEditingController();
  final FocusNode _focusNodeConfirmPassword = FocusNode();
  var _keyValidationFormResetPassword = GlobalKey<FormState>();
  bool isNewPasswordVisible = false;
  bool isConfirmNewPasswordVisible = false;

  String confirmPasswordNotMatchError ="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorGrey,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 32, bottom: 100),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              _buildLogo(),
              _buildWidgetResetPassword(),
            ],
          ),
        ),
      ),

    );
  }

  Widget _buildLogo() {
    return Container(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.only(top: 64, bottom: 32),
          child: Image.asset(
            AppImages.IMAGE_LOGO_THOUGHT_FACTORY,
            width: 90,
            height: 120,
          ),
        ));
  }

  Widget _buildWidgetResetPassword() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Card(
          color: colorWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.FORM_CARD_CORNER),
          ),
          elevation: 10.0,
          child: Padding(
            padding: EdgeInsets.only(top: 24, bottom: 32.0, right: 24.0, left: 24.0),
            child: Form(
                key: _keyValidationFormResetPassword,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 16.0),
                      alignment: Alignment.center,
                      width: double.infinity,
                      child: Text(
                        AppConstants.RESET_PASSWORD,
                        style: getFormTitleStyle(context),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 32.0),
                      child: TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        controller: _textEditNewPwd,
                        maxLines: 1,
                        obscureText: isNewPasswordVisible ? false : true,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        style: getFormStyleText(context),
                        onFieldSubmitted: (String value) {
                          FocusScope.of(context).requestFocus(_focusNodeConfirmPassword);
                        },
                        //validator: (value) => validateEmptyCheck(value, "${AppConstants.NEW_PASSWORD} can\'t be empty"),
                        validator: (value) => validatedFieldOfErrorMessage(validateNewPasswordFieldEmptyAndLengthChecker(value), fieldName: AppConstants.NEW_PASSWORD),
                        decoration: InputDecoration(
                            isDense: true,
                            labelText: AppConstants.NEW_PASSWORD,
                            contentPadding: EdgeInsets.only(top: 4.0),
                            labelStyle: getFormLabelStyleText(context),
                            helperStyle: getStyleCaption(context),
                            prefixIcon: buildCustomPrefixIcon(AppCustomIcon.icon_pwd_key),
                            suffixIcon: IconButton(
                              icon: Icon(isNewPasswordVisible ? Icons.visibility : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  isNewPasswordVisible = !isNewPasswordVisible;
                                });
                              },
                            ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 32.0),
                      child: TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        controller: _textEditConfirmPwd,
                        maxLines: 1,
                        obscureText: isConfirmNewPasswordVisible ? false : true,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        style: getFormStyleText(context),
                        focusNode: _focusNodeConfirmPassword,
                        //validator: (value) => validateEmptyCheck(value, "${AppConstants.CONFIRM_PASSWORD} can\'t be empty"),
                        validator: (value) => validatedFieldOfErrorMessage(validateConfirmPasswordFieldEmptyCheck(value, _textEditNewPwd.text.toString()), fieldName: AppConstants.CONFIRM_PASSWORD),
                        decoration: InputDecoration(
                            isDense: true,
                            labelText: AppConstants.CONFIRM_PASSWORD,
                            contentPadding: EdgeInsets.only(top: 4.0),
                            helperText: confirmPasswordNotMatchError,
                            helperStyle: getStyleCaption(context).copyWith(color: colorPrimary),
                            labelStyle: getFormLabelStyleText(context),
                            prefixIcon: buildCustomPrefixIcon(AppCustomIcon.icon_pwd_key),
                            suffixIcon: IconButton(
                              icon: Icon(isConfirmNewPasswordVisible ? Icons.visibility : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  isConfirmNewPasswordVisible = !isConfirmNewPasswordVisible;
                                });
                              },
                            ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20.0),
                      width: double.infinity,
                      child: RaisedButton(
                        color: colorAccent,
                        textColor: Colors.white,
                        elevation: 5.0,
                        padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                        child: Text(
                          AppConstants.UPDATE,
                          style: getStyleButtonText(context),
                        ),
                        onPressed: () {
                          if (_keyValidationFormResetPassword.currentState.validate()) {
                            _onClickButtonUpdate();
                          }
                        },
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
                      ),
                    ),
                  ],
                )
            ),
          ),
        ),
      ),
    );
  }

  void _onClickButtonUpdate() {
   // Navigator.pop(context);
  }

}
