import 'package:flutter/material.dart';

import '../../../model/pc.dart';
import '../../../utils/colors.dart';
import '../../../utils/configs.dart';
import '../../../utils/prefs.dart';
import '../../../utils/responsive.dart';
import '../../../utils/ui_text.dart';
import '../../../utils/wol.dart';
import '../../addpc/add_pc.dart';

class PcItem extends StatefulWidget {
  final PC item;
  final Function getPCs;
  const PcItem({Key? key, required this.item, required this.getPCs})
      : super(key: key);

  @override
  State<PcItem> createState() => _PcItemState();
}

class _PcItemState extends State<PcItem> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: getTileConstraintSize()),
      child: Padding(
        padding: EdgeInsets.all(bodyPadding),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(pcTileBorderRadius),
            ),
            border: Border.all(
              color: ThisAppColors.pcTileBorderColor, // red as border color
            ),
          ),
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(pcTileBorderRadius),
            ),
            hoverColor: ThisAppColors.hoverColor,
            visualDensity: VisualDensity.comfortable,
            title: Text(
              widget.item.name,
              style: (Responsive.isSmallScreen(context) ||
                      Responsive.isMediumScreen(context))
                  ? Theme.of(context).textTheme.headline6
                  : Theme.of(context).textTheme.headline5,
            ),
            subtitle: Text(
              widget.item.target + ":" + widget.item.port.toString(),
              style: (Responsive.isSmallScreen(context) ||
                      Responsive.isMediumScreen(context))
                  ? Theme.of(context).textTheme.bodySmall
                  : Theme.of(context).textTheme.bodyLarge,
            ),
            trailing: OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: ThisAppColors.errorColor,
              ),
              child: Icon(
                Icons.remove_circle,
                size: pcTileIconSize,
              ),
              onPressed: () {
                showAlertDialogDeletePC(context, widget.item);
              },
            ),
            leading: OutlinedButton(
              child: Icon(
                Icons.computer,
                size: pcTileIconSize,
              ),
              onPressed: () async {
                showAlertDialogWakePC(context, widget.item);
              },
            ),
            onLongPress: () async {
              await prefsDuplicatedPC(widget.item);
              showsnackBar(pcDuplicatedMsg, context);
              widget.getPCs();
            },
            onTap: () async {
              goToEditPCScreen(widget.item.prefName);
            },
          ),
        ),
      ),
    );
  }

  double getTileConstraintSize() {
    bool isMediumScreen = Responsive.isMediumScreen(context);
    bool isLargecreen = Responsive.isLargeScreen(context);
    if (isLargecreen) {
      return (maxTileWidth);
    } else if (isMediumScreen) {
      return ((Responsive.currentScreenWidth(context).toInt() -
                  (2 * bodyPadding)) ~/
              2)
          .toDouble();
    } else {
      return Responsive.currentScreenWidth(context);
    }
  }

  goToEditPCScreen(String prefName) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddPCScreen(
          prefName: prefName,
        ),
      ),
    );
    widget.getPCs();
  }

  showAlertDialogDeletePC(BuildContext context, PC item) {
    Widget cancelButton = TextButton(
      child: Text(cancelButtonText),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = OutlinedButton(
      child: Text(continueButtonText),
      onPressed: () async {
        await prefsRemovePC(
          item.prefName.toString(),
        );
        widget.getPCs();
        showsnackBar(pcDeletedSuccessMsg, context);
        Navigator.of(context).pop();
      },
    );
    AlertDialog alert = AlertDialog(
      backgroundColor: ThisAppColors.bgColor,
      title: Text(pcDeletedTitle),
      content: Text(pcDeletedBodyMsg + item.name + "?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialogWakePC(BuildContext context, PC item) {
    Widget cancelButton = TextButton(
      child: Text(cancelButtonText),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = OutlinedButton(
      child: Text(continueButtonText),
      onPressed: () async {
        bool status = false;
        if (item.type == ipType) {
          status = await wolWakeUpIp(item.mac, item.target, item.port, context);
        } else {
          status =
              await wolWakeUpDNS(item.mac, item.target, item.port, context);
        }
        if (status) {
          showsnackBar(pcWolSent, context);
        }
        Navigator.of(context).pop();
      },
    );
    AlertDialog alert = AlertDialog(
      backgroundColor: ThisAppColors.bgColor,
      title: Text(pcSendWolTitle),
      content: Text(pcSendWolBodyMsg + item.name + "?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
