import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:thought_factory/core/data/local/app_shared_preference.dart';
import 'package:thought_factory/core/data/remote/request_response/login/login_response.dart';
import 'package:thought_factory/core/data/remote/request_response/user/user_detail_response.dart';
import 'package:thought_factory/core/notifier/common_notifier.dart';
import 'package:thought_factory/core/notifier/login_notifier.dart';
import 'package:thought_factory/ui/password/forgot_pwd_screen.dart';
import 'package:thought_factory/ui/register_screen.dart';
import 'package:thought_factory/utils/app_colors.dart';
import 'package:thought_factory/utils/app_constants.dart';
import 'package:thought_factory/utils/app_custom_icon.dart';
import 'package:thought_factory/utils/app_font.dart';
import 'package:thought_factory/utils/app_images.dart';
import 'package:thought_factory/utils/app_log_helper.dart';
import 'package:thought_factory/utils/app_text_style.dart';
import 'package:thought_factory/utils/app_validators.dart';
import 'package:thought_factory/utils/widgetHelper/custom_prefix_icon.dart';
import 'package:flushbar/flushbar.dart';
import 'main/main_screen.dart';
import 'package:thought_factory/otpverification.dart';
import 'package:custom_timer/custom_timer.dart';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';
import 'dart:async';
bool otpsent= false;
bool isotplogin = false;
int _otpCodeLength = 4;
bool _isLoadingButton = false;
bool _enableButton = false;
class LoginScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final log = getLogger('LoginScreen');
  TextEditingController _textEditConEmail =
      TextEditingController(); //raghunath@colanonline.com
  TextEditingController _textEditConPassword =
      TextEditingController(); //Pass@123
  var _keyValidationForm = GlobalKey<FormState>();
  final FocusNode _passwordFocus = FocusNode();
  bool _isPasswordVisible = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _canShowLoginCard = false;

  @override
  void initState() {
    super.initState();
    _getSignatureCode();
    otpsent = false;
    Future.delayed(Duration.zero, () {
      LoginNotifier loginNotifier =
          Provider.of<LoginNotifier>(context, listen: false);
      loginNotifier.context = context;
      checkAlreadyUserLoggedIn(context, loginNotifier);
    });
  }
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
  _verifyOtpCode() async{
    otpenter = _otpCode;
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: colorGrey,
        body: Consumer<LoginNotifier>(
          builder: (context, loginNotifier, _) => ModalProgressHUD(
            inAsyncCall: loginNotifier.isLoading,
            child: SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.only(bottom: 32.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      _buildWidgetImageLogo(),
                      _buildWidgetLoginCard(loginNotifier, context),
                    ],
                  )),
            ),
          ),
        ));
  }

  /////////////////////
  /*  build helpers */
  ////////////////////
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

  Widget _buildWidgetLoginCard(
      LoginNotifier loginNotifier, BuildContext context) {
    return Container(
      /*decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: colorGrey, spreadRadius: 10.0, offset: new Offset(0, 0), blurRadius: 10.0)]),*/
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
                top: 24.0, bottom: 8.0, left: 24.0, right: 24.0),
            child: Form(
              key: _keyValidationForm,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    child: Text(
                      AppConstants.LOGIN,
                      style: getFormTitleStyle(context),
                    ),
                  ),
                  otpsent ?Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top:10.0,bottom: 10.0),
                      child: Text("OTP has been sent to this Mobile $customernumber",textAlign: TextAlign.center,),
                    ),
                  ):Container(
                    margin: EdgeInsets.only(top: 16),
                    child: TextFormField(
                      controller: _textEditConEmail,
                      keyboardType: TextInputType.emailAddress,
                      textCapitalization: TextCapitalization.sentences,
                      textInputAction: TextInputAction.next,
                      validator: _validateEmail,
                      onChanged: (str){
                        setState(() {
                          if(str == null) {
                            isotplogin = false;
                          }
                          isotplogin = double.tryParse(str) != null;
                        });
                      },
                      style: getFormStyleText(context),
                      onFieldSubmitted: (String value) {
                        FocusScope.of(context).requestFocus(_passwordFocus);
                      },
                      decoration: InputDecoration(
                          isDense: true,
                          labelText: AppConstants.EMAIL,
                          contentPadding: EdgeInsets.only(top: 4.0),
                          labelStyle: getFormLabelStyleText(context),
                          prefixIcon:
                              buildCustomPrefixIcon(AppCustomIcon.icon_mail)),
                    ),
                  ), //text field: email
                  otpsent ?
                  TextFieldPin(
                    filled: true,
                    filledColor: Colors.grey[100],
                    codeLength: _otpCodeLength,
                    boxSize: 40,
                    onOtpCallback: (code, isAutofill) => _onOtpCallBack(code, isAutofill),

                  )
                  // PinEntryTextField(
                  //   onSubmit: (String pin) async {
                  //     otpenter = pin;
                  //     bool verified = await IsOtpVerified();
                  //     if(verified){
                  //
                  //     }
                  //     showDialog(
                  //         context: context,
                  //         builder: (context){
                  //           return AlertDialog(
                  //             title: Text("Pin"),
                  //             content: verified ? Text('verified token received') : Text("incorrect otp"),
                  //           );
                  //         }
                  //     ); //end showDialog()
                  //
                  //   }, // end onSubmit
                  // )
                      :Container(
                    margin: EdgeInsets.only(top: 16),
                    child: TextFormField(
                      controller: _textEditConPassword,
                      focusNode: _passwordFocus,
                      obscureText: !_isPasswordVisible,
                      keyboardType: TextInputType.text,
                      validator: _validatePassword,
                      style: getFormStyleText(context),
                      decoration: InputDecoration(
                        isDense: true,
                        //to reduce the size of icon, use if you want. I used, because my custom font icon is big
                        labelText: AppConstants.PASSWORD,
                        contentPadding: EdgeInsets.only(top: 4.0),
                        //to make the base line of icon & text in same
                        labelStyle: getFormLabelStyleText(context),
                        prefixIcon:
                            buildCustomPrefixIcon(AppCustomIcon.icon_pwd_key),
                        suffixIcon: IconButton(
                          icon: Icon(_isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                  ), //text field: password
                  otpsent ?Padding(
                    padding: const EdgeInsets.only(top:20.0),
                    child: _start != 0 ? Text('Request OTP in $_start sec'):
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: (){
                              //_onSubmitOtp();
                              SendOtp();
                              _start = 60;
                              setState(() {
                                startTimer();
                                startTimer();
                              });
                            },
                            child: Text("Request OTP",style:getSmallTextNavigationStyle(context),))
                      ],
                    ),
                  ):Container(
                      margin: EdgeInsets.only(top: 16.0),
                      alignment: Alignment(1.0, 0.0),
                      child: InkWell(
                        splashColor: colorAccent.withOpacity(0.5),
                        onTap: () {
                          _onClickTextForgotPassword();
                        },
                        child: Text(
                          'Forgot Password?',
                          style: getStyleCaption(context).copyWith(
                              color: colorBlack,
                              fontWeight: AppFont.fontWeightSemiBold),
                        ),
                      )), //text: forgot password

                  Container(
                    margin: EdgeInsets.only(top: 20.0),
                    width: double.infinity,
                    child: RaisedButton(
                      color: colorAccent,
                      textColor: Colors.white,
                      elevation: 5.0,
                      padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                      child: Text(
                        otpsent?"Login":isotplogin ? "Request OTP" : "Login",
                        style: getStyleButtonText(context),
                      ),
                      onPressed: () async {
                        if(otpsent){
                          await _onSubmitOtp();
                          otpenter = _otpCode;
                          bool verified = await IsOtpVerified();
                           if(verified){
                             print(verified);
                            FocusScope.of(context).requestFocus(FocusNode());
                            if (_keyValidationForm.currentState.validate()) {
                              _onClickButtonLogIn(loginNotifier);
                            }
                           }else{
                             _onClickButtonLogIn(loginNotifier);
                             Flushbar(
                               message:"OTP mismatch or User doesn't Exists",
                               duration:  Duration(seconds: 3),
                               backgroundColor:colorAccent,
                             )..show(context);
                           }
                        }else{
                          if(_textEditConPassword.text.isEmpty){
                            if(checkforotp() && _textEditConEmail.text.length ==9){
                              setState(() {
                                otpsent = true;
                              });
                              print("loginscreen navigate");
                            }else{
                              Flushbar(
                                message:"Enter a Valid Mobile Number for OTP Login",
                                duration:  Duration(seconds: 3),
                                backgroundColor:colorAccent,
                              )..show(context);
                            }
                          }else{
                            FocusScope.of(context).requestFocus(FocusNode());
                            if (_keyValidationForm.currentState.validate()) {
                              _onClickButtonLogIn(loginNotifier);
                            }
                          }
                        }

//                        Navigator.pop(context);
//                        Navigator.pushNamed(context, MainScreen.routeName);

                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0)),
                    ),
                  ),
                  //button: login
                  Container(
                      margin: EdgeInsets.only(top: 24.0, bottom: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'New to EBazzar.ae ',
                            style: getFormNormalTextStyle(context),
                          ),
                          InkWell(
                            splashColor: colorAccent.withOpacity(0.5),
                            onTap: () {
                              setState(() {
                                ismobilevalidated = false;
                                otpforregistartion = false;
                              });
                              _onClickTextRegister(context, loginNotifier);
                            },
                            child: Text(
                              ' Register',
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

  /////////////////////
  /*On click-actions*/
  ////////////////////
  LoginResponse loginResponse;
  void _onClickButtonLogIn(LoginNotifier loginNotifier) async {
    log.i('Action Tap: LogIn button');
    //Api: 1st
      loginResponse = await loginNotifier.callApiLoginUser(
          _textEditConEmail.text, _textEditConPassword.text);
    String tokenLogin = loginResponse.token; //--> need to check token is expired
    if (tokenLogin != null && tokenLogin.trim().length > 0) {
      //Api: 2nd, 1st API success case now calling second
      UserDetailResponse userDetailResponse =
          await loginNotifier.callApiGetUserDetailByToken(tokenLogin);
      if (userDetailResponse.message == null &&
          userDetailResponse.groupId != null) {
        if (userDetailResponse.groupId == AppConstants.GROUP_ID_SHOP_OWNER) {
          log.i('Login scuccess with token : ${tokenLogin}');
          //save user detail in common model
          CommonNotifier().userDetail = userDetailResponse; // update this value
          //save user token to shared preference
          loginNotifier.saveUserToken(tokenLogin); //--> need to check token
          //update token to app model
          Provider.of<CommonNotifier>(context, listen: false).userToken =
              tokenLogin; // --> need todo
          //Api: 3rd getting cart quote id
          loginNotifier.isLoading = true;
          await Provider.of<CommonNotifier>(context, listen: false)
              .callApiGetCartQuoteIdResponse(tokenLogin);
          //Api: 4th get country list data
          await CommonNotifier().callApiGetCountriesList();
          loginNotifier.isLoading = false;
          //Saving User Credential
          loginNotifier.saveUserCredential(
              true, _textEditConEmail.text, _textEditConPassword.text);
          //close current login screen
          //Navigator.pop(context);
          //Navigator.pushNamed(context, MainScreen.routeName);
          Navigator.pushNamedAndRemoveUntil(
              context, MainScreen.routeName, (e) => false);
        } else {
          //failure case:  group Id mismatched
          _showSnackBarMessage(
              'Invalid user login! this user not belongs to this group ID');
        }
      } else {
        //failure case: of get user detail by token api
        _showSnackBarMessage(userDetailResponse.message);
      }
    } else {
      //failure case: of login api
      _showSnackBarMessage(loginResponse.message);
    }
  }

  void _onClickTextRegister(BuildContext context, LoginNotifier loginNotifier) {
    log.i('Action Tap: Register');
    //navigate to register screen
    Navigator.of(context).pushNamed(RegisterScreen.routeName).whenComplete(() {
      checkAlreadyUserLoggedIn(context, loginNotifier);
    });
    //or normal old school way
//    Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
  }

  void _onClickTextForgotPassword() {
    log.i('Action Tap: ForgotPassword');
    Navigator.pushNamed(context, ForgotPasswordScreen.routeName).then((val) =>
        val == true
            ? _showSnackBarMessage(
                'The link has been sent to your registered email id.')
            : null);
  }

  String _validatePassword(String value) {
    return value.trim().length == 0 ? 'Password is required' : null;
  }

  String _validateEmail(String value) {
    return value.trim().length == 0
        ? 'Email/Mobile is not vaild'
        : validateEmail(value);
  }

  //show: snackBar toast
  void _showSnackBarMessage(String message) {
    final snackBar = SnackBar(content: Text(message ?? ""));
    // Find the Scaffold in the widget tree and use it to show a SnackBar.
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  Future checkAlreadyUserLoggedIn(
      BuildContext context, LoginNotifier loginNotifier) async {
    try {
      String emailId = await AppSharedPreference()
          .getStringValue(AppConstants.KEY_USER_EMAIL_ID);
      String pwd = await AppSharedPreference()
          .getStringValue(AppConstants.KEY_USER_PASSWORD);

      if (emailId != null && emailId != "" && pwd != null && pwd != "") {
        setState(() {
          _canShowLoginCard = false;
        });
        _textEditConEmail.text = emailId;
        _textEditConPassword.text = pwd;
        _onClickButtonLogIn(loginNotifier);
      } else {
        setState(() {
          _canShowLoginCard = true;
        });
      }
    } catch (e) {
      log.e("Error :" + e.toString());
    }
  }
  bool checkforotp() {
      try{
        int.parse(_textEditConEmail.text);
        customernumber = int.parse(_textEditConEmail.text);
        SendOtp();
        startTimer();
        return true;
      }catch(error){
        print(error);
        return false;
      }
    }
  void startTimer() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    } else {
      _timer = new Timer.periodic(
        const Duration(seconds: 1),
            (Timer timer) =>
            setState(
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

}
Timer _timer;
int _start = 30;




