import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:thought_factory/core/model/category_model.dart';
import 'package:thought_factory/utils/app_colors.dart';
import 'package:thought_factory/utils/app_screen_dimen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        _buildSliverSearchBar(),
        _buildTitle('Category'),
        _buildSliverCategoryList(),
        _buildSliverPopularProducts(context),
        _buildTitle('Top Distributors'),
        _buildSliverTopDistributorsList(context),
        _buildSliverClothing(context),
        _buildSliverElectronics(context),
        _buildSliverHealthAndBeauty(context),
      ],
    );
  }

  //Appbar: with "search" & "filter"
  Widget _buildSliverSearchBar() {
    return SliverAppBar(
      leading: Icon(null),
      backgroundColor: colorPrimary,
      elevation: 10.0,
      forceElevated: true,
      pinned: true,
      flexibleSpace: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: 8.0),
                    alignment: Alignment.center,
                    height: 38.0,
                    padding: EdgeInsets.only(left: 16.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40.0)),
                    child: TextFormField(
                      style: TextStyle(fontSize: 15.0),
                      decoration: InputDecoration(
                        hintText: "Search products",
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          onPressed: () {},
                          color: colorBlack,
                          icon: Icon(Icons.search),
                          iconSize: 20,
                        ),
                      ),
                    ),
                  ),
                  flex: 1,
                ),
                RawMaterialButton(
                  splashColor: colorPrimary,
                  constraints: BoxConstraints(maxWidth: 38.0),
                  onPressed: () {},
                  child: Icon(
                    Icons.clear_all,
                    color: colorBlack,
                    size: 24.0,
                  ),
                  shape: CircleBorder(),
                  fillColor: colorWhite,
                  padding: EdgeInsets.all(7.0),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  //get title for the list
  Widget _buildTitle(String title) {
    return SliverToBoxAdapter(
      child: Container(
        color: colorGrey,
        child: Padding(
          padding: EdgeInsets.only(top: 8.0, left: 16.0),
          child: Align(alignment: Alignment.centerLeft, child: Text(title)),
        ),
      ),
    );
  }

  //get "category" list
  Widget _buildSliverCategoryList() {
    return SliverToBoxAdapter(
      child: Container(
        color: colorGrey,
        height: 100,
        child: ListView(
          padding: EdgeInsets.only(right: 16.0),
          scrollDirection: Axis.horizontal,
          children: _listCategoryModel.map((itemCategory) {
            return _buildListTileCategory(itemCategory);
          }).toList(),
        ),
      ),
    );
  }

  //get "category" listTile
  Widget _buildListTileCategory(CategoryModel itemCategory) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
      child: Container(
          alignment: Alignment.center,
          width: 55,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: colorPrimary,
              onTap: () {
                print('clicked: category ${itemCategory.name}');
              },
              child: Column(
                children: <Widget>[
                  Card(
                    elevation: 8.0,
                    color: colorPrimary,
                    child: Container(
                      width: 55,
                      height: 55,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: AutoSizeText(
                      itemCategory.name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 10.0),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }

  //get "popular products" two item
  Widget _buildSliverPopularProducts(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.all(16.0),
        color: colorWhite,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: <Widget>[
                  Expanded(child: Text('Popular Products')),
                  Text(
                    'View all',
                    style: TextStyle(color: colorPrimary),
                  ),
                ],
              ),
            ), //text: "Popular Products" title
            Row(
              children: <Widget>[getItem(context), getItem(context)],
            )
          ],
        ),
      ),
    );
  }

  Widget getItem(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 4.0,
        color: colorGrey,
        child: Container(
          child: Column(
            children: <Widget>[
              Card(
                elevation: 0.0,
                color: colorWhite,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    width: (getScreenWidth(context) / 2) - 24,
                    height: (getScreenWidth(context) / 2) - 24,
                    child: Stack(
                      children: <Widget>[
                        Align(
                          child: Icon(
                            Icons.favorite,
                            color: colorPrimary,
                          ),
                          alignment: Alignment.topRight,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 8.0),
                child: Align(
                  child: Text(
                    'Default watch',
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                  alignment: Alignment.centerLeft,
                ),
              ), //text: product name
              Padding(
                padding:
                    const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 8.0),
                child: Align(
                  child: Text(
                    "\$25.75",
                    style: TextStyle(
                      color: colorPrimary,
                    ),
                  ),
                  alignment: Alignment.centerLeft,
                ),
              ), //text: product price in dollar
              Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RawMaterialButton(
                        onPressed: () {},
                        child: Icon(
                          Icons.remove,
                          color: colorPrimary,
                          size: 16.0,
                        ),
                        shape: CircleBorder(),
                        elevation: 2.0,
                        fillColor: colorWhite,
                        padding: EdgeInsets.all(6.0),
                        splashColor: colorPrimary,
                      ),
                    ), //button: decrease product count
                    Expanded(
                      flex: 2,
                      child: Container(
                        margin: EdgeInsets.only(left: 8.0, right: 8.0),
                        child: AbsorbPointer(
                          //to avoid touch on the button with not like disable effect
                          absorbing: true,
                          child: RaisedButton(
                            color: colorWhite,
                            textColor: colorPrimary,
                            elevation: 1.0,
                            padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                            child: Text(
                              '0',
                              style: TextStyle(fontSize: 16.0),
                            ),
                            onPressed: () {},
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0)),
                          ),
                        ),
                      ),
                    ), //text: product count
                    Expanded(
                      child: RawMaterialButton(
                          onPressed: () {},
                          child: Icon(
                            Icons.add,
                            color: colorPrimary,
                            size: 16.0,
                          ),
                          shape: CircleBorder(),
                          elevation: 2.0,
                          fillColor: colorWhite,
                          padding: EdgeInsets.all(6.0),
                          splashColor: colorPrimary),
                    ) //button: increase product count
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //get "top distributors" list
  Widget _buildSliverTopDistributorsList(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        color: colorGrey,
        height: 100,
        child: ListView(
          padding: EdgeInsets.only(left: 16.0, right: 16.0),
          scrollDirection: Axis.horizontal,
          children: _listCategoryModel.map((itemCategory) {
            return _buildListTileTopDistributors(context);
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildListTileTopDistributors(BuildContext context) {
    var width = (getScreenWidth(context) / 4);
    var height = (getScreenWidth(context) / 6);
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Container(
          alignment: Alignment.center,
          width: width,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: colorPrimary,
              onTap: () {},
              child: Card(
                elevation: 8.0,
                color: colorPrimary,
                child: Container(
                  width: width,
                  height: height,
                ),
              ),
            ),
          )),
    );
  }

  //get "clothing" two item
  Widget _buildSliverClothing(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.all(16.0),
        color: colorWhite,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: <Widget>[
                  Expanded(child: Text('Clothing')),
                  Text(
                    'View all',
                    style: TextStyle(color: colorPrimary),
                  ),
                ],
              ),
            ), //text: "Popular Products" title
            Row(
              children: <Widget>[getItem(context), getItem(context)],
            )
          ],
        ),
      ),
    );
  }

  //get "clothing" two item
  Widget _buildSliverElectronics(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.all(16.0),
        color: colorWhite,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: <Widget>[
                  Expanded(child: Text('Electronics')),
                  Text(
                    'View all',
                    style: TextStyle(color: colorPrimary),
                  ),
                ],
              ),
            ), //text: "Popular Products" title
            Row(
              children: <Widget>[getItem(context), getItem(context)],
            )
          ],
        ),
      ),
    );
  }

  //get "clothing" two item
  Widget _buildSliverHealthAndBeauty(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.all(16.0),
        color: colorWhite,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: <Widget>[
                  Expanded(child: Text('HealthAndBeauty')),
                  Text(
                    'View all',
                    style: TextStyle(color: colorPrimary),
                  ),
                ],
              ),
            ), //text: "Popular Products" title
            Row(
              children: <Widget>[getItem(context), getItem(context)],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDummySliverList() {
    return SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
      return ListTile(
        title: Text('List item $index'),
      );
    }, childCount: 15));
  }

  final List<CategoryModel> _listCategoryModel = [
    CategoryModel(
        id: 0,
        name: 'Clothing',
        imageUrl: '',
        description: 'sampledescription'),
    CategoryModel(
        id: 1,
        name: 'Electronics',
        imageUrl: '',
        description: 'sampledescription'),
    CategoryModel(
        id: 2, name: 'Watches', imageUrl: '', description: 'sampledescription'),
    CategoryModel(
        id: 3, name: 'Beauty', imageUrl: '', description: 'sampledescription'),
    CategoryModel(
        id: 4, name: 'Shoes', imageUrl: '', description: 'sampledescription'),
    CategoryModel(
        id: 5,
        name: 'Furnitures',
        imageUrl: '',
        description: 'sampledescription'),
    CategoryModel(
        id: 6, name: 'Grocery', imageUrl: '', description: 'sampledescription'),
  ];
}
