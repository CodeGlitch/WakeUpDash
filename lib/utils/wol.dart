import 'dart:io';
import 'package:flutter/material.dart';
import 'ui_text.dart';

showsnackBar(String showText, context) {
  SnackBar snackBar = SnackBar(
    content: Text(
      showText,
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

Future<bool> wolWakeUpIp(
    String targetMac, String target, int port, context) async {
  return wolWakeUp(targetMac, InternetAddress(target), port, context);
}

Future<bool> wolWakeUpDNS(
    String targetMac, String target, int port, context) async {
  bool send = true;
  InternetAddress? ia = await wolGetIp(target, context).onError(
    (error, stackTrace) {
      send = false;
      return null;
    },
  );
  if (send) {
    return wolWakeUp(targetMac, ia, port, context);
  } else {
    return false;
  }
}

Future<bool> wolWakeUp(
    String targetMac, InternetAddress? target, int port, context) async {
  bool wakeSent = true;
  if (target == null) {
    showsnackBar(errorNoIp, context);
    return false;
  }
  RawDatagramSocket wakeUp =
      await RawDatagramSocket.bind(InternetAddress.anyIPv4, 0);
  wakeUp.broadcastEnabled = true;
  wakeUp.send(createMagicPacket(targetMac), target, port);
  wakeUp.listen(
    (event) {
      if (event == RawSocketEvent.write) {
        wakeUp.close();
      }
    },
  ).onError(
    (error, stackTrace) {
      wakeSent = false;
      showsnackBar(preErrorText + error, context);
    },
  );
  return wakeSent;
}

List<int> createMagicPacket(String macAddress) {
  List<int> packet = [255, 255, 255, 255, 255, 255];
  macAddress = macAddress.replaceAll(RegExp(r"[-|:]"), "");
  for (int i = 0; i < 16; i++) {
    for (int startAt = 0; startAt < macAddress.length; startAt += 2) {
      var s = macAddress.substring(startAt, startAt + 2);
      packet.add(int.parse(s, radix: 16));
    }
  }
  return packet;
}

Future<InternetAddress?> wolGetIp(String target, context) async {
  InternetAddress? ipAddress;
  await InternetAddress.lookup(target)
      .then(
    (value) => {
      value.forEach(
        (element) {
          //String ip = element.address;
          //String ip1 = element.host;
          //Uint8List ip2 = element.rawAddress;
          //InternetAddressType ip3 = element.type;
          //Type ip4 = element.runtimeType;
          //print(element.address);
          //print(ip3);
          ipAddress = element;
        },
      ),
    },
  )
      .onError(
    (error, stackTrace) {
      //wakeSent = false;
      showsnackBar(preErrorText + domainNotFound, context);
      throw couldNotLaunch + ": " + target;
    },
  );
  return ipAddress;
}
