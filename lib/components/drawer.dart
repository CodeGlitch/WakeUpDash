import 'package:flutter/material.dart';
import '../screen/about/about.dart';
import '../screen/export/export.dart';
import '../screen/import/import.dart';
import '../utils/ui_text.dart';
import '/utils/colors.dart';

class ThisDrawer extends StatelessWidget {
  const ThisDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ThisAppColors.drawerBgColor,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            DrawerHeader(
              child: ClipOval(
                child: Image.asset(
                  "assets/icon/icon.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            menuItem(context, importAppBarText, ImportScreen()),
            menuDivider(),
            menuItem(context, exportAppBarText, ExportScreen()),
            menuDivider(),
            menuItem(context, aboutAppBarText, AboutScreen()),
            menuDivider(),
          ],
        ),
      ),
    );
  }

  menuItem(context, String text, Widget screen) {
    return ListTile(
      hoverColor: ThisAppColors.hoverColor,
      title: Text(text),
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => screen,
          ),
        );
        Navigator.of(context).pop();
      },
    );
  }

  menuDivider() {
    return Divider(
      height: 0,
      color: ThisAppColors.secondaryColor,
      thickness: 2,
      endIndent: 10,
      indent: 10,
    );
  }
}
/*
class ThisDrawer {
  static Widget drawer(context) {
    return Drawer(
      backgroundColor: ThisAppColors.drawerBgColor,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            DrawerHeader(
              child: ClipOval(
                child: Image.asset(
                  "assets/icon/icon.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            menuItem(context, importAppBarText, ImportScreen()),
            menuDivider(),
            menuItem(context, exportAppBarText, ExportScreen()),
            menuDivider(),
            menuItem(context, aboutAppBarText, AboutScreen()),
            menuDivider(),
          ],
        ),
      ),
    );
  }

  static menuItem(context, String text, Widget screen) {
    return ListTile(
      hoverColor: ThisAppColors.hoverColor,
      title: Text(text),
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => screen,
          ),
        );
        Navigator.of(context).pop();
      },
    );
  }

  static menuDivider() {
    return Divider(
      height: 0,
      color: ThisAppColors.secondaryColor,
      thickness: 2,
      endIndent: 10,
      indent: 10,
    );
  }
}
*/