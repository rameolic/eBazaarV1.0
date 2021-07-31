import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:thought_factory/core/data/remote/request_response/manage_address/update_address_request.dart';
import 'package:thought_factory/core/data/remote/request_response/user/user_detail_response.dart';
import 'package:thought_factory/core/notifier/add_address_notifier.dart';
import 'package:thought_factory/utils/app_colors.dart';
import 'package:thought_factory/utils/app_constants.dart';
import 'package:thought_factory/utils/app_custom_icon.dart';
import 'package:thought_factory/utils/app_font.dart';
import 'package:thought_factory/utils/app_screen_dimen.dart';
import 'package:thought_factory/utils/app_text_style.dart';
import 'package:thought_factory/utils/app_validators.dart';

class EditAddress extends StatefulWidget {
  static const routeName = '/shipping_screen';

  EditAddress();

  @override
  _EditAddress createState() => _EditAddress();
}

class _EditAddress extends State<EditAddress> {
  final _keyForm = GlobalKey<FormState>();
  final FocusNode _focusNodeFirstName = FocusNode();
  final FocusNode _focusNodeLastName = FocusNode();
  final FocusNode _focusNodeFax = FocusNode();
  final FocusNode _focusNodeCompany = FocusNode();
  final FocusNode _focusNodeStreetAddress = FocusNode();
  final FocusNode _focusNodeStreetAddressTwo = FocusNode();
  final FocusNode _focusNodeCity = FocusNode();
  final FocusNode _focusNodeZipCode = FocusNode();
  final FocusNode _focusNodePhoneNum = FocusNode();
  var spinnerErrorCorrection = 1.5;

  int index = -1;
  String addressId;
  bool shippingCheck = false;
  bool billingCheck = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Addresses addressDetail = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: _buildAppbar(context, addressDetail),
      body: ChangeNotifierProvider(
          create: (context) => AddAddressNotifier(context, addressDetail),
          child: Consumer<AddAddressNotifier>(
            builder: (BuildContext context, addAddressNotifier, _) =>
                ModalProgressHUD(
                    inAsyncCall: addAddressNotifier.isLoading,
                    child: _buildShippingForm(
                        context, addressDetail, addAddressNotifier)),
          )),
    );
  }

  AppBar _buildAppbar(context, Addresses stateManageAddress) {
    return AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text(
            stateManageAddress.manageAddress == 2
                ? AppConstants.EDIT_ADDRESS
                : AppConstants.ADD_ADDRESS,
            style: getAppBarTitleTextStyle(context)),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 8.0),
            child: Stack(
              children: <Widget>[
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    AppCustomIcon.icon_cart,
                    size: 18,
                  ),
                  tooltip: 'Open shopping cart',
                ),
                Positioned(
                  top: 5,
                  left: 25,
                  height: 17.0,
                  width: 17.0,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Text(
                      '0',
                      style: TextStyle(
                        fontSize: 11.0,
                        color: colorBlack,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ]);
  }

  Widget _buildShippingForm(BuildContext context, Addresses stateManageAddress,
      AddAddressNotifier addAddressNotifier) {
    return Container(
      color: colorGrey,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
          child: Form(
              key: _keyForm,
              child: Column(
                children: <Widget>[
                  _buildLabel(context, AppConstants.FIRST_NAME),
                  TextFormField(
                    controller: addAddressNotifier.textEditConFirstName,
                    focusNode: _focusNodeFirstName,
                    validator: (value) => validateEmptyCheck(
                        value, "${AppConstants.FIRST_NAME} can\'t be empty"),
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.next,
                    style: getAppFormTextStyle(context),
                    onFieldSubmitted: (String value) {
                      FocusScope.of(context).requestFocus(_focusNodeLastName);
                    },
                    decoration: _buildTextDecoration(),
                  ),
                  //textField: firstName

                  _buildLabel(context, AppConstants.LAST_NAME),
                  TextFormField(
                    controller: addAddressNotifier.textEditConLastName,
                    focusNode: _focusNodeLastName,
                    validator: (value) => validateEmptyCheck(
                        value, "${AppConstants.LAST_NAME} can\'t be empty"),
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.next,
                    style: getAppFormTextStyle(context),
                    onFieldSubmitted: (String value) {
                      FocusScope.of(context).requestFocus(_focusNodeCompany);
                    },
                    decoration: _buildTextDecoration(),
                  ),
                  //textField: lastName

//                  _buildLabel(context, AppConstants.E_MAIL_ADDRESS),
//                  TextFormField(
//                    controller: _textEditConEmail,
//                    keyboardType: TextInputType.emailAddress,
//                    textCapitalization: TextCapitalization.sentences,
//                    textInputAction: TextInputAction.next,
//                    validator: validateEmail,
//                    focusNode: _focusNodeEmail,
//                    style: getAppFormTextStyle(context),
//                    onFieldSubmitted: (String value) {
//                      FocusScope.of(context).requestFocus(_focusNodeCompany);
//                    },
//                    decoration: _buildTextDecoration(),
//                  ), //textField: email

                  _buildLabel(context, AppConstants.COMPANY),
                  TextFormField(
                    controller: addAddressNotifier.textEditConCompany,
                    focusNode: _focusNodeCompany,
                    validator: (value) => validateEmptyCheck(
                        value, "${AppConstants.COMPANY} can\'t be empty"),
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.next,
                    style: getAppFormTextStyle(context),
                    onFieldSubmitted: (String value) {
                      FocusScope.of(context)
                          .requestFocus(_focusNodeStreetAddress);
                    },
                    decoration: _buildTextDecoration(),
                  ),
                  //textField: company

                  _buildLabel(context, AppConstants.STREET_ADDRESS_ONE),
                  TextFormField(
                    maxLines: 4,
                    controller: addAddressNotifier.textEditConStreetAddress,
                    focusNode: _focusNodeStreetAddress,
                    validator: (value) => validateEmptyCheck(value,
                        "${AppConstants.STREET_ADDRESS_ONE} can\'t be empty"),
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.next,
                    style: getAppFormTextStyle(context),
                    onFieldSubmitted: (String value) {
                      FocusScope.of(context)
                          .requestFocus(_focusNodeStreetAddressTwo);
                    },
                    decoration: _buildTextDecoration(),
                  ),
                  //textField: streetAddress
                  _buildLabel(context, AppConstants.STREET_ADDRESS_TWO),
                  TextFormField(
                    maxLines: 4,
                    controller: addAddressNotifier.textEditConStreetAddressTwo,
                    focusNode: _focusNodeStreetAddressTwo,
                    validator: (value) => validateEmptyCheck(value,
                        "${AppConstants.STREET_ADDRESS_TWO} can\'t be empty"),
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.next,
                    style: getAppFormTextStyle(context),
                    onFieldSubmitted: (String value) {
                      FocusScope.of(context).requestFocus(_focusNodeCity);
                    },
                    decoration: _buildTextDecoration(),
                  ),

                  _buildLabel(context, AppConstants.CITY),
                  TextFormField(
                    controller: addAddressNotifier.textEditConCity,
                    focusNode: _focusNodeCity,
                    validator: (value) => validateEmptyCheck(
                        value, "${AppConstants.CITY} can\'t be empty"),
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.next,
                    style: getAppFormTextStyle(context),
                    onFieldSubmitted: (String value) {
                      FocusScope.of(context).requestFocus(_focusNodeZipCode);
                    },
                    decoration: _buildTextDecoration(),
                  ),
                  //textField: city

                  _buildLabel(context, AppConstants.STATE_PROVINCE),
                  addAddressNotifier.listRegion != null &&
                          addAddressNotifier.listRegion.length > 0
                      ? Container(
                          width: double.infinity,
                          padding: EdgeInsets.only(left: 16.0, right: 16.0),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  contentPadding: EdgeInsets.all(0)),
                              value: addAddressNotifier.selectedRegion,
                              items: addAddressNotifier.listRegion.map((value) {
                                addAddressNotifier.textEditConRegion.text = '';
                                return DropdownMenuItem(
                                  value: value.name,
                                  child: Text(
                                    value.name,
                                    style: getAppFormTextStyle(context),
                                  ),
                                );
                              }).toList(),
                              onChanged: (selectedValue) => {
                                setState(() {
                                  addAddressNotifier.selectedRegion =
                                      selectedValue;
                                })
                              },
                            ),
                          ),
                          decoration: ShapeDecoration(
                            color: colorWhite,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: colorWhite,
                                  width: 1.0,
                                  style: BorderStyle.solid),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(24.0)),
                            ),
                          ),
                        )
                      : Container(
                          width: double.maxFinite,
                          child: TextFormField(
                            validator: _validateRegion,
                            controller: addAddressNotifier.textEditConRegion,
                            maxLines: 1,
                            style: getStyleSubHeading(context).copyWith(
                                color: colorBlack,
                                fontWeight: AppFont.fontWeightSemiBold),
                            decoration: _buildTextDecoration(),
                          )),
                  //dropDown: state/province

                  _buildLabel(context, AppConstants.ZIP_POSTAL_CODE),
                  TextFormField(
                    controller: addAddressNotifier.textEditConZipCode,
                    focusNode: _focusNodeZipCode,
                    validator: (value) => validateEmptyCheck(value,
                        "${AppConstants.ZIP_POSTAL_CODE} can\'t be empty"),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      WhitelistingTextInputFormatter(RegExp("[0-9]"))
                    ],
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.next,
                    style: getAppFormTextStyle(context),
                    onFieldSubmitted: (String value) {
                      FocusScope.of(context).requestFocus(_focusNodeFax);
                    },
                    decoration: _buildTextDecoration(),
                  ),
                  //textField: zip/ Postal code
                  _buildLabel(context, AppConstants.FAX),
                  TextFormField(
                    controller: addAddressNotifier.textEditConFax,
                    focusNode: _focusNodeFax,
                    keyboardType: TextInputType.number,
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.next,
                    style: getAppFormTextStyle(context),
                    onFieldSubmitted: (String value) {
                      FocusScope.of(context).requestFocus(_focusNodePhoneNum);
                    },
                    decoration: _buildTextDecoration(),
                  ),
                  //textField: zip/ Postal code

                  _buildLabel(context, AppConstants.COUNTRY),
                  (addAddressNotifier.countryListResponse.listCountryInfo !=
                              null &&
                          addAddressNotifier
                                  .countryListResponse.listCountryInfo.length >
                              0 &&
                          addAddressNotifier.selectedCountry != null)
                      ? Container(
                          width: double.infinity,
                          padding: EdgeInsets.only(left: 16.0, right: 16.0),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                  enabled: true,
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  contentPadding: EdgeInsets.all(0)),
                              value: addAddressNotifier.selectedCountry,
                              items: addAddressNotifier
                                  .countryListResponse.listCountryInfo
                                  .map((value) {
                                return DropdownMenuItem<String>(
                                  value: value.fullNameEnglish,
                                  child: Container(
                                    width: getScreenWidth(context) / 2.2,
                                    child: Text(
                                      value.fullNameEnglish ?? '',
                                      overflow: TextOverflow.ellipsis,
                                      style: getAppFormTextStyle(context),
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (selectedValue) {
                                setState(() {
                                  addAddressNotifier.selectedCountry =
                                      selectedValue;
                                });
                              },
                            ),
                          ),
                          decoration: ShapeDecoration(
                            color: colorWhite,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: colorWhite,
                                  width: 1.0,
                                  style: BorderStyle.solid),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(24.0)),
                            ),
                          ),
                        )
                      : Container(),
//                  (addAddressNotifier.countryListResponse.listCountryInfo !=
//                          null && addAddressNotifier.countryListResponse.listCountryInfo.length > 0 && addAddressNotifier.selectedCountry != null)
//                      ? Container(
//                          width: double.infinity,
//                          padding: EdgeInsets.only(left: 16.0, right: 16.0),
//                          child: DropdownButtonHideUnderline(
//                            child: DropdownButtonFormField(
//                              decoration: InputDecoration(
//                                  enabledBorder: UnderlineInputBorder(
//                                      borderSide:
//                                          BorderSide(color: Colors.white)), contentPadding: EdgeInsets.all(0)),
//                              value: addAddressNotifier.selectedCountry,
//                              items: addAddressNotifier
//                                  .countryListResponse.listCountryInfo
//                                  .map((value) {
//                                return DropdownMenuItem<String>(
//                                  value: value.fullNameEnglish,
//                                  child: Text(
//                                    value.fullNameEnglish ?? '',
//                                    style: getAppFormTextStyle(context),
//                                  ),
//                                );
//                              }).toList(),
//                              onChanged: (selectedValue) => {
//                                setState(() {
//                                  addAddressNotifier.selectedCountry =
//                                      selectedValue;
//                                })
//                              },
//                            ),
//                          ),
//                          decoration: ShapeDecoration(
//                            color: colorWhite,
//                            shape: RoundedRectangleBorder(
//                              side: BorderSide(
//                                  color: colorWhite,
//                                  width: 1.0,
//                                  style: BorderStyle.solid),
//                              borderRadius:
//                                  BorderRadius.all(Radius.circular(24.0)),
//                            ),
//                          ),
//                        )
//                      : Container(), //dropdown: choose country

                  _buildLabel(context, AppConstants.PHONE_NUMBER),
                  TextFormField(
                    controller: addAddressNotifier.textEditConPhoneNum,
                    focusNode: _focusNodePhoneNum,
                    validator: (value) => validateEmptyCheck(
                        value, "${AppConstants.PHONE_NUMBER} can\'t be empty"),
                    keyboardType: TextInputType.phone,
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.done,
                    style: getAppFormTextStyle(context),
                    decoration: _buildTextDecoration(),
                  ),
                  //textField: phone number
                  (stateManageAddress.defaultShipping == null)
                      ? CheckboxListTile(
                          value: addAddressNotifier.shippingAddress,
                          onChanged: (value) =>
                              addAddressNotifier.shippingAddress = value,
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Text(
                            "Set as Default Shipping Address",
                            style: getStyleSubHeading(context).copyWith(
                                fontWeight: AppFont.fontWeightSemiBold),
                          ))
                      : Container(),
                  (stateManageAddress.defaultBilling == null)
                      ? CheckboxListTile(
                          value: addAddressNotifier.billingAddress,
                          onChanged: (value) =>
                              addAddressNotifier.billingAddress = value,
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Text(
                            "Set as Default Billing Address",
                            style: getStyleSubHeading(context).copyWith(
                                fontWeight: AppFont.fontWeightSemiBold),
                          ))
                      : Container(),

                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 24),
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
                                if (_keyForm.currentState.validate()) {
                                  var _updateAddressRequest =
                                      UpdateAddressRequest();
                                  _updateAddressRequest.firstName =
                                      addAddressNotifier
                                          .textEditConFirstName.text;
                                  _updateAddressRequest.lastName =
                                      addAddressNotifier
                                          .textEditConLastName.text;
                                  _updateAddressRequest.company =
                                      addAddressNotifier
                                          .textEditConCompany.text;
                                  _updateAddressRequest.street1 =
                                      addAddressNotifier
                                          .textEditConStreetAddress.text;
                                  _updateAddressRequest.street2 =
                                      addAddressNotifier
                                          .textEditConStreetAddressTwo.text;
                                  _updateAddressRequest.city =
                                      addAddressNotifier.textEditConCity.text;
                                  _updateAddressRequest.postcode =
                                      addAddressNotifier
                                          .textEditConZipCode.text;
                                  _updateAddressRequest.telephone =
                                      addAddressNotifier
                                          .textEditConPhoneNum.text;
                                  _updateAddressRequest.fax =
                                      addAddressNotifier.textEditConFax.text;
                                  (stateManageAddress.manageAddress == 2)
                                      ? addAddressNotifier.updateAddress(
                                          _updateAddressRequest,
                                          addAddressNotifier.textEditConRegion)
                                      : addAddressNotifier.addAddress(
                                          _updateAddressRequest,
                                          addAddressNotifier.textEditConRegion);
                                }
                              },
                              child: Text(
                                stateManageAddress.manageAddress == 2
                                    ? AppConstants.UPDATE
                                    : 'Add',
                                style: getStyleButtonText(context),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25.0))),
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
                                Navigator.pop(context, null);
                              },
                              child: Text(
                                AppConstants.CANCEL,
                                style: getStyleButtonText(context),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25.0))),
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
                  )
                ],
              )),
        ),
      ),
    );
  }

  Widget _buildLabel(BuildContext context, String labelName) {
    return Container(
      margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
      alignment: Alignment.centerLeft,
      child: RichText(
        text: TextSpan(children: <TextSpan>[
          TextSpan(
              text: labelName,
              style: getStyleCaption(context)
                  .copyWith(fontWeight: AppFont.fontWeightSemiBold)),
          TextSpan(
              text: (labelName != AppConstants.FAX) ? ' *' : '',
              style: getStyleSubTitle(context).copyWith(color: colorPrimary))
        ]),
      ),
    );
  }

  InputDecoration _buildTextDecoration() {
    return InputDecoration(
        isDense: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide(width: 0, style: BorderStyle.none)),
        filled: true,
        fillColor: colorWhite,
        contentPadding: EdgeInsets.all(16));
  }

  // Add / Edit Address View of Buttons
  void _onTappedAddOrEditButton(int index, bool toEdit) {
    if (index == -1) {
      // Add new item here (So Manage Address List could be empty array or list may contain)
      // simply update the object through API

    } else if (toEdit) {
      // Update specific Item here
      // Use Exact Index to update Exact Obj through API

    } else {
      // Add one more new item to Array
    }
  }

  String _validateRegion(String value) {
    return value.trim().length == 0 ? 'Field can\'t be empty' : null;
  }

  void _onTappedCanceltButton() {}

  // Shipping  Address View of Button
  void _onTappedButtonNext() {}
}
