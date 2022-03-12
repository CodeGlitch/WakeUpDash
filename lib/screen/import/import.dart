import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../components/button_padding.dart';
import '../../components/cmp_text_input.dart';
import '../../components/main_body.dart';
import '../../utils/colors.dart';
import '../../utils/configs.dart';
import '../../utils/ui_text.dart';
import '../../utils/wol.dart';

class ImportScreen extends StatefulWidget {
  const ImportScreen({Key? key}) : super(key: key);

  @override
  State<ImportScreen> createState() => _ImportScreenState();
}

class _ImportScreenState extends State<ImportScreen> {
  late TextEditingController importData;
  @override
  void initState() {
    super.initState();
    load();
  }

  load() {
    importData = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(importAppBarText),
        backgroundColor: ThisAppColors.bgColor,
      ),
      body: MainBody(
        content: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(bodyPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  exportDataTitle,
                  style: Theme.of(context).textTheme.headline4,
                ),
                Container(
                  height: 10,
                ),
                CpTextInput(
                  keyboardInputType: TextInputType.text,
                  icon: const Icon(
                    Icons.wrap_text,
                    color: ThisAppColors.inputFieldBgColor,
                  ),
                  labelText: inputImportLabelText,
                  hintText: inputImportHintText,
                  controller: importData,
                  validator: (value) => (value == null || value.isEmpty)

                      ///TODO: add validation
                      ? inputImportValidatorMsg
                      : null,
                ),
                Text("Import will be implemented in next version, sorry!",
                    style: TextStyle(color: Colors.red)),

                ///TODO: add checkbox to append or override app content
                ButtonPadding(
                  content: OutlinedButton(
                    onPressed: () async {
                      ///TODO: add import logic
                    },
                    child: Text(importAppBarText),
                  ),
                ),
                Container(
                  height: 25,
                ),
                Text(
                  importExampleTitle,
                  style: Theme.of(context).textTheme.headline4,
                ),
                Container(
                  height: 10,
                ),
                Text(importExample),
                ButtonPadding(
                  content: OutlinedButton(
                    onPressed: () async {
                      await Clipboard.setData(
                          ClipboardData(text: importExample));
                      showsnackBar(copiedSuccess, context);
                    },
                    child: Text(copyText),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
