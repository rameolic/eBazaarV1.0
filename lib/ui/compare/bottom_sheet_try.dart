import 'package:flutter/material.dart';
import 'package:thought_factory/utils/app_colors.dart';
import 'package:thought_factory/utils/app_font.dart';
import 'package:thought_factory/utils/app_screen_dimen.dart';
import 'package:thought_factory/utils/app_text_style.dart';
import 'package:thought_factory/utils/widgetHelper/custom_modal_bottom_sheet.dart';

class BottomSheetTryScreen extends StatefulWidget {
  static const routeName = '/bottom_sheet_try';

  @override
  _BottomSheetTryScreenState createState() => _BottomSheetTryScreenState();
}

class _BottomSheetTryScreenState extends State<BottomSheetTryScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = getScreenWidth(context);
    double screenHeight = getScreenHeight(context);

    return Scaffold(
        appBar: AppBar(backgroundColor: colorPrimary, elevation: 0),
        //key: _scaffoldKey,
        body: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: double.infinity,
          color: colorDarkGrey,
          child: FlatButton(
            onPressed: () {
              showModalBottomSheetType(context, screenHeight);
              //showPersistentBottomSheetType(context, screenHeight);
            },
            child: Text('Check to view bottom sheet'),
            splashColor: colorPrimary,
            color: colorPrimary,
          ),
        ));
  }

  void showPersistentBottomSheetType(context, screenHeight) {
    _scaffoldKey.currentState.showBottomSheet<Null>((BuildContext context) {
      return Container(
        height: 400,
        color: Colors.transparent,
        child: Card(
          color: Colors.transparent,
          child: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(top: 48),
                  child: new Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new ListTile(
                        leading: new Icon(Icons.music_note),
                        title: new Text('Music'),
                        onTap: () => {},
                      ),
                      new ListTile(
                        leading: new Icon(Icons.photo_album),
                        title: new Text('Photos'),
                        onTap: () => {},
                      ),
                      new ListTile(
                        leading: new Icon(Icons.videocam),
                        title: new Text('Video'),
                        onTap: () => {},
                      ),
                      new ListTile(
                        leading: new Icon(Icons.videocam),
                        title: new Text('Video'),
                        onTap: () => {},
                      ),
                      new ListTile(
                        leading: new Icon(Icons.videocam),
                        title: new Text('Video'),
                        onTap: () => {},
                      ),
                      new ListTile(
                        leading: new Icon(Icons.videocam),
                        title: new Text('Video'),
                        onTap: () => {},
                      ),
                      new ListTile(
                        leading: new Icon(Icons.videocam),
                        title: new Text('Video'),
                        onTap: () => {},
                      ),
                      new ListTile(
                        leading: new Icon(Icons.videocam),
                        title: new Text('Video'),
                        onTap: () => {},
                      ),
                      new ListTile(
                        leading: new Icon(Icons.videocam),
                        title: new Text('Video'),
                        onTap: () => {},
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 16.0, right: 16.0),
                color: colorPrimary,
                width: double.infinity,
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      'Choose Product',
                      style: getStyleBody1(context).copyWith(color: colorWhite, fontWeight: AppFont.fontWeightSemiBold),
                    )),
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.clear,
                          color: colorWhite,
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  void showModalBottomSheetType(context, screenHeight) {
    showCustomModalBottomSheet<void>(
        context: context,
        theme: new ThemeData(
          canvasColor: Colors.transparent,
        ),
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
              child: Container(
                color: colorWhite,
                height: screenHeight / 1.2,
                child: Stack(
                  children: <Widget>[
                    SingleChildScrollView(
                      child: Container(
                        margin: EdgeInsets.only(top: 48),
                        child: new Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            new ListTile(
                              leading: new Icon(Icons.music_note),
                              title: new Text('Music'),
                              onTap: () => {},
                            ),
                            new ListTile(
                              leading: new Icon(Icons.photo_album),
                              title: new Text('Photos'),
                              onTap: () => {},
                            ),
                            new ListTile(
                              leading: new Icon(Icons.videocam),
                              title: new Text('Video'),
                              onTap: () => {},
                            ),
                            new ListTile(
                              leading: new Icon(Icons.videocam),
                              title: new Text('Video'),
                              onTap: () => {},
                            ),
                            new ListTile(
                              leading: new Icon(Icons.videocam),
                              title: new Text('Video'),
                              onTap: () => {},
                            ),
                            new ListTile(
                              leading: new Icon(Icons.videocam),
                              title: new Text('Video'),
                              onTap: () => {},
                            ),
                            new ListTile(
                              leading: new Icon(Icons.videocam),
                              title: new Text('Video'),
                              onTap: () => {},
                            ),
                            new ListTile(
                              leading: new Icon(Icons.videocam),
                              title: new Text('Video'),
                              onTap: () => {},
                            ),
                            new ListTile(
                              leading: new Icon(Icons.videocam),
                              title: new Text('Video'),
                              onTap: () => {},
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(16.0),
                      color: colorPrimary,
                      width: double.infinity,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: Text(
                            'Similar Products',
                            style: getStyleSubHeading(context)
                                .copyWith(color: colorWhite, fontWeight: AppFont.fontWeightBold),
                          )),
                          Icon(
                            Icons.clear,
                            color: colorWhite,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
