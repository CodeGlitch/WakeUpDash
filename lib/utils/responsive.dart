import 'package:flutter/widgets.dart';

import 'configs.dart';

class Responsive {
  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < smallScreen;
  }

  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > largeScreen;
  }

  static bool isMediumScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > smallScreen &&
        MediaQuery.of(context).size.width < largeScreen;
  }

  static double currentScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
}
