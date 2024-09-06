import 'dart:developer'; // ใช้ log() จาก dart:developer

import 'package:flutter/material.dart';
import 'package:flutter_utilities/shared/app_data.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class GetXPage extends StatefulWidget {
  const GetXPage({super.key});

  @override
  State<GetXPage> createState() => _GetXPageState();
}

class _GetXPageState extends State<GetXPage> {
  String email = '';
  GetStorage gs = GetStorage();
  @override
  void initState() {
    super.initState();
    log(Get.textTheme.labelMedium!.fontSize.toString());
    log(Get.textTheme.bodyMedium!.fontSize.toString());
    log(Get.textTheme.titleMedium!.fontSize.toString());
    log(Get.textTheme.headlineMedium!.fontSize.toString());
    log(Get.textTheme.displayMedium!.fontSize.toString());
    email = context.read<AppData>().email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            FilledButton(
                onPressed: () {
                  Get.snackbar('แจ้งเตือน!!!!!', 'หวยออกแล้ว คุณถูกกิน');
                },
                child: const Text('Snack Bar')),
            FilledButton(
                onPressed: () {
                  Get.defaultDialog(
                      barrierDismissible: false,
                      title: 'แจ้งเตือน!!!!!',
                      content: Column(
                        children: [Text('หวยออกแล้ว'), Text('คุณถูกหวยกิน')],
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              // Navigator.pop(context);
                              Get.back();
                            },
                            child: Text("ปิด")),
                        FilledButton(
                            onPressed: () {},
                            child: Text("รู้แล้ว งวดหน้าเอาใหม่"))
                      ]);
                },
                child: const Text('Defualt Dialog')),
            FilledButton(
                onPressed: () {
                  if (Get.isDarkMode) {
                    Get.changeTheme(ThemeData.light());
                  } else {
                    Get.changeTheme(ThemeData.dark());
                  }
                },
                child: const Text("Change Theme")),
            Text('Hello World!!! สวัสดี    ' + email + "",
                // + context.read<AppData>().user.username
                style: TextStyle(
                  fontSize: Get.textTheme.displayMedium!.fontSize,
                )),
            FilledButton(
                onPressed: () {
                  Get.defaultDialog(
                      title: "Username", content: Text(gs.read("username")));
                },
                child: const Text("Read Storage")),
            FilledButton(
                onPressed: () {
                  gs.remove("username");
                },
                child: const Text("Remove Storage"))
          ],
        ),
      ),
    );
  }
}
