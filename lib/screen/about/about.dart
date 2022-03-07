import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../components/button_padding.dart';
import '../../components/main_body.dart';
import '../../utils/colors.dart';
import '../../utils/configs.dart';
import '../../utils/ui_text.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(aboutAppBarText),
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
                ClipOval(
                  child: Image.asset(
                    "assets/icon/icon.png",
                    fit: BoxFit.cover,
                    height: 135.0,
                  ),
                ),
                Container(
                  height: 10,
                ),
                Text(
                  appName,
                  style: Theme.of(context).textTheme.headline4,
                ),
                Container(
                  height: 5,
                ),
                Text(
                  versionText + appVersion,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Container(
                  height: 10,
                ),
                Text(
                  appDescription1,
                  style: Theme.of(context).textTheme.headline6,
                ),
                Container(
                  height: 10,
                ),
                Text(
                  appDescription2,
                  style: Theme.of(context).textTheme.headline6,
                ),
                ButtonPadding(
                  content: OutlinedButton(
                    onPressed: () {
                      _launchURL(appSite);
                    },
                    child: Text(siteButton),
                  ),
                ),
                Container(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    if (!await launch(url)) throw couldNotLaunch + ": " + url;
  }
}
