import 'package:thought_factory/utils/app_constants.dart';

import 'item.dart';

class ItemHeader extends Item {
  @override
  int getViewType() {
    return AppConstants.APP_DRAWER_TYPE_HEADER;
  }
}
