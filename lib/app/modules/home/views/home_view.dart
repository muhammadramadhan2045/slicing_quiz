import 'package:flutter/material.dart';

import 'package:get/get.dart';
// import 'package:quiz_getx/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: controller,
        builder: (controller) {
          return Scaffold(
              appBar: AppBar(
                title: Text('Daftar Mata Kuliah'),
              ),
              body: ListView.builder(
                itemCount: controller.mataKuliahList.length,
                itemBuilder: (context, index) {
                  var mataKuliah = controller.mataKuliahList[index];
                  return ListTile(
                    title: Text(mataKuliah.namaMataKuliah),
                    onTap: () {
                      Get.toNamed('/pickquizviewview',
                          arguments: mataKuliah.idMataKuliah);
                    },
                  );
                },
              ));
        });
  }
}
