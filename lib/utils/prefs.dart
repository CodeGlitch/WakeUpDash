import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/pc.dart';
import 'configs.dart';
import 'ui_text.dart';

Future<List<PC>> prefsGetPCs() async {
  final prefs = await SharedPreferences.getInstance();
  List<int> pcsIndex = await prefsGetPCsIndex(prefs);
  List<PC> pcs = [];
  for (int i = 0; i < pcsIndex.length; i++) {
    String pcString =
        await prefs.getString(pcKey + pcsIndex[i].toString()) ?? "";
    if (pcString.isNotEmpty) {
      PC newPC =
          PC.fromJson(json.decode(pcString), pcKey + pcsIndex[i].toString());
      pcs.add(newPC);
    }
  }
  pcs.sort((a, b) => a.name.compareTo(b.name));
  return pcs;
}

Future<List<int>> prefsGetPCsIndex(prefs) async {
  List<int> pcsIndex = [];
  String pcString = await prefs.getString(pcsIndexKey) ?? "";
  if (pcString.isNotEmpty) {
    pcsIndex = List<int>.from(jsonDecode(pcString));
  }
  return pcsIndex;
}

Future<int> prefsGetPCNewIndex(prefs) async {
  int index = 0;
  List<int> pcsIndex = [];
  String pcString = await prefs.getString(pcsIndexKey) ?? "";
  if (pcString.isNotEmpty) {
    pcsIndex = List<int>.from(jsonDecode(pcString));
  }
  if (pcsIndex.length > 0) {
    index = pcsIndex[pcsIndex.length - 1] + 1;
  }
  return index;
}

prefsRemovePC(String key) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove(key);
  String oldIndex = key.replaceAll(pcKey, "");
  await prefsRemovePCIndex(prefs, int.parse(oldIndex));
}

prefsDuplicatedPC(PC item) async {
  final prefs = await SharedPreferences.getInstance();
  int index = await prefsGetPCNewIndex(prefs);
  await prefs.setString(
    pcKey + index.toString(),
    json.encode(
      PC(
        //prefName: pcKey + index.toString(),
        name: item.name + duplicatedPcTag,
        target: item.target,
        mac: item.mac,
        port: item.port,
        type: item.type,
      ),
    ),
  );
  await prefsAddPCIndex(prefs, index);
}

prefsLoadPC(String prefName) async {
  final prefs = await SharedPreferences.getInstance();
  PC pc =
      PC.fromJson(json.decode(await prefs.getString(prefName) ?? ""), prefName);
  return pc;
}

prefsAddPC(PC newPC) async {
  final prefs = await SharedPreferences.getInstance();
  int index = await prefsGetPCNewIndex(prefs);
  await prefs.setString(pcKey + index.toString(), json.encode(newPC));
  await prefsAddPCIndex(prefs, index);
}

prefsUpdatedPC(PC newPC, String prefName) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(prefName, json.encode(newPC));
}

prefsAddPCIndex(prefs, int index) async {
  List<int> pcsIndex = await prefsGetPCsIndex(prefs);
  pcsIndex.add(index);
  await prefs.setString(pcsIndexKey, json.encode(pcsIndex));
}

prefsRemovePCIndex(prefs, int index) async {
  List<int> pcsIndex = await prefsGetPCsIndex(prefs);
  pcsIndex.remove(index);
  await prefs.setString(pcsIndexKey, json.encode(pcsIndex));
}

Future<String> export() async {
  List<PC> pcs = await prefsGetPCs();
  return json.encode(pcs);
}
