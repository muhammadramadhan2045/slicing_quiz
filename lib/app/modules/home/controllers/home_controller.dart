import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_getx/app/data/model/matkul_model.dart';

class HomeController extends GetxController {
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

  // Ini hanya contoh, Anda perlu mengisi data sesuai kebutuhan aplikasi Anda
  var mataKuliahList = <MataKuliah>[
    MataKuliah(idMataKuliah: '1', namaMataKuliah: 'Matematika'),
    MataKuliah(idMataKuliah: '2', namaMataKuliah: 'Fisika'),
    // Tambahkan mata kuliah lainnya
  ].obs;

  List<Quiz> quizzes = [
    // Data ujian, ganti dengan data sesuai aplikasi Anda
    Quiz(
      idUQuiz: '1',
      idMataKuliah: '1',
      namaQuiz: 'Ujian Pertama',
      tanggalQuiz: DateTime.now(),
      durasiPengerjaan: 60,
    ),

    Quiz(
      idUQuiz: '2',
      idMataKuliah: '1',
      namaQuiz: 'Ujian Kedua',
      tanggalQuiz: DateTime.now(),
      durasiPengerjaan: 60,
    ),
    Quiz(
      idUQuiz: '3',
      idMataKuliah: '1',
      namaQuiz: 'Ujian Ketiga',
      tanggalQuiz: DateTime.now(),
      durasiPengerjaan: 60,
    ),

    Quiz(
      idUQuiz: '4',
      idMataKuliah: '2',
      namaQuiz: 'Ujian Keempat diklat flutter',
      tanggalQuiz: DateTime.now(),
      durasiPengerjaan: 60,
    ),
  ];

  // Fungsi untuk mendapatkan daftar ujian berdasarkan id mata kuliah
  List<Quiz> getQuizzesForMataKuliah(String idMataKuliah) {
    return quizzes.where((quiz) => quiz.idMataKuliah == idMataKuliah).toList();
  }
}
