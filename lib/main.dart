import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localmusicapp/controller/AllControllerBingding.dart';
import 'package:localmusicapp/notification/notification_service.dart';
import 'package:localmusicapp/router/AppRoutes.dart';
import 'package:localmusicapp/util/SqfliteUtil.dart';

void main() async {
  // needed if you intend to initialize in the `main` function
  WidgetsFlutterBinding.ensureInitialized();

  await SqfliteUtil.instance.initDb();
  await NotificationService().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: AppRouter.AllSong,
      getPages: AppRouter.routes,
      initialBinding: AllControllerBingding(),
    );
  }
}
