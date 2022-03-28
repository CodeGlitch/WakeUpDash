import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import '../../components/button_padding.dart';
import '../../components/cmp_text_input.dart';
import '../../components/main_body.dart';
import '../../model/pc.dart';
import '../../utils/colors.dart';
import '../../utils/configs.dart';
import '../../utils/prefs.dart';
import '../../utils/ui_text.dart';
import '../../utils/wol.dart';

class ImportScreen extends StatefulWidget {
  final Function refreshPCs;
  const ImportScreen({Key? key, required this.refreshPCs}) : super(key: key);

  @override
  State<ImportScreen> createState() => _ImportScreenState();
}

class _ImportScreenState extends State<ImportScreen> {
  final _formKey = GlobalKey<FormState>();
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
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
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
                    validator: (value) => (!validatePCList(value))
                        ? inputImportValidatorMsg +
                            importPcsFound +
                            totalPC.toString() +
                            ", " +
                            validPC.toString() +
                            importPcsValid +
                            invalidPC.toString() +
                            importPcsInvalid
                        : null,
                  ),
                  Text(
                    importReplaceWarning,
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        ?.copyWith(color: ThisAppColors.errorColor),
                  ),
                  ButtonPadding(
                    content: OutlinedButton(
                      onPressed: () async {
                        submitButton();
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
      ),
    );
  }

  submitButton() async {
    if (_formKey.currentState!.validate()) {
      List<PC> temp = getImportPCList(importData.text);
      await importNewPCList(temp);
      showsnackBar(importSuccess, context);
      widget.refreshPCs();
      Navigator.pop(context);
    }
  }

  int totalPC = 0;
  int validPC = 0;
  int invalidPC = 0;
  bool validatePCList(String? input) {
    totalPC = 0;
    validPC = 0;
    invalidPC = 0;
    if (input == null || input.isEmpty) {
      return false;
    }
    Iterable items = [];
    try {
      items = json.decode(input);
      totalPC = items.length;
    } catch (e) {
      return false;
    }
    List<PC> pcList = [];
    for (int i = 0; i < items.length; i++) {
      try {
        PC pc = PC.fromJson(items.elementAt(i), "0");
        pcList.add(pc);
        validPC++;
      } catch (e) {
        invalidPC++;
      }
    }
    return invalidPC == 0;
  }

  List<PC> getImportPCList(String input) {
    Iterable items = json.decode(input);
    List<PC> pcList = [];
    for (int i = 0; i < items.length; i++) {
      PC pc = PC.fromJson(items.elementAt(i), "0");
      pcList.add(pc);
    }
    return pcList;
  }
}
