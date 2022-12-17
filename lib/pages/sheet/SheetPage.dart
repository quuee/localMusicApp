import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localmusicapp/components/BottomPlayBar.dart';
import 'package:localmusicapp/components/DrawerMenu.dart';
import 'package:localmusicapp/components/SingleSheet.dart';
import 'package:localmusicapp/config/ConstValues.dart';
import 'package:localmusicapp/controller/SheetController.dart';

class SheetPage extends StatefulWidget {
  const SheetPage({Key? key}) : super(key: key);

  @override
  State<SheetPage> createState() => _SheetPageState();
}

class _SheetPageState extends State<SheetPage> {
  final sheetNameController = TextEditingController();

  @override
  void dispose() {
    sheetNameController.dispose();
    super.dispose();
  }

  // 创建新歌单
  _createNewSheet(context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("取消")),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            debugPrint(sheetNameController.text);
                            SheetController sheetController =
                                Get.find<SheetController>();
                            sheetController.addSheet(sheetNameController.text);
                            Navigator.pop(context);
                          },
                          child: const Text("完成")),
                    )
                  ],
                ),
                TextField(
                  controller: sheetNameController,
                  decoration: const InputDecoration(hintText: "请输入歌单名称"),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // SheetController sheetController = Get.find<SheetController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(ConstValues.PageName_Sheet),
        // actions: [IconButton(onPressed: , icon: Icon(Icons.add))],
      ),
      drawer: const DrawerMenu(),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                // 在父组件加载完毕后再加载子组件
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  _createNewSheet(context);
                });
              },
              child: const Text("添加歌单")),
          Expanded(
            child: GetBuilder<SheetController>(
              builder: (_) {
                return RefreshIndicator(
                  color: Colors.blue,
                  displacement: 22,
                  backgroundColor: Colors.grey[100],
                  onRefresh: () async {
                    await _.refreshSheet();
                  },
                  child: ListView.builder(
                      itemCount: _.sheetList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return SingleSheet(
                            _.sheetList.elementAt(index).sheetName!,
                            _.sheetList.elementAt(index).id!);
                      }),
                );
              },
            ),
          ),
          BottomPlayBar()
        ],
      ),
    );
  }
}
