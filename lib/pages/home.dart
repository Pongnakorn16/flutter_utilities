import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:flutter_utilities/pages/%E0%B8%B7%E0%B8%B7navpages/getx.dart';
import 'package:flutter_utilities/pages/main_Drawer.dart';
import 'package:flutter_utilities/shared/app_data.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GetStorage gs = GetStorage();

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (gs.read("username") != null) {
        // Redirect to GetXPage after frame render
        log(gs.read("username").toString());
        Get.to(() => const GetXPage());
      } else {
        // Redirect to login page
        Navigator.of(context).pushNamed("login");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FilledButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainDrawerPage(),
                      ));
                },
                child: const Text("Demo Drawer"),
              ),
              FilledButton(
                onPressed: () {
                  Fluttertoast.showToast(
                      msg: "This is Center Short Toast",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Color.fromARGB(120, 0, 0, 0),
                      textColor: Colors.white,
                      fontSize: 20.0);
                },
                child: const Text("Demo Toast"),
              ),
              FilledButton(
                onPressed: () {
                  gs.write("username", "admin");
                  print(gs.read("username"));
                  Get.to(() => const GetXPage());
                },
                child: const Text("Get X"),
              ),
              FilledButton(
                onPressed: () {
                  context.read<AppData>().email = 'DOK@gmail.com';
                  UserProfile loginUser = UserProfile();
                  loginUser.idx = 1234;
                  loginUser.fullname = 'DOK';
                  loginUser.username = 'DOKKKUNGGG';
                  context.read<AppData>().user = loginUser;

                  Get.to(() => GetXPage());
                },
                child: const Text("Save Data to Provider"),
              ),
              FilledButton(
                onPressed: () async {
                  DateTime? newDateTime = await showRoundedDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(DateTime.now().year - 1),
                      lastDate: DateTime(DateTime.now().year + 1),
                      borderRadius: 16,
                      locale: const Locale("th", "TH"),
                      era: EraMode.BUDDHIST_YEAR);
                  if (newDateTime != null) {
                    log(newDateTime.toString());
                  } else {
                    log('No Date Selected');
                  }
                },
                child: const Text("Show calendar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
