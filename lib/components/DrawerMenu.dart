
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localmusicapp/config/ConstValues.dart';
import 'package:localmusicapp/router/AppRoutes.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: const Icon(Icons.ad_units),
                  title: const Text(ConstValues.PageName_AllPage),
                  onTap: () {Get.toNamed(AppRouter.AllSong);
                  },
                ),

                ListTile(
                  leading: const Icon(Icons.ad_units),
                  title: const Text(ConstValues.PageName_Sheet),
                  onTap: (){
                    Get.toNamed(AppRouter.Sheet);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.ad_units),
                  title: const Text(ConstValues.PageName_Scan),
                  onTap: () {
                    Get.toNamed(AppRouter.Scan);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
