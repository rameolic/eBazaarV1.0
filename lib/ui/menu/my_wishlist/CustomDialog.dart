import 'package:flutter/material.dart';
import 'package:thought_factory/core/data/remote/request_response/wishlist/ShareWishListRequest.dart';
import 'package:thought_factory/core/notifier/wish_list_notifier.dart';
import 'package:thought_factory/utils/app_colors.dart';
import 'package:thought_factory/utils/app_constants.dart';
import 'package:thought_factory/utils/app_font.dart';
import 'package:thought_factory/utils/app_text_style.dart';
import 'package:thought_factory/utils/app_validators.dart';
import 'package:thought_factory/utils/widgetHelper/build_small_caption.dart';

class CustomDialog extends StatefulWidget {
  final WishListNotifier wishListNotifier;
  final String customerId;

  CustomDialog({
    @required this.wishListNotifier,
    @required this.customerId
  });

  @override
  _CustomDialogState createState() => _CustomDialogState(wishListNotifier, customerId);
}

class _CustomDialogState extends State<CustomDialog> {
  var fieldFontWeight = AppFont.fontWeightSemiBold;

  WishListNotifier wishListNotifier;

  var firstNameController = TextEditingController(text: '');

  var streetAddressController = TextEditingController();

  var _keyValidationFormEditProfile = GlobalKey<FormState>();

  var emailController = TextEditingController();

  final FocusNode _focusNodeEmail = FocusNode();

  final FocusNode _focusNodePhone = FocusNode();

  String customerId = "";

  final FocusNode _focusNodeStreetAddress = FocusNode();

  _CustomDialogState(WishListNotifier wishListNotifier, String customerId)  {
    this.wishListNotifier = wishListNotifier;
    this.customerId = customerId;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 0.0,
      backgroundColor: colorVeryLightGrey,
      child: dialogContent(context, wishListNotifier, customerId),
    );
  }

  dialogContent(BuildContext context, WishListNotifier wishListNotifier, String customerId) {
    var _textFieldStyle = getStyleSubHeading(context).copyWith(fontWeight: fieldFontWeight);
    return Container(
     // color: Colors.black12,
      child: Form(
        key: _keyValidationFormEditProfile,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top:8.0),
                child: Center(
                  child: Text(
                    'Send Email',
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:8.0, top: 4.0),
                child:
                  buildSmallCaption("Email Address ", context),
              ),
              Container(
                margin: EdgeInsets.only(top: 4.0, bottom: 16.0, left: 10, right: 10),
                child: TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    controller: emailController,
                    maxLines: 1,
                    focusNode: _focusNodeEmail,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    style: _textFieldStyle,
                    onFieldSubmitted: (String value) {
                      FocusScope.of(context).requestFocus(_focusNodePhone);
                    },
                    validator: (value) => _validateEmail(value),
                    decoration: _buildTextDecoration(50.0)),
              ),
              Padding(
                padding: const EdgeInsets.only(left:8.0),
                child: buildSmallCaption("Street Address ", context),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0, bottom: 16.0, left: 10, right: 10),
                child: TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    controller: streetAddressController,
                    maxLines: 3,
                    focusNode: _focusNodeStreetAddress,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    style: _textFieldStyle,
                    onFieldSubmitted: (String value) {
                      FocusScope.of(context).requestFocus(_focusNodeEmail);
                    },
                    validator: (value) => validateEmptyCheck(value, AppConstants.STREET_ADDRESS + " Can't be empty"),
                    decoration: _buildTextDecoration(30.0)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _sendContainer(context, wishListNotifier, customerId),
                  _cancelContainer(context),
                ],
              ),
              SizedBox(
                height: 10.0,
              )
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _buildTextDecoration(double radiusValue) {
    return InputDecoration(
        isDense: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radiusValue),
            borderSide: BorderSide(width: 0, style: BorderStyle.none)),
        filled: true,
        fillColor: colorWhite,
        contentPadding: EdgeInsets.all(16));
  }

  String _validateEmail(String value) {
    return value.trim().length == 0 ? 'Email is required' : validateEmail(value);
  }

  Row buildCaptionWithoutStar(String caption, BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          caption,
          style: getStyleCaption(context).copyWith(color: Colors.black87),
        ),
        Text(
          "",
          style: getStyleCaption(context).copyWith(color: colorPrimary),
        )
      ],
    );
  }

  Widget _sendContainer(BuildContext context, WishListNotifier wishListNotifier, String customerId) {
    return Container(
      child: RaisedButton(
        color: colorAccent,
        textColor: Colors.white,
        elevation: 5.0,
        padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
        child: Text(
          'Send',
          style: getStyleButtonText(context),
        ),
        onPressed: ()  {
          if (_keyValidationFormEditProfile.currentState.validate()) {
            print("Success $customerId");
            wishListNotifier.callApiShareWishList(
              ShareWishListRequest(
                message: streetAddressController.text,
                emails: emailController.text,
                customerId: customerId
              ),context
            );
          } else {
            print("Failure");
          }
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      ),
    );
  }

  Widget _cancelContainer(BuildContext context) {
    return Container(

      child: RaisedButton(
        color: Colors.grey,
        textColor: Colors.white,
        elevation: 5.0,
        padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
        child: Text(
          'Cancel',
          style: getStyleButtonText(context),
        ),
        onPressed: () {
          Navigator.pop(context);
         },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      ),
    );
  }

  ShareWishListRequest buildRequest()  {
    return ShareWishListRequest(
      message: streetAddressController.text,
      emails: emailController.text,
      customerId: customerId
    );
  }
}