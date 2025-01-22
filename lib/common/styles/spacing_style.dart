import 'package:ban_x/utils/constants/banx_sizes.dart';
import 'package:flutter/cupertino.dart';

class BanXSpacingStyle {
  static const EdgeInsetsGeometry paddingWithAppBarHeight = EdgeInsets.only(
    top: BanXSizes.appBarHeight,
    left: BanXSizes.defaultSpace,
    right: BanXSizes.defaultSpace,
    bottom: BanXSizes.defaultSpace
  );
}