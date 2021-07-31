import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:thought_factory/core/data/remote/network/app_url.dart';
import 'package:thought_factory/core/data/remote/request_response/distributor/all_distributor_response.dart';
import 'package:thought_factory/core/model/helper/info_home_tap.dart';
import 'package:thought_factory/core/notifier/distributor_notifier_all.dart';
import 'package:thought_factory/core/notifier/home_notifier.dart';
import 'package:thought_factory/router.dart';
import 'package:thought_factory/ui/product/product_list_screen.dart';
import 'package:thought_factory/utils/app_colors.dart';
import 'package:thought_factory/utils/app_constants.dart';
import 'package:thought_factory/utils/app_network_check.dart';
import 'package:thought_factory/utils/app_screen_dimen.dart';
import 'package:thought_factory/utils/app_text_style.dart';

import '../../../router.dart';

class DistributorsScreen extends StatefulWidget {
  @override
  _DistributorsScreenState createState() => _DistributorsScreenState();
}

class _DistributorsScreenState extends State<DistributorsScreen> {
  //List<String> listDummyData = getListDummyDistributor();
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DistributorNotifierAll>(
      create: (context) => DistributorNotifierAll(context),
      child: Consumer<DistributorNotifierAll>(
        builder: (context, distributorNotifier, _) => ModalProgressHUD(
          inAsyncCall: distributorNotifier.isLoading,
          child: Stack(
            children: <Widget>[
              //_buildSearchBar(context),
              Container(
                color: colorYoutubeGrey,
                child: (isDistributorDataAvailable(distributorNotifier)
                    ? GridView.builder(
                        padding: EdgeInsets.only(
                            left: 16, right: 16, bottom: 16, top: 8),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, childAspectRatio: 4 / 3),
                        itemBuilder: (BuildContext context, int index) {
                          return _buildGridTileDistributors(
                              index, distributorNotifier, context);
                        },
                        itemCount: distributorNotifier
                            .allDistributorResponse.data.length,
                      )
                    : Container(
                        child: Center(
                          child: Text("No Data"),
                        ),
                      )),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool isDistributorDataAvailable(
      DistributorNotifierAll distributorNotifierAll) {
    if ((distributorNotifierAll != null) &&
        (distributorNotifierAll.allDistributorResponse != null) &&
        (distributorNotifierAll.allDistributorResponse.data != null) &&
        (distributorNotifierAll.allDistributorResponse.data.length > 0)) {
      return true;
    } else {
      return false;
    }
  }

  //Appbar: with "search" & "filter"
  Widget _buildSearchBar(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Container(
          color: colorPrimary,
          height: 70,
        ),
        Container(
          margin: EdgeInsets.only(right: 16.0, left: 16.0),
          alignment: Alignment.topCenter,
          height: 42.0,
          padding: EdgeInsets.only(left: 16.0),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(40.0)),
          child: TextFormField(
            style:
                getStyleCaption(context).copyWith(fontStyle: FontStyle.italic),
            decoration: InputDecoration(
              hintText: "Search products",
              alignLabelWithHint: true,
              border: InputBorder.none,
              suffixIcon: IconButton(
                onPressed: () {},
                color: colorBlack,
                icon: Icon(Icons.search),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildGridTileDistributors(
      index, DistributorNotifierAll distributorNotifier, BuildContext context) {
    var width = (getScreenWidth(context) / 3);
    var height = (getScreenWidth(context) / 4.5);
    return Container(
        margin: EdgeInsets.only(top: 4.0, left: 2.0, right: 2.0),
        padding: const EdgeInsets.only(top: 4.0, bottom: 0.0),
        alignment: Alignment.center,
        width: width,
        height: height,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(color: colorGrey, blurRadius: 1, spreadRadius: 1)
        ]),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: colorPrimary,
            onTap: () {
              onClickDistributorItem('Brand Name', context,
                  distributorNotifier.allDistributorResponse.data[index]);
            },
            child: Card(
              elevation: 0.0,
              color: colorWhite,
              child: Container(
                width: width,
                height: height,
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: (distributorNotifier.allDistributorResponse.data[index]
                              .companyLogoUrl !=
                          "")
                      ? Image.network(AppUrl.distImageUrl1 +
                          distributorNotifier.allDistributorResponse.data[index]
                              .companyLogoUrl)
                      : Image.asset("assets/logo_thought_factory.png"),
                )),
              ),
            ),
          ),
        ));
  }

  onClickDistributorItem(
    String stBrandName,
    BuildContext context,
    Data data,
  ) {
    _onClickViewAllProducts(
        context,
        InfoHomeTap(
            id: int.parse(data.sellerId),
            toolBarName: data.distributorName,
            type: AppConstants.FIELD_SELLER_ID));
  }

  void _onClickViewAllProducts(
      BuildContext context, InfoHomeTap infoHomeTap) async {
    log.i('onClickViewAllProducts, params category Id: ${infoHomeTap.id}');

    bool isNetworkAvail = await NetworkCheck().check();
    if (isNetworkAvail) {
      Navigator.pushNamed(context, ProductListScreen.routeName,
          arguments: infoHomeTap);
    } else {
      Provider.of<HomeNotifier>(context).showSnackBarMessageWithContext(
          AppConstants.ERROR_INTERNET_CONNECTION);
    }
  }
}
