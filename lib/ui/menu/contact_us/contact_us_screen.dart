import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:thought_factory/core/data/local/app_shared_preference.dart';
import 'package:thought_factory/core/data/remote/request_response/contact_us/ContactUsFormRequest.dart';
import 'package:thought_factory/core/data/remote/request_response/contact_us/ContactUsFormResponse.dart';
import 'package:thought_factory/core/notifier/contactus_notifier.dart';
import 'package:thought_factory/state/state_drawer.dart';
import 'package:thought_factory/utils/app_colors.dart';
import 'package:thought_factory/utils/app_constants.dart';
import 'package:thought_factory/utils/app_custom_icon.dart';
import 'package:thought_factory/utils/app_font.dart';
import 'package:thought_factory/utils/app_text_style.dart';
import 'package:thought_factory/utils/app_validators.dart';
import 'package:thought_factory/utils/widgetHelper/build_small_caption.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class ContactUsScreen extends StatefulWidget {
  StateDrawer stateDrawer;

  ContactUsScreen(this.stateDrawer);

  @override
  ContactUsScreenState createState() => ContactUsScreenState(stateDrawer);
}

class ContactUsScreenState extends State<ContactUsScreen> {
  double paddingRight = 5.0;
  double paddingLeft = 5.0;
  double paddingTop = 3.0;
  double paddingBottom = 3.0;

  double marginLeft = 0.0;
  double marginRight = 0.0;

  double paddingTextFieldLeft = 12.0;
  double paddingTextFieldRight = 12.0;
  double radiusValue = 50.0;
  static final _formKey = new GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _textFullName = TextEditingController();
  TextEditingController _textEmail = TextEditingController();
  TextEditingController _textMobileNumber = TextEditingController();
  TextEditingController _textSubject = TextEditingController();
  TextEditingController _textMessage = TextEditingController();
  StateDrawer stateDrawer;

  ContactUsScreenState(this.stateDrawer);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    settingDate();
  }

  settingDate() async {
    _textFullName.text = await AppSharedPreference()
        .getPreferenceData(AppConstants.KEY_CUSTOMER_NAME);
    _textEmail.text = await AppSharedPreference()
        .getPreferenceData(AppConstants.KEY_CUSTOMER_MAILID);
    _textMobileNumber.text = await AppSharedPreference()
        .getPreferenceData(AppConstants.KEY_MOBILE_NUMBER);
  }

  @override
  Widget build(BuildContext context) {
    TextStyle formFontStyle = getStyleSubHeading(context)
        .copyWith(color: Colors.black, fontWeight: AppFont.fontWeightSemiBold);

    return Scaffold(
      key: _scaffoldKey,
      body: ChangeNotifierProvider<ContactUsNotifier>(
        create: (context) => ContactUsNotifier(context),
        child: Consumer<ContactUsNotifier>(
          builder: (context, contactNotifier, _) => ModalProgressHUD(
            inAsyncCall: contactNotifier.isLoading,
            child: SingleChildScrollView(
              child: Container(
                color: colorGrey,
                padding: EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      buildSmallCaption("Full Name", context),
                      Container(
                        margin: EdgeInsets.only(
                            top: 7.0,
                            bottom: 16.0,
                            left: marginLeft,
                            right: marginRight),
                        alignment: Alignment.center,
                        child: TextFormField(
                          //key: _fullNameKey,
                          style: formFontStyle,
                          controller: _textFullName,
                          enabled: false,
                          validator: _validateName,
                          decoration: _buildTextDecoration(),
                        ),
                        //  decoration: BoxDecoration(color: colorWhite, borderRadius: BorderRadius.all(Radius.circular(50.0))),
                      ),

                      buildSmallCaption("Email ", context),
                      Container(
                        margin: EdgeInsets.only(
                            top: 7.0,
                            bottom: 16.0,
                            left: marginLeft,
                            right: marginRight),
                        alignment: Alignment.center,
                        child: TextFormField(
                          //key: _emailKey,
                          enabled: false,
                          textCapitalization: TextCapitalization.sentences,
                          controller: _textEmail,
                          validator: _validateEmail,

                          //  initialValue: 'stevesmith0125@gmail.com',
                          keyboardType: TextInputType.emailAddress,
                          style: formFontStyle,
                          decoration: _buildTextDecoration(),
                        ),
                        //   decoration: BoxDecoration(color: colorWhite, borderRadius: BorderRadius.all(Radius.circular(50.0))),
                      ),

                      buildSmallCaption("Mobile Number ", context),
                      Container(
                        margin: EdgeInsets.only(
                            top: 7.0,
                            bottom: 16.0,
                            left: marginLeft,
                            right: marginRight),
                        alignment: Alignment.center,
                        child: TextFormField(
                          controller: _textMobileNumber,
                          keyboardType: TextInputType.phone,
                          validator: _validateMobileNumber,
                          textCapitalization: TextCapitalization.sentences,
                          style: formFontStyle,
                          decoration: _buildTextDecoration(),
                        ),
                        // decoration: BoxDecoration(color: colorWhite, borderRadius: BorderRadius.all(Radius.circular(50.0))),
                      ),

                      buildSmallCaption("Subject ", context),
                      Container(
                        margin: EdgeInsets.only(
                            top: 7.0,
                            bottom: 16.0,
                            left: marginLeft,
                            right: marginRight),
                        alignment: Alignment.center,
                        child: TextFormField(
                          //initialValue: 'Lorem ipusm',
                          controller: _textSubject,
                          validator: _validateSubject,
                          textCapitalization: TextCapitalization.sentences,
                          style: formFontStyle,
                          decoration: _buildTextDecoration(),
                        ),
                        //  decoration: BoxDecoration(color: colorWhite, borderRadius: BorderRadius.all(Radius.circular(50.0))),
                      ),

                      buildSmallCaption("Message ", context),
                      Container(
                        margin: EdgeInsets.only(top: 7.0, bottom: 16.0),
                        alignment: Alignment.center,
                        child: TextFormField(
                          keyboardType: TextInputType.multiline,
                          maxLines: 6,
                          controller: _textMessage,
                          validator: _validateMessage,
                          cursorColor: colorPrimary,
                          style: formFontStyle,
                          decoration: InputDecoration(
                              isDense: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                      width: 0, style: BorderStyle.none)),
                              filled: true,
                              fillColor: colorWhite,
                              contentPadding: EdgeInsets.all(16)),
                        ),
                        // decoration: BoxDecoration(color: colorWhite, borderRadius: BorderRadius.all(Radius.circular(20.0))),
                      ),

//          _title(context, "Full Name"),
//          _heightSpace(),
//          _TextField(context, "", 1),

                      _heightSpace(),
                      _buildButtonSend(contactNotifier),
                      _heightSpace(),
                      _buildReactUs(contactNotifier),
                      SizedBox(
                        height: 10.0,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButtonSend(ContactUsNotifier contactNotifier) {
    return Container(
      height: 80,
      color: Colors.transparent,
      padding: EdgeInsets.only(top: 5.0),
      alignment: Alignment.topCenter,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: RaisedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _onClickSubmitContactUs(contactNotifier).whenComplete(() {
                    stateDrawer.selectedDrawerItem =
                        AppConstants.DRAWER_ITEM_HOME;
                    stateDrawer.selectedId = AppConstants.DRAWER_ITEM_HOME;
                    //stateDrawer.isItemExpanded = false;
                  });
                }
              },
              child: Text(
                AppConstants.SEND,
                style:
                    getStyleButtonText(context).copyWith(color: Colors.white),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0))),
              color: colorPrimary,
              padding: EdgeInsets.symmetric(vertical: 16.0),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildReactUs(ContactUsNotifier contactNotifier) {
    return (contactNotifier.addressResponse != null &&
            contactNotifier.addressResponse.wishlist != null)
        ? Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  "Reach Us",
                  style: getStyleHeading(context).copyWith(
                      fontSize: 17.0,
                      color: Colors.black,
                      fontWeight: AppFont.fontWeightSemiBold),
                ),
                if (contactNotifier.addressResponse.wishlist.data.streetLine1 != null ||
                    contactNotifier.addressResponse.wishlist.data.streetLine2 !=
                        null ||
                    contactNotifier.addressResponse.wishlist.data.city !=
                        null ||
                    contactNotifier.addressResponse.wishlist.data.countryName !=
                        null ||
                    contactNotifier.addressResponse.wishlist.data.postcode !=
                        null)
                  _buildReachUsContent(
                      context,
                      Icon(AppCustomIcon.icon_location,
                          size: 18,
                          semanticLabel: " dvsdf",
                          color: colorPrimary),
                      contactNotifier
                                  .addressResponse.wishlist.data.streetLine1 !=
                              null
                          ? contactNotifier
                              .addressResponse.wishlist.data.streetLine1
                          : " " +
                                      "," +
                                      contactNotifier.addressResponse.wishlist
                                          .data.streetLine2 !=
                                  null
                              ? contactNotifier
                                  .addressResponse.wishlist.data.streetLine2
                              : " " +
                                          "," +
                                          "\n" +
                                          contactNotifier.addressResponse
                                              .wishlist.data.city !=
                                      null
                                  ? contactNotifier
                                      .addressResponse.wishlist.data.city
                                  : " " +
                                              "," +
                                              "\n" +
                                              contactNotifier.addressResponse
                                                  .wishlist.data.countryName !=
                                          null
                                      ? contactNotifier.addressResponse.wishlist
                                          .data.countryName
                                      : " " +
                                                  "-" +
                                                  contactNotifier
                                                      .addressResponse
                                                      .wishlist
                                                      .data
                                                      .postcode !=
                                              null
                                          ? contactNotifier.addressResponse
                                              .wishlist.data.postcode
                                          : " " + ".",
                      null,
                      AppConstants.MAP_CONTACT),
                if (contactNotifier.addressResponse.wishlist.data.phone != null)
                  _buildReachUsContent(
                      context,
                      Icon(AppCustomIcon.icon_call,
                          size: 18, color: colorPrimary),
                      contactNotifier.addressResponse.wishlist.data.phone !=
                              null
                          ? contactNotifier.addressResponse.wishlist.data.phone
                          : "",
                      contactNotifier.addressResponse.wishlist.data.phone !=
                              null
                          ? contactNotifier.addressResponse.wishlist.data.phone
                          : "",
                      AppConstants.PHONE_CONTACT),
                if (contactNotifier.addressResponse.wishlist.data.email1 !=
                    null)
                  _buildReachUsContent(
                      context,
                      Icon(AppCustomIcon.icon_envelope,
                          size: 18, color: colorPrimary),
                      contactNotifier.addressResponse.wishlist.data.email1 !=
                              null
                          ? contactNotifier.addressResponse.wishlist.data.email1
                          : "" +
                                      "\n" +
                                      contactNotifier.addressResponse.wishlist
                                          .data.email2 !=
                                  null
                              ? contactNotifier
                                  .addressResponse.wishlist.data.email2
                              : "" + ".",
                      contactNotifier.addressResponse.wishlist.data.email1 !=
                              null
                          ? contactNotifier.addressResponse.wishlist.data.email1
                          : "",
                      AppConstants.EMAIL_CONTACT),
                SizedBox(
                  height: 10.0,
                )
              ],
            ),
            decoration: BoxDecoration(
                color: colorWhite,
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
          )
        : Container();
  }

  Widget _heightSpace() {
    return SizedBox(
      height: 10.0,
    );
  }

  Container _buildReachUsContent(BuildContext context, Icon icon,
      String stContent, String contactInfo, String contact) {
    return Container(
      margin: EdgeInsets.only(top: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Flexible(
            flex: 20,
            child: SizedBox(
              height: 35.0,
              child: Container(
                child: FloatingActionButton(
                  elevation: 4.0,
                  child: icon,
                  backgroundColor: Colors.white,
                  onPressed: () => {
                    if (contact == AppConstants.PHONE_CONTACT)
                      {
                        if (contact != null)
                          {UrlLauncher.launch('tel:+$contactInfo')}
                      }
                    else if (contact == AppConstants.EMAIL_CONTACT)
                      {
                        if (contact != null)
                          {UrlLauncher.launch('mailto:$contactInfo')}
                      }
                    //
                    //
                  },
                ),
              ),
            ),
          ),
          Flexible(
            flex: 80,
            child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Text(
                  stContent,
                  style: getStyleBody1(context)
                      .copyWith(fontWeight: FontWeight.w500, height: 1.5),
                )),
          )
        ],
      ),
    );
  }

  String _validateName(String value) {
    return value.trim().length == 0
        ? AppConstants.NAME + " Can't be empty"
        : null;
  }

  String _validateEmail(String value) {
    return value.trim().length == 0
        ? 'Email is required'
        : validateEmail(value);
  }

  String _validateMobileNumber(String value) {
    return value.trim().length == 0
        ? AppConstants.PHONE_NUMBER + " Can't be empty"
        : null;
  }

  String _validateSubject(String value) {
    return value.trim().length == 0 ? "Subject Can't be empty" : null;
  }

  String _validateMessage(String value) {
    return value.trim().length == 0 ? "Message Can't be empty" : null;
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

  Future<void> _onClickSubmitContactUs(
      ContactUsNotifier contactNotifier) async {
    var callPostContactUsData = ContactUsFormRequest();
    callPostContactUsData.message = _textMessage.text;
    callPostContactUsData.telephone = _textMobileNumber.text;
    callPostContactUsData.email = _textEmail.text;
    callPostContactUsData.subject = _textSubject.text;
    callPostContactUsData.name = _textFullName.text;
    await contactNotifier
        .callPostContactUsData(callPostContactUsData)
        .then((value) {
      postFormResponse(value);
    });
  }

  postFormResponse(ContactUsFormResponse response) {
    if (response.status == 1) {
      _textMessage.text = "";
      _textSubject.text = "";
    }
    _showSnackBarMessage(response.message);
  }

  _showSnackBarMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    // Find the Scaffold in the widget tree and use it to show a SnackBar.
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
