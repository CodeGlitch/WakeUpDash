import 'package:flutter/material.dart';

import '../utils/configs.dart';

class MainBody extends StatelessWidget {
  final Widget content;
  const MainBody({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        heightFactor: 1,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: largeScreen,
          ),
          child: content,
        ),
      ),
    );
  }
}
