import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:thought_factory/utils/app_colors.dart';
import 'package:thought_factory/utils/app_constants.dart';
import 'package:thought_factory/utils/app_font.dart';
import 'package:thought_factory/utils/app_images.dart';
import 'package:thought_factory/utils/app_text_style.dart';
import 'package:thought_factory/utils/widgetHelper/custom_tab_indicator.dart';

class DistributorProfileScreen extends StatefulWidget {
  static const routeName = '/distributor_profile_screen';

  DistributorProfileScreen();

  @override
  _DistributorProfileScreenState createState() => _DistributorProfileScreenState();
}

class _DistributorProfileScreenState extends State<DistributorProfileScreen> with SingleTickerProviderStateMixin{

  final List<Tab> tabs = <Tab>[
    new Tab(text: AppConstants.GENERAL_INFO,),
    new Tab(text: AppConstants.PASSWORD),
    new Tab(text: AppConstants.ADDRESS_INFO),
    new Tab(text: AppConstants.WARE_HOUSE),
    new Tab(text: AppConstants.BANK_INFO),
    new Tab(text: AppConstants.COMPANY_INFO),
    new Tab(text: AppConstants.SOCIAL_MEDIA_INFO),
    new Tab(text: AppConstants.SEO_MANAGEMENT,)
  ];

  TextStyle subTitleStyle;
  TextStyle infoCardKeyFieldStyle;
  TextStyle infoCardValueFieldStyle;
  double cardRadius = 6.0;
  double captionToTextFieldDistance = 4;
  double textFieldToCaptionDistance = 8;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: tabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    subTitleStyle = getStyleSubHeading(context).copyWith(fontWeight: AppFont.fontWeightSemiBold);
    infoCardKeyFieldStyle = getStyleBody2(context).copyWith(fontWeight: AppFont.fontWeightSemiBold);
    infoCardValueFieldStyle = getStyleBody1(context).copyWith(color: colorBlack);

    return Scaffold(
      appBar: _buildAppbar(context),
      body: _buildProfileContentScreen(context),
//      Consumer<StateManageAddress>(
//          builder: (BuildContext context, stateManageAddress, _) =>
//              _buildShippingForm(context)),
    );
  }

  AppBar _buildAppbar(context) {
    return AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: colorWhite,
        title:  Text(AppConstants.DISTRIBUTOR_PROFILE),
        bottom: TabBar(
          isScrollable: true,
          unselectedLabelColor: colorBlack,
          labelColor: colorPrimary,
          indicatorSize: TabBarIndicatorSize.tab,
          labelStyle: getStyleBody2(context).copyWith(color: colorPrimary, fontWeight : AppFont.fontWeightSemiBold),
          unselectedLabelStyle: getStyleBody2(context).copyWith(color: colorBlack, fontWeight : AppFont.fontWeightSemiBold ),
          indicatorColor: Colors.orange,
          indicator: CustomTabIndicator(
            indicatorHeight: 35.0,
            padding: EdgeInsets.only(left: 16.0, right: 16.0),
            indicatorColor: colorPrimary,
            tabBarIndicatorSize: TabBarIndicatorSize.tab,
          ),
          tabs: tabs,
          controller: _tabController,

        ),
    );
  }

  Widget _buildProfileContentScreen(BuildContext context) {

    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            color: colorGrey,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 700, maxWidth: 700),
              child: TabBarView(
                    physics: ScrollPhysics(),
                    controller: _tabController,
                    children: <Widget>[
                      _buildGeneralInfo(),
                      _buildChangePassword(),
                      _buildAddressInfo(),
                      _buildWarehouse(),
                      _buildBankInfo(),
                      _buildCompanyInfo(),
                      _buildSocialMediaInfo(),
                      _buildSeoManagement()
                    ],
               ),
            ),

          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 20.0,
                ),
                Expanded(
                  flex: 1,
                  child: RaisedButton(
                    onPressed: () {
                      if(_tabController.index == 0){
                        _tabController.animateTo(_tabController.length - 1, duration: Duration(milliseconds: 600));
                      }else{
                        _tabController.animateTo(_tabController.index - 1, duration: Duration(milliseconds: 600));
                      }
                    },
                    child: Text(
                      AppConstants.PREVIOUS,
                      style: getStyleButtonText(context),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0))),
                    color: colorFbBlue,
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
                      if (_tabController.index == _tabController.length - 1){
                        _tabController.animateTo(0, duration: Duration(milliseconds: 600));
                      }else{
                        _tabController.animateTo((_tabController.index + 1), duration: Duration(milliseconds: 600));
                      }
                    },
                    child: Text(
                      AppConstants.NEXT,
                      style: getStyleButtonText(context),
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
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// tab : 1 | General Info Tab
  Widget _buildGeneralInfo() {
    return SingleChildScrollView(
      child: Card(
        margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 32.0),
        color: colorWhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12.0))),
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
              children: <Widget>[
                _buildCardTitleArea(context, AppConstants.GENERAL_INFO),
                verticalSpace(16),
                _buildProfileImage(),
                verticalSpace(16),

                buildSmallCaption("Created at", context),
                verticalSpace(captionToTextFieldDistance),
                TextFormField(initialValue: "", style: infoCardKeyFieldStyle, decoration: _buildTextFieldOutLineDecoration()),
                verticalSpace(textFieldToCaptionDistance),

                buildSmallCaption("Shop URL", context),
                verticalSpace(captionToTextFieldDistance),
                TextFormField(initialValue: "", style: infoCardKeyFieldStyle, decoration: _buildTextFieldOutLineDecoration()),
                verticalSpace(textFieldToCaptionDistance),

                buildSmallCaption("Status", context),
                verticalSpace(captionToTextFieldDistance),
                TextFormField(initialValue: "", style: infoCardKeyFieldStyle, decoration: _buildTextFieldOutLineDecoration()),
                verticalSpace(textFieldToCaptionDistance),

                buildSmallCaption("Public Name", context),
                verticalSpace(captionToTextFieldDistance),
                TextFormField(initialValue: "", style: infoCardKeyFieldStyle, decoration: _buildTextFieldOutLineDecoration()),
                verticalSpace(textFieldToCaptionDistance),

                buildSmallCaption("Distributor Name", context),
                verticalSpace(captionToTextFieldDistance),
                TextFormField(initialValue: "", style: infoCardKeyFieldStyle, decoration: _buildTextFieldOutLineDecoration()),
                verticalSpace(textFieldToCaptionDistance),

                buildSmallCaption("Distributor Group", context),
                verticalSpace(captionToTextFieldDistance),
                TextFormField(initialValue: "", style: infoCardKeyFieldStyle, decoration: _buildTextFieldOutLineDecoration()),
                verticalSpace(textFieldToCaptionDistance),

                buildSmallCaption("Phone No.", context),
                verticalSpace(captionToTextFieldDistance),
                TextFormField(initialValue: "", style: infoCardKeyFieldStyle, decoration: _buildTextFieldOutLineDecoration()),
                verticalSpace(textFieldToCaptionDistance),

                buildSmallCaption("ALT Phone No.", context),
                verticalSpace(captionToTextFieldDistance),
                TextFormField(initialValue: "", style: infoCardKeyFieldStyle, decoration: _buildTextFieldOutLineDecoration()),
                verticalSpace(textFieldToCaptionDistance),

                buildSmallCaption("Email", context),
                verticalSpace(captionToTextFieldDistance),
                TextFormField(initialValue: "", style: infoCardKeyFieldStyle, decoration: _buildTextFieldOutLineDecoration()),
                verticalSpace(textFieldToCaptionDistance),
              ],
            ),

          decoration: BoxDecoration(color: colorWhite, borderRadius: BorderRadius.all(Radius.circular(12.0))),
        ),
      ),
    );
  }

  /// tab : 2 | Password Tab
  Widget _buildChangePassword() {
    return SingleChildScrollView(
      child: Card(
        margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 32.0),
        color: colorWhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12.0))),
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              _buildCardTitleArea(context, AppConstants.PASSWORD),
              verticalSpace(16),

              buildSmallCaption('Old Password', context),
              verticalSpace(captionToTextFieldDistance),
              TextFormField(initialValue: "", style: infoCardKeyFieldStyle, decoration: _buildTextFieldOutLineDecoration()),
              verticalSpace(textFieldToCaptionDistance),

              buildSmallCaption('New Password', context),
              verticalSpace(captionToTextFieldDistance),
              TextFormField(initialValue: "", style: infoCardKeyFieldStyle, decoration: _buildTextFieldOutLineDecoration()),
              verticalSpace(textFieldToCaptionDistance),

              buildSmallCaption('Confirm New Password', context),
              verticalSpace(captionToTextFieldDistance),
              TextFormField(initialValue: "", style: infoCardKeyFieldStyle, decoration: _buildTextFieldOutLineDecoration()),
              verticalSpace(textFieldToCaptionDistance),

            ],
          ),

          decoration: BoxDecoration(color: colorWhite, borderRadius: BorderRadius.all(Radius.circular(12.0))),
        ),
      ),
    );
  }

  /// tab : 3 | Address Tab
  Widget _buildAddressInfo(){
    return SingleChildScrollView(
      child: Card(
        margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 32.0),
        color: colorWhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12.0))),
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              _buildCardTitleArea(context, 'Address Information'),
              verticalSpace(16),

              buildSmallCaption('Address', context),
              verticalSpace(captionToTextFieldDistance),
              TextFormField(initialValue: "", maxLines: 5,style: infoCardKeyFieldStyle, decoration: _buildTextFieldOutLineDecoration().copyWith(border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),
              ),)),
              verticalSpace(textFieldToCaptionDistance),

              buildSmallCaption('Country', context),
              verticalSpace(captionToTextFieldDistance),
              TextFormField(initialValue: "", style: infoCardKeyFieldStyle, decoration: _buildTextFieldOutLineDecoration()),
              verticalSpace(textFieldToCaptionDistance),

              buildSmallCaption('State', context),
              verticalSpace(captionToTextFieldDistance),
              TextFormField(initialValue: "", style: infoCardKeyFieldStyle, decoration: _buildTextFieldOutLineDecoration()),
              verticalSpace(textFieldToCaptionDistance),

              buildSmallCaption('City', context),
              verticalSpace(captionToTextFieldDistance),
              TextFormField(initialValue: "", style: infoCardKeyFieldStyle, decoration: _buildTextFieldOutLineDecoration()),
              verticalSpace(textFieldToCaptionDistance),

              buildSmallCaption('PO Box #', context),
              verticalSpace(captionToTextFieldDistance),
              TextFormField(initialValue: "", style: infoCardKeyFieldStyle, decoration: _buildTextFieldOutLineDecoration()),
              verticalSpace(textFieldToCaptionDistance),
            ],
          ),

          decoration: BoxDecoration(color: colorWhite, borderRadius: BorderRadius.all(Radius.circular(12.0))),
        ),
      ),
    );
  }

  /// tab : 4 | Warehouse Tab
  Widget _buildWarehouse() {
    return SingleChildScrollView(
      child: Card(
        margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 32.0),
        color: colorWhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12.0))),
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              _buildCardTitleArea(context, 'Warehouse Information'),
              verticalSpace(16),

              buildSmallCaption('Address', context),
              verticalSpace(captionToTextFieldDistance),
              TextFormField(initialValue: "", maxLines: 5,style: infoCardKeyFieldStyle, decoration: _buildTextFieldOutLineDecoration().copyWith(border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),
              ),)),
              verticalSpace(textFieldToCaptionDistance),

              buildSmallCaption('Country', context),
              verticalSpace(captionToTextFieldDistance),
              TextFormField(initialValue: "", style: infoCardKeyFieldStyle, decoration: _buildTextFieldOutLineDecoration()),
              verticalSpace(textFieldToCaptionDistance),

              buildSmallCaption('State', context),
              verticalSpace(captionToTextFieldDistance),
              TextFormField(initialValue: "", style: infoCardKeyFieldStyle, decoration: _buildTextFieldOutLineDecoration()),
              verticalSpace(textFieldToCaptionDistance),

              buildSmallCaption('City', context),
              verticalSpace(captionToTextFieldDistance),
              TextFormField(initialValue: "", style: infoCardKeyFieldStyle, decoration: _buildTextFieldOutLineDecoration()),
              verticalSpace(textFieldToCaptionDistance),

              buildSmallCaption('PO Box #', context),
              verticalSpace(captionToTextFieldDistance),
              TextFormField(initialValue: "", style: infoCardKeyFieldStyle, decoration: _buildTextFieldOutLineDecoration()),
              verticalSpace(textFieldToCaptionDistance),
            ],
          ),

          decoration: BoxDecoration(color: colorWhite, borderRadius: BorderRadius.all(Radius.circular(12.0))),
        ),
      ),
    );
  }

  /// tab : 5 | Bank Info
  Widget _buildBankInfo() {
    return SingleChildScrollView(
      child: Card(
        margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 32.0),
        color: colorWhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12.0))),
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              _buildCardTitleArea(context, 'Bank Info'),
              verticalSpace(16),

              buildSmallCaption('Account Active', context),
              verticalSpace(captionToTextFieldDistance),
              TextFormField(initialValue: "", style: infoCardKeyFieldStyle, decoration: _buildTextFieldOutLineDecoration()),
              verticalSpace(textFieldToCaptionDistance),

              buildSmallCaption('Bank Name', context),
              verticalSpace(captionToTextFieldDistance),
              TextFormField(initialValue: "", style: infoCardKeyFieldStyle, decoration: _buildTextFieldOutLineDecoration()),
              verticalSpace(textFieldToCaptionDistance),

              buildSmallCaption('Bank Branch Name', context),
              verticalSpace(captionToTextFieldDistance),
              TextFormField(initialValue: "", style: infoCardKeyFieldStyle, decoration: _buildTextFieldOutLineDecoration()),
              verticalSpace(textFieldToCaptionDistance),

              buildSmallCaption('Bank Swift Code', context),
              verticalSpace(captionToTextFieldDistance),
              TextFormField(initialValue: "", style: infoCardKeyFieldStyle, decoration: _buildTextFieldOutLineDecoration()),
              verticalSpace(textFieldToCaptionDistance),

              buildSmallCaption('Bank Account Name', context),
              verticalSpace(captionToTextFieldDistance),
              TextFormField(initialValue: "", style: infoCardKeyFieldStyle, decoration: _buildTextFieldOutLineDecoration()),
              verticalSpace(textFieldToCaptionDistance),

              buildSmallCaption('Bank Account Number', context),
              verticalSpace(captionToTextFieldDistance),
              TextFormField(initialValue: "", style: infoCardKeyFieldStyle, decoration: _buildTextFieldOutLineDecoration()),
              verticalSpace(textFieldToCaptionDistance),
              verticalSpace(textFieldToCaptionDistance),
            ],
          ),

          decoration: BoxDecoration(color: colorWhite, borderRadius: BorderRadius.all(Radius.circular(12.0))),
        ),
      ),
    );
  }

  /// tab : 6 | Company Info
  Widget _buildCompanyInfo() {
    return SingleChildScrollView(
      child: Card(
        margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 32.0),
        color: colorWhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12.0))),
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              _buildCardTitleArea(context, 'Company Info'),
              verticalSpace(16),

              buildSmallCaption('Company Name', context),
              verticalSpace(captionToTextFieldDistance),
              TextFormField(initialValue: "", style: infoCardKeyFieldStyle, decoration: _buildTextFieldOutLineDecoration()),
              verticalSpace(textFieldToCaptionDistance),

              buildSmallCaption('TRN #', context),
              verticalSpace(captionToTextFieldDistance),
              TextFormField(initialValue: "", style: infoCardKeyFieldStyle, decoration: _buildTextFieldOutLineDecoration()),
              verticalSpace(textFieldToCaptionDistance),

              buildSmallCaption('Company Description', context),
              verticalSpace(captionToTextFieldDistance),
              TextFormField(initialValue: "", maxLines: 5,style: infoCardKeyFieldStyle, decoration: _buildTextFieldOutLineDecoration().copyWith(border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),
              ),)),
              verticalSpace(textFieldToCaptionDistance),

              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        buildSmallCaption('Company Logo', context),
                        verticalSpace(captionToTextFieldDistance),
                        Stack(
                          children: <Widget>[
                            CachedNetworkImage(
                              imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQN6K1Nfp6CdQ9kr3d-oFrL5jmzqcuzTkE-4KqMTs6Q0Hp8BKFx',  //'http://i.imgur.com/QSev0hg.jpg',
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                    height: 100.0,
                                    margin: EdgeInsets.only(bottom: 20),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.all(Radius.circular(cardRadius)),
                                      image: DecorationImage(
                                          alignment: Alignment.center,
                                          image: imageProvider, fit: BoxFit.cover),
                                      //borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                      border: Border.all(
                                        color: colorDarkGrey,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                              //placeholder: (context, url) => CircularProgressIndicator(),
                              placeholder: (context, url) =>  _buildPlaceHolder(context),
                              //CircularProgressIndicator(strokeWidth: 4.0, backgroundColor: colorGMailRed, ),
                              errorWidget: (context, url, error) => _buildPlaceHolder(context),
                            ),
                            Positioned(
                                top: 85.0,
                                left: 60.0,
                                height: 30.0,
                                width: 30.0,
                                child: Container(
                                    padding: EdgeInsets.all(3.0),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20.0),
                                      border: Border.all(
                                          color: colorDarkGrey,
                                          width: 1.0,
                                        )
                                    ),
                                    child: Padding(
                                        padding: EdgeInsets.all(3.0),
                                        child: Icon(
                                          Icons.camera_enhance,
                                          color: colorPrimary,
                                          size: 16.0,
                                        )
                                    )
                                )
                            ),
                          ],
                        ),
                      ],
                    )),
                  SizedBox(width: 8.0,),
                  Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          buildSmallCaption('Company Banner', context),
                          verticalSpace(captionToTextFieldDistance),
                          Stack(
                            children: <Widget>[
                              CachedNetworkImage(
                                imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQN6K1Nfp6CdQ9kr3d-oFrL5jmzqcuzTkE-4KqMTs6Q0Hp8BKFx',  //'http://i.imgur.com/QSev0hg.jpg',
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                      height: 100.0,
                                      margin: EdgeInsets.only(bottom: 20),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.all(Radius.circular(cardRadius)),
                                        image: DecorationImage(
                                            alignment: Alignment.center,
                                            image: imageProvider, fit: BoxFit.cover),
                                        //borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                        border: Border.all(
                                          color: colorDarkGrey,
                                          width: 1.0,
                                        ),
                                      ),
                                    ),
                                //placeholder: (context, url) => CircularProgressIndicator(),
                                placeholder: (context, url) =>  _buildPlaceHolder(context),
                                //CircularProgressIndicator(strokeWidth: 4.0, backgroundColor: colorGMailRed, ),
                                errorWidget: (context, url, error) => _buildPlaceHolder(context),
                              ),
                              Positioned(
                                  top: 85.0,
                                  left: 60.0,
                                  height: 30.0,
                                  width: 30.0,
                                  child: Container(
                                      padding: EdgeInsets.all(3.0),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20.0),
                                        border: Border.all(
                                          color: colorDarkGrey,
                                          width: 1.0,
                                        )
                                      ),
                                      child: Padding(
                                          padding: EdgeInsets.all(3.0),
                                          child: Icon(
                                            Icons.camera_enhance,
                                            color: colorPrimary,
                                            size: 16.0,
                                          )
                                      )
                                  )
                              ),
                            ],
                          ),
                        ],
                      ))
                ],
              ),

              verticalSpace(textFieldToCaptionDistance),
              verticalSpace(textFieldToCaptionDistance),

            ],
          ),

          decoration: BoxDecoration(color: colorWhite, borderRadius: BorderRadius.all(Radius.circular(12.0))),
        ),
      ),
    );
  }

  /// tab : 7 | Social Media Info
  Widget _buildSocialMediaInfo() {
    return SingleChildScrollView(
      child: Card(
        margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 32.0),
        color: colorWhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12.0))),
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              _buildCardTitleArea(context, 'Social Media Info'),
              verticalSpace(16),

              buildSmallCaption('Twitter Page URL ', context),
              verticalSpace(captionToTextFieldDistance),
              TextFormField(initialValue: "", style: infoCardKeyFieldStyle, decoration: _buildTextFieldOutLineDecoration()),
              verticalSpace(textFieldToCaptionDistance),

              buildSmallCaption('Facebook Page URL ', context),
              verticalSpace(captionToTextFieldDistance),
              TextFormField(initialValue: "", style: infoCardKeyFieldStyle, decoration: _buildTextFieldOutLineDecoration()),
              verticalSpace(textFieldToCaptionDistance),

              buildSmallCaption('Linkedin Page URL', context),
              verticalSpace(captionToTextFieldDistance),
              TextFormField(initialValue: "", style: infoCardKeyFieldStyle, decoration: _buildTextFieldOutLineDecoration()),
              verticalSpace(textFieldToCaptionDistance),

              buildSmallCaption('Google Plus Page URL', context),
              verticalSpace(captionToTextFieldDistance),
              TextFormField(initialValue: "", style: infoCardKeyFieldStyle, decoration: _buildTextFieldOutLineDecoration()),
              verticalSpace(textFieldToCaptionDistance),
              verticalSpace(textFieldToCaptionDistance),

            ],
          ),

          decoration: BoxDecoration(color: colorWhite, borderRadius: BorderRadius.all(Radius.circular(12.0))),
        ),
      ),
    );
  }

  /// tab : 8 | SEO Management
  Widget _buildSeoManagement() {
    return SingleChildScrollView(
      child: Card(
        margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 32.0),
        color: colorWhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12.0))),
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              _buildCardTitleArea(context, 'SEO Management'),
              verticalSpace(16),

              buildSmallCaption('Meta Keywords', context),
              verticalSpace(captionToTextFieldDistance),
              TextFormField(initialValue: "", maxLines: 5,style: infoCardKeyFieldStyle, decoration: _buildTextFieldOutLineDecoration().copyWith(border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),
              ),)),
              verticalSpace(textFieldToCaptionDistance),

              buildSmallCaption('Meta Description', context),
              verticalSpace(captionToTextFieldDistance),
              TextFormField(initialValue: "", maxLines: 5,style: infoCardKeyFieldStyle, decoration: _buildTextFieldOutLineDecoration().copyWith(border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),
              ),)),
              verticalSpace(textFieldToCaptionDistance),
              verticalSpace(textFieldToCaptionDistance),

            ],
          ),

          decoration: BoxDecoration(color: colorWhite, borderRadius: BorderRadius.all(Radius.circular(12.0))),
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
          TextSpan(text: labelName, style: getStyleCaption(context).copyWith(fontWeight: AppFont.fontWeightSemiBold)),
          TextSpan(text: ' *', style: getStyleSubTitle(context).copyWith(color: colorPrimary))
        ]),
      ),
    );
  }



  InputDecoration _buildTextFieldOutLineDecoration(){
    return  InputDecoration(
      contentPadding: const EdgeInsets.all(16.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
    );
  }

  InputDecoration _buildTextDecoration() {
    return InputDecoration(
        isDense: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24), borderSide: BorderSide(width: 0, style: BorderStyle.none)),
        filled: true,
        fillColor: colorWhite,
        contentPadding: EdgeInsets.all(16));
  }

  Widget _buildCardTitleArea(BuildContext context, String cardTitle) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
                child: Text(
                  cardTitle,
                  style: subTitleStyle,
                  overflow: TextOverflow.ellipsis,
                )
            ),
          ],
        ),
        verticalSpace(16.0),
        Divider(
          height: 1.0,
          color: colorDarkGrey,
        ),
        verticalSpace(16.0)
      ],
    );
  }

  Widget _buildDetailCardRowItem(String labelName, String value) {
    return Container(
      padding: EdgeInsets.only(top: 16.0),
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
                    value,
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

  Column _buildProfileImage() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 15.0,
        ),
        Stack(
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQN6K1Nfp6CdQ9kr3d-oFrL5jmzqcuzTkE-4KqMTs6Q0Hp8BKFx',  //'http://i.imgur.com/QSev0hg.jpg',
              imageBuilder: (context, imageProvider) =>
                  Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          alignment: Alignment.center,
                          image: imageProvider, fit: BoxFit.cover),
                      //borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      border: Border.all(
                        color: colorPrimary,
                        width: 3.0,
                      ),
                    ),
                  ),
              //placeholder: (context, url) => CircularProgressIndicator(),
              placeholder: (context, url) =>  _buildPlaceHolder(context),
              //CircularProgressIndicator(strokeWidth: 4.0, backgroundColor: colorGMailRed, ),
              errorWidget: (context, url, error) => _buildPlaceHolder(context),
            ),
            Positioned(
                top: 70.0,
                left: 65.0,
                height: 30.0,
                width: 30.0,
                child: Container(
                    padding: EdgeInsets.all(3.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                        padding: EdgeInsets.all(3.0),
                        child: Icon(
                          Icons.camera_enhance,
                          color: colorPrimary,
                          size: 16.0,
                        )
                    )
                )
            ),
          ],
        ),
        SizedBox(
          height: 0.0,
        ),
      ],
    );
  }

  Row buildSmallCaption(String caption, BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          caption,
          style: getStyleCaption(context).copyWith(color: Colors.black87),
        ),
      ],
    );
  }

  Container _buildPlaceHolder(BuildContext context) {

    return Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(alignment: Alignment.center, image: AssetImage(AppImages.IMAGE_PROFILE_IMAGE_PLACE_HOLDER), fit: BoxFit.cover),
        //borderRadius: BorderRadius.all(Radius.circular(50.0)),
        border: Border.all(
          color: colorPrimary,
          width: 3.0,
        ),
      ),
    );
  }
}
