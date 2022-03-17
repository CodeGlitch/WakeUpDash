import 'package:flutter/material.dart';
import '../utils/configs.dart';
import '/utils/colors.dart';

//simple
class ThisAppBar extends AppBar {
  ThisAppBar(context)
      : super(
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
/*
//for more configurations
class ThisAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ThisAppBar({Key? key})
      : preferredSize = const Size.fromHeight(60.0),
        super(key: key); //

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
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
}*/
