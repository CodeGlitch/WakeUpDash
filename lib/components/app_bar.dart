import 'package:flutter/material.dart';
import '../utils/configs.dart';
import '/utils/colors.dart';

class ThisAppBar {
  static AppBar appBar(context) {
    return AppBar(
      backgroundColor: ThisAppColors.bgColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            appName,
            style: Theme.of(context).textTheme.headline6,
          ),
        ],
      ),
    );
  }
}
