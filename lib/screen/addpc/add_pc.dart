import 'package:flutter/material.dart';
import '../../utils/configs.dart';
import '../../components/button_padding.dart';
import '../../components/cmp_ddb_input.dart';
import '../../components/cmp_text_input.dart';
import '../../components/main_body.dart';
import '../../model/pc.dart';
import '../../utils/colors.dart';
import '../../utils/prefs.dart';
import '../../utils/ui_text.dart';

class AddPCScreen extends StatefulWidget {
  final String prefName;
  const AddPCScreen({Key? key, required this.prefName}) : super(key: key);

  @override
  _AddPCScreenState createState() => _AddPCScreenState();
}

class _AddPCScreenState extends State<AddPCScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController namePC;
  late TextEditingController macPC;
  late TextEditingController targetPC;
  late TextEditingController portPC;
  late TextEditingController typePC;

  @override
  initState() {
    super.initState();
    load();
    if (widget.prefName != "") {
      loadPC();
    }
  }

  load() {
    namePC = TextEditingController();
    macPC = TextEditingController();
    targetPC = TextEditingController();
    portPC = TextEditingController();
    typePC = TextEditingController(text: ipType);
  }

  loadPC() async {
    PC editPC = await prefsLoadPC(widget.prefName);
    namePC.text = editPC.name;
    macPC.text = editPC.mac;
    targetPC.text = editPC.target;
    portPC.text = editPC.port.toString();
    typePC.text = editPC.type.toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(newPCAppBarText),
        backgroundColor: ThisAppColors.bgColor,
      ),
      body: MainBody(
        content: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(bodyPadding),
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    CpDropDownButton(
                      icon: const Icon(
                        Icons.network_ping,
                        color: ThisAppColors.inputFieldBgColor,
                      ),
                      controller: typePC,
                      onChanged: (value) {
                        typePC.text = value.toString();
                        setState(() {});
                      },
                      items: [
                        DropdownMenuItem(
                          child: Text(ipAddressText),
                          value: ipType,
                        ),
                        DropdownMenuItem(
                          child: Text(dnsText),
                          value: dnsType,
                        )
                      ],
                    ),
                    CpTextInput(
                      keyboardInputType: TextInputType.text,
                      icon: const Icon(
                        Icons.contacts,
                        color: ThisAppColors.inputFieldBgColor,
                      ),
                      labelText: inputNameLabelText,
                      hintText: inputNameHintText,
                      controller: namePC,
                      validator: (value) => (value == null || value.isEmpty)
                          ? inputNameValidatorMsg
                          : null,
                    ),
                    CpTextInput(
                      keyboardInputType: TextInputType.url,
                      icon: const Icon(
                        Icons.link,
                        color: ThisAppColors.inputFieldBgColor,
                      ),
                      labelText:
                          typePC.text == ipType ? ipAddressText : dnsText,
                      hintText: typePC.text == ipType
                          ? inputTargetIpHintText
                          : inputTargetDnsHintText,
                      controller: targetPC,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return typePC.text == ipType
                              ? inputTargetIpValidatorMsg
                              : inputTargetDnsValidatorMsg;
                        } else if (typePC.text == ipType &&
                            !validateIPv4Address(value)) {
                          return invalidIpMsg;
                        } else if (typePC.text == dnsType &&
                            !validateDomainName(value)) {
                          return invalidDnsMsg;
                        } else {
                          return null;
                        }
                      },
                    ),
                    CpTextInput(
                        keyboardInputType: TextInputType.text,
                        labelText: inputMacLabelText,
                        hintText: inputMacHintText,
                        icon: const Icon(
                          Icons.vpn_key,
                          color: ThisAppColors.inputFieldBgColor,
                        ),
                        controller: macPC,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return inputMacValidatorMsg;
                          } else if (!validateMACAddress(value)) {
                            return invalidMacMsg;
                          } else {
                            return null;
                          }
                        }),
                    CpTextInput(
                      keyboardInputType: TextInputType.number,
                      labelText: inputPortLabelText,
                      hintText: inputPortHintText,
                      icon: const Icon(
                        Icons.confirmation_num,
                        color: ThisAppColors.inputFieldBgColor,
                      ),
                      controller: portPC,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return inputPortValidatorMsg;
                        } else if (!validatePort(value)) {
                          return invalidPortMsg;
                        } else {
                          return null;
                        }
                      },
                    ),
                    ButtonPadding(
                      content: OutlinedButton(
                        onPressed: () {
                          submitButton();
                        },
                        child: Text(widget.prefName == ""
                            ? newPCButton
                            : updatePCButton),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(cancelButtonText),
      ),
    );
  }

  submitButton() async {
    if (_formKey.currentState!.validate()) {
      if (widget.prefName == "") {
        await prefsAddPC(PC(
          name: namePC.text,
          //prefName:,
          target: targetPC.text,
          mac: macPC.text,
          port: int.parse(portPC.text),
          type: int.parse(typePC.text),
        ));
      } else {
        await prefsUpdatedPC(
            PC(
              name: namePC.text,
              //prefName:,
              target: targetPC.text,
              mac: macPC.text,
              port: int.parse(portPC.text),
              type: int.parse(typePC.text),
            ),
            widget.prefName);
      }
      Navigator.pop(context);
    }
  }

  bool validateMACAddress(String address) {
    RegExp exp = RegExp(
        r"^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})|([0-9a-fA-F]{4}\\.[0-9a-fA-F]{4}\\.[0-9a-fA-F]{4})$");
    return exp.hasMatch(address);
  }

  bool validateIPv4Address(String ip) {
    RegExp exp = RegExp(
        r"^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$");
    return exp.hasMatch(ip);
  }

  bool validateDomainName(String target) {
    RegExp exp = RegExp(r"^([a-z0-9]+(-[a-z0-9]+)*\.)+[a-z]{2,}$");
    return exp.hasMatch(target);
  }

  bool validatePort(String port) {
    if (int.tryParse(port) != null) {
      if (int.parse(port) >= minPortNumber &&
          int.parse(port) <= maxPortNumber) {
        return true;
      }
    }
    return false;
  }
}
