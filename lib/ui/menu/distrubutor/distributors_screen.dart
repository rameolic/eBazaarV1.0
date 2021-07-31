import 'package:flutter/material.dart';
import 'package:thought_factory/core/model/helper/info_home_tap.dart';
import 'package:thought_factory/ui/product/product_list_screen.dart';
import 'package:thought_factory/utils/app_colors.dart';
import 'package:thought_factory/utils/app_screen_dimen.dart';
import 'package:thought_factory/utils/app_text_style.dart';
import 'package:thought_factory/utils/dummy/dummy_products_list.dart';

class DistributorsScreen extends StatefulWidget {
  @override
  _DistributorsScreenState createState() => _DistributorsScreenState();
}

class _DistributorsScreenState extends State<DistributorsScreen> {
  List<String> listDummyData = getListDummyDistributor();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        //_buildSearchBar(context),
        Container(
            color: colorGrey,
            margin: EdgeInsets.only(top: 65),
            child: GridView.builder(
              padding: EdgeInsets.all(16.0),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 4 / 3),
              itemBuilder: (BuildContext context, int index) {
                return _buildGridTileDistributors(index);
              },
              itemCount: listDummyData.length,
            ))
      ],
    );
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
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(40.0)),
          child: TextFormField(
            style: getStyleCaption(context).copyWith(fontStyle: FontStyle.italic),
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

  Widget _buildGridTileDistributors(index) {
    var width = (getScreenWidth(context) / 3);
    var height = (getScreenWidth(context) / 4.5);
    return Container(
        margin: EdgeInsets.only(top: 4.0, left: 2.0, right: 2.0),
        padding: const EdgeInsets.only(top: 4.0, bottom: 0.0),
        alignment: Alignment.center,
        width: width,
        height: height,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: colorPrimary,
            onTap: () {
              onClickDistributorItem('Brand Name');
            },
            child: Card(
              elevation: 0.0,
              color: colorWhite,
              child: Container(
                width: width,
                height: height,
                child: Image.asset(listDummyData[index]),
              ),
            ),
          ),
        ));
  }

  onClickDistributorItem(String stBrandName) {
    //navigate to products screen
    Navigator.pushNamed(context, ProductListScreen.routeName,
        arguments: InfoHomeTap(id: 0, toolBarName: stBrandName));
  }
}
