import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:thought_factory/core/data/remote/request_response/forgot_password/forgot_pwd_response.dart';
import 'package:thought_factory/core/notifier/forgot_pwd_notifier.dart';
import 'package:thought_factory/utils/app_colors.dart';
import 'package:thought_factory/utils/app_constants.dart';
import 'package:thought_factory/utils/app_custom_icon.dart';
import 'package:thought_factory/utils/app_images.dart';
import 'package:thought_factory/utils/app_log_helper.dart';
import 'package:thought_factory/utils/app_text_style.dart';
import 'package:thought_factory/utils/widgetHelper/custom_prefix_icon.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const routeName = '/forgot_password_screen';

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController _textEditConEmail = TextEditingController();
  final log = getLogger('ForgotPasswordScreen');
  var _keyValidationForm = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ForgotPwdNotifier>(
      create: (context) => ForgotPwdNotifier(),
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: colorGrey,
        body: Consumer<ForgotPwdNotifier>(
          builder: (context, forgotPwdNotifier, _) => ModalProgressHUD(
            inAsyncCall: forgotPwdNotifier.isLoading,
            child: SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.only(top: 32.0, bottom: 100.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      getWidgetImageLogo(),
                      _buildWidgetForgotPassword(forgotPwdNotifier, context),
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }

  Widget getWidgetImageLogo() {
    return Container(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.only(top: 32, bottom: 32),
          child: Image.asset(
            AppImages.IMAGE_LOGO_THOUGHT_FACTORY,
            width: 90,
            height: 120,
          ),
        ));
  }

  Widget _buildWidgetForgotPassword(
      ForgotPwdNotifier forgotPwdNotifier, BuildContext context) {
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
            padding: const EdgeInsets.only(
                top: 24.0, bottom: 32.0, left: 24.0, right: 24.0),
            child: Form(
              key: _keyValidationForm,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    child: Text(
                      AppConstants.FORGOT_PASSWORD,
                      style: getFormTitleStyle(context),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 32.0, bottom: 32.0),
                    child: Text(
                      'The password reset link will be send to your registered Email ID.',
                      style:
                          getStyleCaption(context).copyWith(color: colorBlack),
                      textAlign: TextAlign.center,
                    ),
                  ), //text: info
                  Container(
                    margin: EdgeInsets.only(bottom: 32.0),
                    child: TextFormField(
                      textCapitalization: TextCapitalization.sentences,
                      controller: _textEditConEmail,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      validator: _validateEmail,
                      style: getFormStyleText(context),
                      decoration: InputDecoration(
                          isDense: true,
                          labelText: AppConstants.EMAIL,
                          contentPadding: EdgeInsets.only(top: 4.0),
                          labelStyle: getFormLabelStyleText(context),
                          prefixIcon:
                              buildCustomPrefixIcon(AppCustomIcon.icon_mail)),
                    ),
                  ), //text field: email
                  Container(
                    margin: EdgeInsets.only(top: 20.0),
                    width: double.infinity,
                    child: RaisedButton(
                      color: colorAccent,
                      textColor: Colors.white,
                      elevation: 5.0,
                      padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                      child: Text(
                        AppConstants.SUBMIT,
                        style: getStyleButtonText(context),
                      ),
                      onPressed: () {
                        if (_keyValidationForm.currentState.validate()) {
                          _onClickButtonSubmit(forgotPwdNotifier);
                        }
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0)),
                    ),
                  ), //button: submit
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value.length == 0) {
      return 'Email is required';
    } else if (!regex.hasMatch(value)) {
      return 'Invalid Email';
    } else {
      return null;
    }
  }

  //onclick: button Submit
  void _onClickButtonSubmit(ForgotPwdNotifier forgotPwdNotifier) async {
    log.i('Action Tap: LogIn button');
    ForgotPwdResponse forgotPwdResponse = await forgotPwdNotifier
        .callApiForgotPwd(_textEditConEmail.text, "email_reset");
    if (forgotPwdResponse != null) {
      if (forgotPwdResponse.isSuccess != null) {
        if (forgotPwdResponse.isSuccess == true) {
          Navigator.pop(context, true);
        } else if (forgotPwdResponse.message != null) {
          _showSnackBarMessage(
              'Please enter your registered email id to reset your password');
          //_showSnackBarMessage(forgotPwdResponse.message);
        }
      } else if (forgotPwdResponse.message != null) {
        _showSnackBarMessage(forgotPwdResponse.message);
      }
    } else {}
  }

  void _showSnackBarMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    // Find the Scaffold in the widget tree and use it to show a SnackBar.
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
