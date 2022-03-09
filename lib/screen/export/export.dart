import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../components/button_padding.dart';
import '../../components/main_body.dart';
import '../../utils/colors.dart';
import '../../utils/configs.dart';
import '../../utils/prefs.dart';
import '../../utils/ui_text.dart';
import '../../utils/wol.dart';

class ExportScreen extends StatefulWidget {
  const ExportScreen({Key? key}) : super(key: key);

  @override
  State<ExportScreen> createState() => _ExportScreenState();
}

class _ExportScreenState extends State<ExportScreen> {
  @override
  initState() {
    super.initState();
    exportPCs();
  }

  exportPCs() async {
    exported = await export();
    setState(() {});
  }

  String exported = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(exportAppBarText),
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
                ButtonPadding(
                  content: OutlinedButton(
                    onPressed: () async {
                      await Clipboard.setData(ClipboardData(text: exported));
                      showsnackBar(copiedSuccess, context);
                    },
                    child: Text(copyText),
                  ),
                ),
                Text(exported),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
