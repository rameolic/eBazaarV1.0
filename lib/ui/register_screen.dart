import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:thought_factory/ProgressHUD.dart';
import 'package:thought_factory/core/data/local/app_shared_preference.dart';
import 'package:thought_factory/core/data/remote/request_response/register/register_response.dart';
import 'package:thought_factory/core/notifier/register_notifier.dart';
import 'package:thought_factory/utils/app_colors.dart';
import 'package:thought_factory/utils/app_constants.dart';
import 'package:thought_factory/utils/app_custom_icon.dart';
import 'package:thought_factory/utils/app_font.dart';
import 'package:thought_factory/utils/app_images.dart';
import 'package:thought_factory/utils/app_log_helper.dart';
import 'package:flushbar/flushbar.dart';
import 'package:thought_factory/utils/app_text_style.dart';
import 'package:thought_factory/utils/app_validators.dart';
import 'package:thought_factory/utils/widgetHelper/custom_prefix_icon.dart';
import 'dart:async';
import 'package:thought_factory/otpverification.dart';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';

bool ismobilevalidated = false;
var registrationotpentered;
Timer _timer;
int _start = 30;

class RegisterScreen extends StatefulWidget {
  static const routeName = '/register_screen';
  final log = getLogger('RegisterScreen');

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  static var _keyValidationForm = GlobalKey<FormState>();
  TextEditingController _textEditConFirstName = TextEditingController();
  TextEditingController _textEditConLastName = TextEditingController();
  TextEditingController _textEditConEmail = TextEditingController();
  TextEditingController _textEditConmobile = TextEditingController();
  TextEditingController _textEditConPassword = TextEditingController();
  TextEditingController _textEditConConfirmPassword = TextEditingController();
  TextEditingController _textEditTRN = TextEditingController();
  final FocusNode _fNodeLastName = FocusNode();
  final FocusNode _fNodeEmail = FocusNode();
  final FocusNode _fNodemobile = FocusNode();
  final FocusNode _fNodeTRN = FocusNode();
  final FocusNode _fNodePassword = FocusNode();
  final FocusNode _fNodeConfirmPassword = FocusNode();

  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    isPasswordVisible = false;
    isConfirmPasswordVisible = false;
    super.initState();
  }

  void startTimer() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    } else {
      _timer = new Timer.periodic(
        const Duration(seconds: 1),
        (Timer timer) => setState(
          () {
            if (_start < 1) {
              timer.cancel();
            } else {
              _start = _start - 1;
            }
          },
        ),
      );
    }
  }

  bool isotplogin = false;
  int _otpCodeLength = 4;
  bool _isLoadingButton = false;
  bool _enableButton = false;
  String _otpCode = "";
  _getSignatureCode() async {
    String signature = await SmsRetrieved.getAppSignature();
    print("signature $signature");
  }

  _onSubmitOtp() {
    setState(() {
      _isLoadingButton = !_isLoadingButton;
      _verifyOtpCode();
    });
  }

  _verifyOtpCode() async {
    register.otp = _otpCode;
  }

  _onOtpCallBack(String otpCode, bool isAutofill) {
    setState(() {
      this._otpCode = otpCode;
      if (otpCode.length == _otpCodeLength && isAutofill) {
        _enableButton = false;
        _isLoadingButton = true;
        _verifyOtpCode();
      } else if (otpCode.length == _otpCodeLength && !isAutofill) {
        _enableButton = true;
        _isLoadingButton = false;
      } else {
        _enableButton = false;
      }
    });
  }
  bool isApiCallProcess = false;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegisterNotifier>(
      create: (context) => RegisterNotifier(),
      child: ProgressHUD(
        inAsyncCall: isApiCallProcess,
        opacity: 0.3,
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: colorGrey,
          body: Consumer<RegisterNotifier>(
            builder: (context, registerNotifier, _) => ModalProgressHUD(
              inAsyncCall: registerNotifier.isLoading,
              child: SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.only(bottom: 32.0),
                    child: Column(
                      children: <Widget>[
                        _buildWidgetImageLogo(),
                        getWidgetRegistrationCard(registerNotifier),
                      ],
                    )),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWidgetImageLogo() {
    return Container(
      padding: EdgeInsets.only(top: 64, bottom: 32),
      alignment: Alignment.center,
      child: Image.asset(
        AppImages.IMAGE_LOGO_THOUGHT_FACTORY,
        width: 90,
        height: 120,
      ),
    );
  }

  Widget getWidgetRegistrationCard(registerNotifier) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Container(
        margin: EdgeInsets.only(bottom: 32.0),
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.FORM_CARD_CORNER),
          ),
          elevation: 10.0,
          child: Padding(
            padding: const EdgeInsets.only(
                top: 24.0, bottom: 16.0, left: 24.0, right: 24.0),
            child: Form(
              key: _keyValidationForm,
              child: Column(
                children: [
                  Text(
                    ismobilevalidated ? 'Verify Your Mobile' : 'Register',
                    style: getFormTitleStyle(context),
                  ), // title: Register
                  SizedBox(
                    height: 12.0,
                  ),
                  ismobilevalidated
                      ? Column(
                          children: [
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: Text(
                                  "OTP has been sent to $customernumber",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            TextFieldPin(
                              filled: true,
                              filledColor: Colors.grey[100],
                              codeLength: 4,
                              boxSize: 40,
                              onOtpCallback: (code, isAutofill) =>
                                  _onOtpCallBack(code, isAutofill),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: _start != 0
                                  ? Text('Resend OTP in $_start sec')
                                  : Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  Text("Didn't Received OTP ? "),
                                  GestureDetector(
                                      onTap: () {
                                        //_onSubmitOtp();
                                        SendOtp();
                                        _start = 60;
                                        // setState(() {
                                        //   startTimer();
                                        //   startTimer();
                                        // });
                                      },
                                      child: Text(
                                        "Request OTP",
                                        style:
                                        getSmallTextNavigationStyle(
                                            context),
                                      ))
                                ],
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: <Widget>[
                            TextFormField(
                              controller: _textEditConFirstName,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              textCapitalization: TextCapitalization.sentences,
                              validator: (value) => validateEmptyCheck(
                                  value, 'Company name' + " is required"),
                              style: getFormStyleText(context),
                              onFieldSubmitted: (String value) {
                                FocusScope.of(context)
                                    .requestFocus(_fNodeLastName);
                              },
                              decoration: InputDecoration(
                                isDense: true,
                                labelText: 'Company name',
                                labelStyle: getFormLabelStyleText(context),
                                contentPadding: EdgeInsets.only(left: 0),
                                prefixIcon: buildCustomPrefixIcon(
                                    AppCustomIcon.icon_user),
                              ),
                            ), //text field : user name
                            SizedBox(
                              height: 12.0,
                            ),
                            TextFormField(
                              controller: _textEditConLastName,
                              focusNode: _fNodeLastName,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              textCapitalization: TextCapitalization.sentences,
                              validator: (value) => validateEmptyCheck(
                                  value, "Location is required"),
                              style: getFormStyleText(context),
                              onFieldSubmitted: (String value) {
                                FocusScope.of(context)
                                    .requestFocus(_fNodeEmail);
                              },
                              decoration: InputDecoration(
                                isDense: true,
                                labelText: 'Location',
                                labelStyle: getFormLabelStyleText(context),
                                contentPadding: EdgeInsets.only(left: 0),
                                prefixIcon: buildCustomPrefixIcon(
                                    AppCustomIcon.icon_user),
                              ),
                            ),
                            SizedBox(
                              height: 12.0,
                            ),
                            TextFormField(
                              controller: _textEditConEmail,
                              focusNode: _fNodeEmail,
                              style: getFormStyleText(context),
                              keyboardType: TextInputType.emailAddress,
                              textCapitalization: TextCapitalization.sentences,
                              textInputAction: TextInputAction.next,
                              validator: _validateEmail,
                              onFieldSubmitted: (String value) {
                                FocusScope.of(context).requestFocus(_fNodeTRN);
                              },
                              decoration: InputDecoration(
                                  isDense: true,
                                  labelText: 'Email',
                                  labelStyle: getFormLabelStyleText(context),
                                  contentPadding: EdgeInsets.only(left: 0),
                                  prefixIcon: buildCustomPrefixIcon(
                                      AppCustomIcon.icon_mail)),
                            ), //text field: email
                            SizedBox(
                              height: 12.0,
                            ),

                            TextFormField(
                              controller: _textEditConmobile,
                              focusNode: _fNodemobile,
                              style: getFormStyleText(context),
                              keyboardType: TextInputType.number,
                              textCapitalization: TextCapitalization.sentences,
                              textInputAction: TextInputAction.next,
                              validator: _validatemobile,
                              onFieldSubmitted: (String value) {
                                FocusScope.of(context).requestFocus(_fNodeTRN);
                              },
                              decoration: InputDecoration(
                                isDense: true,
                                labelText: 'Mobile Number',
                                labelStyle: getFormLabelStyleText(context),
                                contentPadding: EdgeInsets.only(left: 0),
                                prefixIcon:
                                    buildCustomPrefixIcon(Icons.phone_android),
                              ),
                            ), //text field: email
                            SizedBox(
                              height: 12.0,
                            ),
                            TextFormField(
                              controller: _textEditTRN,
                              focusNode: _fNodeTRN,
                              style: getFormStyleText(context),
                              keyboardType: TextInputType.number,
                              //inputFormatters: [BlacklistingTextInputFormatter(new RegExp('[\\-|\\ |\.|\,]'))],
                              inputFormatters: [
                                WhitelistingTextInputFormatter(RegExp("[0-9]"))
                              ],
                              maxLength: 15,
                              textInputAction: TextInputAction.next,
                              validator: _validateTRN,
                              onFieldSubmitted: (String value) {
                                FocusScope.of(context)
                                    .requestFocus(_fNodePassword);
                              },
                              decoration: InputDecoration(
                                  isDense: true,
                                  labelText: 'TRN',
                                  labelStyle: getFormLabelStyleText(context),
                                  contentPadding: EdgeInsets.only(left: 0),
                                  prefixIcon:
                                      buildCustomPrefixIcon(Icons.code)),
                            ), //text field: email
                            SizedBox(
                              height: 12.0,
                            ),
                            TextFormField(
                              controller: _textEditConPassword,
                              focusNode: _fNodePassword,
                              keyboardType: TextInputType.text,
                              style: getFormStyleText(context),
                              textInputAction: TextInputAction.next,
                              validator: _validatePassword,
                              onFieldSubmitted: (String value) {
                                FocusScope.of(context)
                                    .requestFocus(_fNodeConfirmPassword);
                              },
                              obscureText: !isPasswordVisible,
                              decoration: InputDecoration(
                                  labelText: 'Password',
                                  errorMaxLines: 10,
                                  isDense: true,
                                  labelStyle: getFormLabelStyleText(context),
                                  suffixIcon: IconButton(
                                    icon: Icon(isPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                    onPressed: () {
                                      setState(() {
                                        isPasswordVisible = !isPasswordVisible;
                                      });
                                    },
                                  ),
                                  contentPadding: EdgeInsets.only(left: 0),
                                  prefixIcon: buildCustomPrefixIcon(
                                      AppCustomIcon.icon_pwd_key)),
                            ), //text field: password
                            SizedBox(
                              height: 12.0,
                            ),
                            TextFormField(
                                controller: _textEditConConfirmPassword,
                                focusNode: _fNodeConfirmPassword,
                                keyboardType: TextInputType.text,
                                style: getFormStyleText(context),
                                textInputAction: TextInputAction.done,
                                validator: _validateConfirmPassword,
                                obscureText: !isConfirmPasswordVisible,
                                decoration: InputDecoration(
                                    labelStyle: getFormLabelStyleText(context),
                                    labelText: 'Confirm Password',
                                    errorMaxLines: 10,
                                    isDense: true,
                                    suffixIcon: IconButton(
                                      icon: Icon(isConfirmPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                      onPressed: () {
                                        setState(() {
                                          isConfirmPasswordVisible =
                                              !isConfirmPasswordVisible;
                                        });
                                      },
                                    ),
                                    contentPadding: EdgeInsets.only(left: 0),
                                    prefixIcon: buildCustomPrefixIcon(
                                        AppCustomIcon.icon_pwd_key))),
                          ],
                        ),
                  Container(
                    margin: EdgeInsets.only(top: 32.0),
                    width: double.infinity,
                    child: RaisedButton(
                      color: colorAccent,
                      textColor: Colors.white,
                      elevation: 5.0,
                      padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                      child: Text(
                        'Register',
                        style: getStyleButtonText(context),
                      ),
                      onPressed: () async{
                        if(_keyValidationForm.currentState.validate()){
                        if (ismobilevalidated == false) {
                          otpforregistartion = true;
                          customernumber = int.parse(_textEditConmobile.text);
                          SendOtp();
                          setState(() {
                            ismobilevalidated = true;
                          });
                          startTimer();
                          register.email = _textEditConEmail.text;
                          register.firstname = _textEditConFirstName.text;
                          register.lastname = _textEditConLastName.text;
                          register.password = _textEditConPassword.text;
                          register.trn = _textEditTRN.text;
                       // _onClickButtonRegister(context, registerNotifier);
                        }else{
                          setState(() {
                            isApiCallProcess = true;
                          });
                          _onSubmitOtp();
                          int registered = await registereduser();
                          if(registered == 0){
                            ismobilevalidated = false;
                            otpforregistartion= false;
                            setState(() {
                              isApiCallProcess = false;
                            });
                            _onTappedTextLogin();
                            Flushbar(
                              message:"User Registered Please Login",
                              duration:  Duration(seconds: 3),
                              backgroundColor:colorAccent,
                            )..show(context);
                          }else{
                            setState(() {
                              isApiCallProcess = false;
                            });
                            Flushbar(
                              message:"Invaild OTP or Number already registered",
                              duration:  Duration(seconds: 3),
                              backgroundColor:colorAccent,
                            )..show(context);
                          }
                        }
                        }
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0)),
                    ),
                  ), //button: login
                  Container(
                      margin: EdgeInsets.only(top: 16.0, bottom: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Already Registered?  ',
                            style: getFormNormalTextStyle(context),
                          ),
                          InkWell(
                            splashColor: colorAccent.withOpacity(0.5),
                            onTap: () {
                              _onTappedTextLogin();
                            },
                            child: Text(
                              '  Login',
                              style: getSmallTextNavigationStyle(context),
                            ),
                          )
                        ],
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _validateUserName(String value) {
    return value.trim().isEmpty ? "Field can't be empty" : null;
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

  String _validatemobile(String value) {
    if (value.toString().length == 0) {
      return 'Mobile number is required';
    } else if (value.toString().length < 9) {
      return 'Invalid Mobile number';
    } else {
      return null;
    }
  }

  String _validateTRN(String value) {
    if (value.length == 0) {
      return 'TRN is required';
    } else if (value.length < 15) {
      return 'Invalid TRN';
    } else {
      return null;
    }
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
    widget.log.i('password: ${_textEditConPassword.text}');
    widget.log.i('password confirm: $value');
    if (value.length == 0) {
      return 'Confirm password is required';
    } else if (value.length < 8) {
      return 'Min 8 char required';
    } else if (value != _textEditConPassword.text) {
      return 'Password is Mismatched';
    } else {
      return null;
    }
  }

  void _onClickButtonRegister(
      BuildContext context, RegisterNotifier registerNotifier) async {
    RegisterResponse response = await registerNotifier.apiRegisterUser(
        _textEditConFirstName.text,
        _textEditConLastName.text,
        _textEditConEmail.text,
        _textEditConPassword.text,
        _textEditTRN.text);
    if (response.message != null) {
      //bad request so show snack bar error message
      final snackBar = SnackBar(content: Text('${response.message}'));
      // Find the Scaffold in the widget tree and use it to show a SnackBar.
      _scaffoldKey.currentState.showSnackBar(snackBar);
    } else {
      //show success dialogue & navigate to login page
      _showDialogueSuccessRegistration(context);
    }
  }

  void _onTappedTextLogin() {
    Navigator.pop(context);
  }

  void _showDialogueSuccessRegistration(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Successfully Registered !',
              style: getAppBarTitleTextStyle(context).copyWith(
                  color: colorBlack, fontWeight: AppFont.fontWeightSemiBold),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(AppConstants.OK,
                    style: getStyleSubHeading(context).copyWith(
                        color: colorPrimary,
                        fontWeight: AppFont.fontWeightSemiBold)),
                onPressed: () {
                  _saveUserCred();
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context); //for dialogue
                  }
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context); //for register screen
                  }
                },
              )
            ],
          );
        });
  }

  void _saveUserCred() async {
    AppSharedPreference().saveStringValue(
        AppConstants.KEY_USER_EMAIL_ID, _textEditConEmail.text);
    AppSharedPreference().saveStringValue(
        AppConstants.KEY_USER_PASSWORD, _textEditConPassword.text);
  }
}
