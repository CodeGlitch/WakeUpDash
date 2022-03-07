import 'package:flutter/material.dart';

import '../utils/configs.dart';

class ButtonPadding extends StatelessWidget {
  final Widget content;
  const ButtonPadding({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: buttonVerticaPadding,
      ),
      child: content,
    );
  }
}
