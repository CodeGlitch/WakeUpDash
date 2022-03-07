import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/configs.dart';

class CpDropDownButton extends StatefulWidget {
  final TextEditingController controller;
  final List<DropdownMenuItem<String>> items;
  final Function onChanged;
  final Widget? icon;
  final String? hintText;
  final String? labelText;
  const CpDropDownButton(
      {Key? key,
      required this.controller,
      required this.items,
      required this.onChanged,
      this.icon,
      this.hintText,
      this.labelText})
      : super(key: key);

  @override
  State<CpDropDownButton> createState() => _CpDropDownButtonState();
}

class _CpDropDownButtonState extends State<CpDropDownButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        inputPaddingL,
        inputPaddingT,
        inputPaddingR,
        inputPaddingB,
      ),
      child: DropdownButtonFormField(
        //isExpanded: true,
        dropdownColor: ThisAppColors.inputFieldBgColor,
        decoration: InputDecoration(
          icon: widget.icon,
          hintText: widget.hintText,
          hintStyle: Theme.of(context).textTheme.bodyLarge,
          labelText: widget.labelText,
          labelStyle: Theme.of(context).textTheme.bodyLarge,
          //focusColor: ThisAppColors.bgColor,
        ),
        value: widget.controller.text,
        items: widget.items,
        onChanged: (checked) => widget.onChanged(checked),
      ),
    );
  }
}
