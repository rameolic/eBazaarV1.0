import 'package:flutter/material.dart';
import 'package:thought_factory/utils/app_constants.dart';

import 'item.dart';

class ItemContent extends Item {
  IconData iconData;
  String name;
  String id;
  String imageIconPath;

  ItemContent({this.iconData, this.name, this.id, this.imageIconPath});

  @override
  int getViewType() {
    return AppConstants.APP_DRAWER_TYPE_ITEM;
  }

  @override
  String toString() {
    return 'ItemContent{iconData: $iconData, name: $name, id: $id, imageIconPath: $imageIconPath}';
  }


}
