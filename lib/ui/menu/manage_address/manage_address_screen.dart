import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:thought_factory/core/data/remote/request_response/user/user_detail_response.dart';
import 'package:thought_factory/core/notifier/manage_address_notifier.dart';
import 'package:thought_factory/state/state_manage_address.dart';
import 'package:thought_factory/utils/app_colors.dart';
import 'package:thought_factory/utils/app_custom_icon.dart';
import 'package:thought_factory/utils/app_font.dart';
import 'package:thought_factory/utils/app_text_style.dart';

import 'edit_address_screen.dart';

class ManageAddressScreen extends StatefulWidget {
  static const routeName = '/manage_address_screen';

  @override
  ManageAddressScreenState createState() => ManageAddressScreenState();
}

class ManageAddressScreenState extends State<ManageAddressScreen> {
  double paddingLeft = 2.0;
  double paddingRight = 2.0;
  double itemCardRadius = 5.0;
  double twoFiveRadius = 25.0;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: colorGrey,
      appBar: _buildAppBar(context, "0", 'Manage Address'),
      body: ChangeNotifierProvider(
        create: (context) => ManageOrderNotifier(context),
        child: Consumer<ManageOrderNotifier>(
            builder: (BuildContext context, manageAddressScreen, _) =>
                ModalProgressHUD(
                  inAsyncCall: manageAddressScreen.isLoading,
                  child: (manageAddressScreen.userDetailByTokenResponse != null)
                      ? _buildContentPage(manageAddressScreen, context)
                      : (manageAddressScreen.isLoading)
                          ? Container()
                          : Container(
                              child: Center(
                                child: Text('Something went wrong. Try again'),
                              ),
                            ),
                )),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, String count, String title) {
    return AppBar(
        elevation: 3.0,
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back_ios,
              size: 20.0,
            )),
        title: Text(
          title,
          style: getAppBarTitleTextStyle(context),
        ),
        actions: <Widget>[
          Visibility(
            visible: false,
            child: Container(
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
                        count,
                        style: getStyleBody2(context).copyWith(
                            fontSize: 11.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ]);
  }

  Widget _buildContentPage(
      ManageOrderNotifier manageAddressScreen, BuildContext context) {
    return Stack(
      children: <Widget>[
        manageAddressScreen.userDetailByTokenResponse.addresses != null &&
                manageAddressScreen.userDetailByTokenResponse.addresses.length >
                    0
            ? Container(
                child: ListView.builder(
                  padding: EdgeInsets.only(
                      top: 16.0, left: 16.0, right: 16.0, bottom: 140.0),
                  itemCount: manageAddressScreen
                      .userDetailByTokenResponse.addresses.length,
                  itemBuilder: (_, index) {
                    return buildListItemOrder(
                        index, context, manageAddressScreen);
                  },
                ),
              )
            : Container(
                child: Center(
                  child: Text('No Address found'),
                ),
              ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.bottomCenter,
              child: _buildBottomLayout(context, manageAddressScreen),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: buildButtonProceed(manageAddressScreen),
            )
          ],
        )
      ],
    );
  }

  Widget buildListItemOrder(int index, BuildContext context,
      ManageOrderNotifier manageAddressScreen) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(itemCardRadius))),
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Radio(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              value: index,
              groupValue: manageAddressScreen.selectedRadioAddress,
              onChanged: (value) =>
                  onClickAddressSelect(value, manageAddressScreen),
            ),
            Flexible(
              fit: FlexFit.loose,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    manageAddressScreen.userDetailByTokenResponse
                            .addresses[index].firstname +
                        " " +
                        manageAddressScreen.userDetailByTokenResponse
                            .addresses[index].lastname, //"A M Steve Smith",
                    style: getStyleSubHeading(context).copyWith(
                        color: colorBlack,
                        fontWeight: AppFont.fontWeightSemiBold,
                        height: 0),
                  ),
                  verticalSpace(12),
                  AutoSizeText(
                    listToStrings(manageAddressScreen.userDetailByTokenResponse
                            .addresses[index].street) +
                        "," +
                        "\n${manageAddressScreen.userDetailByTokenResponse.addresses[index].city}," +
                        "${manageAddressScreen.userDetailByTokenResponse.addresses[index].region.region} " +
                        "${manageAddressScreen.userDetailByTokenResponse.addresses[index].postcode}." +
                        "\n${manageAddressScreen.userDetailByTokenResponse.addresses[index].telephone}",
                    style: getStyleBody2(context).copyWith(color: colorBlack),
                    maxLines: 4,
                    softWrap: true,
                    overflow: TextOverflow.fade,
                  ),
                  verticalSpace(8),
                  Divider(
                    height: 1.0,
                    color: colorDarkGrey,
                  ),
                  verticalSpace(8),
                  Row(
                    children: <Widget>[
                      GestureDetector(
                        child: Row(
                          children: <Widget>[
                            Icon(
                              AppCustomIcon.icon_edit,
                              color: Colors.orange,
                              size: 16.0,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Edit",
                              style: getStyleBody1(context),
                            ),
                          ],
                        ),
                        onTap: () {
                          //  manageAddressScreen.index = index;
                          //  manageAddressScreen.manageAddressThreeState = 2;
                          //  manageAddressScreen.addressId=manageAddressScreen.userDetailByTokenResponse.addresses[index].id.toString();
                          manageAddressScreen.userDetailByTokenResponse
                              .addresses[index].manageAddress = 2;
                          Navigator.pushNamed(context, EditAddress.routeName,
                                  arguments: manageAddressScreen
                                      .userDetailByTokenResponse
                                      .addresses[index])
                              .then((onValue) {
                            if (onValue != null && onValue == "onValue") {
                              Provider.of<ManageOrderNotifier>(context)
                                  .callApiGetUserProfileDetail();
                            }
                          });

                          //_navigateToShippingToEdit(context);
                        },
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      _manageAddress(
                              manageAddressScreen.userDetailByTokenResponse,
                              index)
                          ? Container()
                          : GestureDetector(
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    AppCustomIcon.icon_delete,
                                    color: colorPrimary,
                                    size: 16.0,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "Delete",
                                    style: getStyleBody1(context),
                                  ),
                                ],
                              ),
                              onTap: () {
                                manageAddressScreen.callDeleteAddressAPI(
                                    manageAddressScreen
                                        .userDetailByTokenResponse
                                        .addresses[index]
                                        .id);
                              },
                            ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container buildButtonProceed(ManageOrderNotifier manageOrderNotifier) {
    return Container(
      height: 60,
      color: Colors.transparent,
      alignment: Alignment.topCenter,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 10.0,
          ),
          Expanded(
            flex: 1,
            child: RaisedButton(
              onPressed: () {
                _onClickedButtonDefaultAddress(manageOrderNotifier);
              },
              child: Text("Set as Default Address",
                  style: getStyleButtonText(context)),
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(twoFiveRadius))),
              color: colorPrimary,
              padding: EdgeInsets.only(top: 16.0, bottom: 10.0),
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
        ],
      ),
    );
  }

  bool _manageAddress(UserDetailResponse userDetailByTokenResponse, int index) {
    if (userDetailByTokenResponse.addresses[index].defaultShipping != null &&
        userDetailByTokenResponse.addresses[index].defaultBilling != null) {
      return true;
    } else if (userDetailByTokenResponse.addresses[index].defaultShipping !=
        null) {
      return true;
    } else if (userDetailByTokenResponse.addresses[index].defaultBilling !=
        null) {
      return true;
    } else {
      return false;
    }
  }

  bool _manageAddressUpdate(
      UserDetailResponse userDetailByTokenResponse, int index) {
    if (userDetailByTokenResponse.addresses[index].defaultShipping != null &&
        userDetailByTokenResponse.addresses[index].defaultBilling != null) {
      return true;
    } else if (userDetailByTokenResponse.addresses[index].defaultShipping !=
        null) {
      return true;
    } else if (userDetailByTokenResponse.addresses[index].defaultBilling !=
        null) {
      return false;
    } else {
      return false;
    }
  }

  String listToStrings(List list) {
    String value = "";
    for (int i = 0; i < list.length; i++) {
      value = value + list[i].toString();
      if (i + 1 != list.length) {
        value = value + ", ";
      }
    }
    return value;
  }

  _getRequests(StateManageAddress stateMngAddr, BuildContext context) async {
    if (stateMngAddr != null) {
      var stateManageAddress = Provider.of<StateManageAddress>(context);

      print("Before Val :" +
          stateManageAddress.manageAddressThreeState.toString());

      stateManageAddress = stateMngAddr;
      print("Passed Val :" + stateMngAddr.manageAddressThreeState.toString());

      print("Update Val " +
          stateManageAddress.manageAddressThreeState.toString());
    }
  }

  Widget _buildBottomLayout(
      BuildContext context, ManageOrderNotifier manageAddressScreen) {
    return Container(
      height: 50.0,
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 20),
      child: GestureDetector(
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
        onTap: () {
          var address = Addresses();
          address.manageAddress = -1;
          Navigator.pushNamed(context, EditAddress.routeName,
                  arguments: address)
              .then((onValue) {
            if (onValue != null && onValue == "onValue") {
              Provider.of<ManageOrderNotifier>(context)
                  .callApiGetUserProfileDetail();
            }
          });

          // _navigateToShippingToAdd(context);
        },
      ),
      decoration: BoxDecoration(
          color: colorWhite,
          borderRadius: BorderRadius.all(Radius.circular(50.0))),
    );
  }

  Widget verticalSpace(double height) {
    return SizedBox(
      height: height,
    );
  }

  void _onClickedButtonDefaultAddress(ManageOrderNotifier manageOrderNotifier) {
    if (manageOrderNotifier.selectedRadioAddress != -1) {
      if (!_manageAddressUpdate(manageOrderNotifier.userDetailByTokenResponse,
          manageOrderNotifier.selectedRadioAddress)) {
        manageOrderNotifier.callUpdateAddress();
      } else {
        manageOrderNotifier
            .showSnackBarMessageWithContext("Select some other address");
      }
    } else {
      manageOrderNotifier
          .showSnackBarMessageWithContext("Please choose the address");
    }
  }

  getStreetDetails(List<String> street) {
    return "";
  }
}

onClickAddressSelect(value, ManageOrderNotifier manageAddressScreen) {
  manageAddressScreen.selectedRadioAddress = value;
}
