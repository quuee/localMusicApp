import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localmusicapp/router/AppRoutes.dart';

playListPopupMenu(BuildContext context) {
  return PopupMenuButton(
    itemBuilder: (context) {
      return [
        PopupMenuItem(
          child: Text("添加歌曲"),
          value: "add",
        ),
        PopupMenuItem(
          child: Text("编辑歌单"),
          value: "edit",
        ),
        PopupMenuItem(
          child: Text("排序"),
          value: "sequence",
        ),
        PopupMenuItem(
          child: Text("删除歌单"),
          value: "delete",
        ),
      ];
    },
    onSelected: (String value) {
      if(value == "add"){
        Get.toNamed(AppRouter.ChooseSong);
      }
    },
  );
}
