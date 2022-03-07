import 'package:flutter/material.dart';

import '../utils/configs.dart';

class CpTextInput extends StatefulWidget {
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final String? hintText;
  final String? labelText;
  final Widget? icon;
  final TextInputType keyboardInputType;
  const CpTextInput(
      {Key? key,
      required this.controller,
      required this.validator,
      required this.keyboardInputType,
      this.hintText,
      this.labelText,
      this.icon})
      : super(key: key);

  @override
  _CpTextInputState createState() => _CpTextInputState();
}

class _CpTextInputState extends State<CpTextInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        inputPaddingL,
        inputPaddingT,
        inputPaddingR,
        inputPaddingB,
      ),
      child: TextFormField(
        keyboardType: widget.keyboardInputType,
        controller: widget.controller,
        validator: widget.validator,
        decoration: InputDecoration(
          icon: widget.icon,
          hintText: widget.hintText,
          hintStyle: Theme.of(context).textTheme.bodyLarge,
          labelText: widget.labelText,
          labelStyle: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
