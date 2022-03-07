import 'package:flutter/material.dart';
import 'components/pc_item.dart';
import '../../components/app_bar.dart';
import '../../components/drawer.dart';
import '../../components/main_body.dart';
import '../../model/pc.dart';
import '../../utils/configs.dart';
import '../../utils/prefs.dart';
import '../../utils/ui_text.dart';
import '../addpc/add_pc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  initState() {
    super.initState();
    getPCs();
  }

  Future getPCs() async {
    isLoading = true;
    setState(() {});
    pcs = await prefsGetPCs();
    isLoading = false;
    setState(() {});
  }

  bool isLoading = true;
  late List<PC> pcs = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ThisAppBar.appBar(context),
      drawer: ThisDrawer.drawer(context),
      body: MainBody(
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(bodyPadding),
                child: Wrap(
                  children: [
                    if (isLoading) ...[
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                    ] else if (pcs.isEmpty) ...[
                      Text(homeNoPCs),
                    ] else ...[
                      for (int i = 0; i < pcs.length; i++) ...[
                        PcItem(
                          item: pcs.elementAt(i),
                          getPCs: getPCs,
                        )
                        //getPCTile(context, i),
                      ],
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: OutlinedButton(
        style: OutlinedButton.styleFrom(
          minimumSize: Size(100, buttonsMinHeight),
        ),
        onPressed: () {
          goToAddPCScreen();
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }

  goToAddPCScreen() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddPCScreen(
          prefName: "",
        ),
      ),
    );
    getPCs();
  }
}

  /*Widget getStartBody() {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (pcs.isEmpty) {
      return Text(homeNoPCs);
    } else {
      return ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        itemCount: pcs.length,
        itemBuilder: (BuildContext context, int index) {
          return getPCTile(context, index);
        },
        separatorBuilder: (BuildContext context, int index) => getDivider(),
      );
    }
  }*/