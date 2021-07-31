import 'package:flutter/foundation.dart';

class InfoHomeTap {
  int _id;
  String _toolBarName;
  String _type;

  InfoHomeTap({@required int id, String toolBarName, String type}) {
    this._id = id;
    this._toolBarName = toolBarName;
    this._type = type;
  }

  int get id => _id;

  set id(int value) => _id = value;

  String get toolBarName => _toolBarName;

  set toolBarName(String value) => _toolBarName = value;

  String get type => _type;

  set type(String value) => _type = value;

  @override
  String toString() {
    return 'InfoHomeTap{_id: $_id, _toolBarName: $_toolBarName, _type: $_type}';
  }


}
