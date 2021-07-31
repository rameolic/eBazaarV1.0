import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:thought_factory/core/data/remote/request_response/user/user_detail_response.dart';
import 'package:thought_factory/core/model/profile/profile_info.dart';
import 'package:thought_factory/core/notifier/home_notifier.dart';
import 'package:thought_factory/ui/password/change_pwd_screen.dart';
import 'package:thought_factory/ui/menu/manage_address/manage_address_screen.dart';
import 'package:thought_factory/utils/app_colors.dart';
import 'package:thought_factory/utils/app_constants.dart';
import 'package:thought_factory/utils/app_custom_icon.dart';
import 'package:thought_factory/utils/app_font.dart';
import 'package:thought_factory/utils/app_images.dart';
import 'package:thought_factory/utils/app_log_helper.dart';
import 'package:thought_factory/utils/app_text_style.dart';

import 'edit_profile.dart';

class MyProfile extends StatefulWidget {
  @override
  MyProfileState createState() => MyProfileState();
}

class MyProfileState extends State<MyProfile> {
  final log = getLogger('MyProfileScreen');
  double fontSizeValue = 14.0;
  var colorFadeOut = colorCloseIconImage;
  File _image;
  /// Parent Padding
  double parentPaddingLeftRight = 16;
  double parentPaddingTop = 24;
  final GlobalKey<ScaffoldState> _keyScaffold = new GlobalKey<ScaffoldState>(debugLabel: "MyProfile");

  /// Basic Info Card of Variables
  TextStyle subTitleStyle;
  TextStyle infoCardKeyFieldStyle;
  TextStyle infoCardValueFieldStyle;
  double cardRadius = 6.0;


  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      //update scaffold context
      HomeNotifier homeNotifier = Provider.of<HomeNotifier>(context);
      homeNotifier.context = context;
     // Provider.of<HomeNotifier>(context).callApiGetUserProfileDetail();
      initialSetup(homeNotifier);

    });
  }
  void initialSetup(HomeNotifier homeNotifier) async{
    await homeNotifier.callProfileImage();
    await homeNotifier.callApiGetUserProfileDetail();

  }
  @override
  Widget build(BuildContext context) {
    subTitleStyle = getStyleSubHeading(context).copyWith(fontWeight: AppFont.fontWeightSemiBold);
    infoCardKeyFieldStyle = getStyleBody2(context).copyWith(fontWeight: AppFont.fontWeightSemiBold);
    infoCardValueFieldStyle = getStyleBody1(context).copyWith(color: colorBlack);
    return Scaffold(
      key: _keyScaffold,
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: SingleChildScrollView(
                  child: Consumer<HomeNotifier>(
                    builder: (context, homeNotifier, _) => ModalProgressHUD(
                      inAsyncCall: homeNotifier.isLoading,
                      child: Container(
                        color: colorGrey,
                        padding: EdgeInsets.only(
                            left: parentPaddingLeftRight, right: parentPaddingLeftRight, top: parentPaddingTop),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            _buildBasicInformationCard(context, homeNotifier),
                            verticalSpace(8.0),
                            _buildPasswordCard(),
                            verticalSpace(8.0),
                            (homeNotifier.userDetailByTokenResponse.addresses != null &&
                                homeNotifier.userDetailByTokenResponse.addresses.length > 0)
                                ? _buildAddressCard(context, homeNotifier)
                                : Container(),
                            verticalSpace(128.0)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
//        ChangeNotifierProvider<HomeNotifier>(
//          builder: (context) => HomeNotifier(),
//          child:
//        ),
        ],
      ),
    );
  }

  Widget _buildBasicInformationCard(BuildContext context, HomeNotifier homeNotifier) {
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(cardRadius))),
      child: Container(
        margin: EdgeInsets.only(left: 16.0, bottom: 20),
        child: Column(
          children: <Widget>[
            _buildCardTitleArea(context, AppConstants.BASIC_INFORMATION, 1, homeNotifier),
             CachedNetworkImage(
                    imageUrl: (homeNotifier.imageUrl!=null)?homeNotifier.imageUrl:"",
                    imageBuilder: (context, imageProvider) => Container(
                          width: 100.0,
                          height: 100.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(alignment: Alignment.center, image: imageProvider, fit: BoxFit.cover),
                            //borderRadius: BorderRadius.all(Radius.circular(50.0)),
                            border: Border.all(
                              color: colorPrimary,
                              width: 3.0,
                            ),
                          ),
                        ),
                    placeholder: (context, url) => _buildPlaceHolder(context),
                    errorWidget: (context, url, error) => _buildPlaceHolder(context)),
            verticalSpace(8.0),
            _buildDetailCardRowItem("Company name",
                "${homeNotifier.userDetailByTokenResponse.firstname ?? ""}"),
            _buildDetailCardRowItem("Location",
                "${homeNotifier.userDetailByTokenResponse.lastname ?? ""}"),
            _buildDetailCardRowItem(AppConstants.EMAIL, homeNotifier.userDetailByTokenResponse.email ?? ""),
//            _buildDetailCardRowItem(
//                AppConstants.PHONE,
//                (homeNotifier.userDetailByTokenResponse.addresses != null &&
//                        homeNotifier.userDetailByTokenResponse.addresses.length > 0)
//                    ? homeNotifier.userDetailByTokenResponse.addresses[0].telephone
//                    : ""),

            //_buildDetailCardRowItem(AppConstants.TRN, '783432343243')
          ],
        ),
      ),
    );
  }
  Widget _buildPasswordCard() {
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(cardRadius))),
      child: Container(
        margin: EdgeInsets.only(left: 16.0, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildCardTitleArea(context, AppConstants.PASSWORD, 2, null),
            verticalSpace(16.0),
            Text(
              '.........',
              style: subTitleStyle.copyWith(fontSize: 50, height: 0, color: colorDarkGrey),
              textAlign: TextAlign.left,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAddressCard(BuildContext context, HomeNotifier homeNotifier) {
    return Card(
        elevation: 3.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(cardRadius))),
        child: Container(
          margin: EdgeInsets.only(left: 16.0, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildCardTitleArea(context, AppConstants.ADDRESS, 3, homeNotifier),
              Text(
                listToStrings(retrunString(homeNotifier.userDetailByTokenResponse.addresses))+
                    "${retrunAddressString(homeNotifier.userDetailByTokenResponse.addresses)}",
                style: infoCardValueFieldStyle.copyWith(height: 1.5)

              )
            ],
          ),
        ));
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


  retrunString(List<Addresses> addresses) {
     addresses = addresses.where((item) => (item.defaultShipping == true)).toList();
     return addresses[0].street;
  }

  retrunAddressString(List<Addresses> addresses) {
    addresses = addresses.where((item) => (item.defaultShipping == true)).toList();
   var data= "\n${addresses[0].city}," +
        "${addresses[0].region.region} " +
        "${addresses[0].postcode}." +
        "\n${addresses[0].telephone}";
    return data ;
  }

  // Page of common Widgets
  Widget _buildCardTitleArea(BuildContext context, String cardTitle, int whichCardClick, HomeNotifier homeNotifier) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text(
                cardTitle,
                style: subTitleStyle,
                overflow: TextOverflow.ellipsis,
              ),
            )),
            GestureDetector(
              child: IconButton(
                  padding: EdgeInsets.all(6),
                  icon: Icon(
                    AppCustomIcon.icon_edit,
                    size: 14,
                    color: colorPrimary,
                  ),
                  onPressed: null),
              onTap: ()  {
                switch (whichCardClick) {
                  case 1: // Basic Information
                  //  Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile()));
                    Navigator.of(context)
                        .pushNamed(EditProfile.routeName, arguments: ProfileInfo(
                        firstName: homeNotifier.userDetailByTokenResponse.firstname,
                    lastName: homeNotifier.userDetailByTokenResponse.lastname,
                    mailID: homeNotifier.userDetailByTokenResponse.email,
                    imageUrl:homeNotifier.imageUrl ,
                    websSiteid:homeNotifier.userDetailByTokenResponse.websiteId.toString() ,
                    id:homeNotifier.userDetailByTokenResponse.id.toString()  ,
                    storeId:homeNotifier.userDetailByTokenResponse.storeId.toString()  ,
//                        (homeNotifier.userDetailByTokenResponse.addresses != null &&
//                            homeNotifier.userDetailByTokenResponse.addresses.length > 0)
//                            ? homeNotifier.userDetailByTokenResponse.addresses[0].telephone
//                            : "")

                    mobileNumber: (homeNotifier.userDetailByTokenResponse.addresses != null &&
                        homeNotifier.userDetailByTokenResponse.addresses.length > 0)
                        ? homeNotifier.userDetailByTokenResponse.addresses[0].telephone
                        : "")).then((onValue){
                      if(onValue !=null && onValue=="onValue"){
                        //initialSetup(homeNotifier);
                        showMessage("Profile Detail Updated Successfully");
                        Provider.of<HomeNotifier>(context).callProfileImage();
                        Provider.of<HomeNotifier>(context).callApiGetUserProfileDetail();
                      } else if (onValue !=null && onValue=="onValue1") {
                        //initialSetup(homeNotifier);
                        showMessage("Profile Image uploaded Successfully");
                        Provider.of<HomeNotifier>(context).callProfileImage();
                        Provider.of<HomeNotifier>(context).callApiGetUserProfileDetail();
                        homeNotifier.showSnackBarMessageWithContext("Profile image uploaded successfully.");
                      }
                    });
                    break;
                  case 2: // Change Password
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePasswordScreen()));
                    break;
                  case 3: // Address List
                 //   Navigator.pushNamed(context, ManageAddressScreen())
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ManageAddressScreen())).then((onValue){
                      if(onValue !=null && onValue=="onValue"){
                        Provider.of<HomeNotifier>(context).callApiGetUserProfileDetail();
                      }
                    });
                    break;
                  default:
                    break;
                }
              },
            )
          ],
        ),
        Container(
          padding: const EdgeInsets.only(right: 16.0),
          child: Divider(
            height: 1.0,
            color: colorDarkGrey,
          ),
        ),
        verticalSpace(16.0)
      ],
    );
  }

  Widget _buildDetailCardRowItem(String labelName, String value) {
    return Container(
      padding: EdgeInsets.only(top: 16.0, right: 16),
      child: Row(
        children: <Widget>[
          Text(
            labelName,
            style: infoCardKeyFieldStyle,
          ),
          Flexible(
              child: Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    value != null ? value : "",
                    style: infoCardValueFieldStyle,
                    textAlign: TextAlign.end,
                  )))
        ],
      ),
    );
  }

  Widget verticalSpace(double height) {
    return SizedBox(
      height: height,
    );
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

  void showMessage(String content) {
    _keyScaffold.currentState.showSnackBar(SnackBar(content: Text(content), duration: Duration(seconds: AppConstants.TIME_SHOW_SNACK_BAR),));
  }
}
