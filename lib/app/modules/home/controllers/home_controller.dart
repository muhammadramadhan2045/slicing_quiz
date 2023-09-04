import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  final List<Map<String, dynamic>> iconsData = [
    {'icon': Icons.edit_note_rounded, 'text': 'Koreksi jika perlu'},
    {'icon': Icons.person_2, 'text': 'Berada ditempat kondusif'},
    {'icon': Icons.person_2, 'text': 'Jujur'},
    {'icon': Icons.network_wifi, 'text': 'Koneksi Stabil'},
    {'icon': Icons.battery_full, 'text': 'Baterai Cukup'},
    {'icon': Icons.phone_android, 'text': 'Tidak Keluar dari Aplikasi'},
  ];
}
