import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localmusicapp/controller/AllControllerBingding.dart';
import 'package:localmusicapp/router/AppRoutes.dart';
import 'package:localmusicapp/util/SqfliteUtil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SqfliteUtil.instance.initDb();
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
