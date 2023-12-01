import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_getx/app/modules/home/controllers/home_controller.dart';

class ExplanationWidget extends StatelessWidget {
  final VoidCallback onPressed;
  ExplanationWidget({super.key, required this.onPressed});

  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
        height: Get.height * 0.45,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            const Text(
              'Simulasi Kuis kali ini akan berlangsung selama 10 menit',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // 2 kolom
                ),
                itemCount: controller.iconsData.length, // Jumlah ikon
                itemBuilder: (BuildContext context, int index) {
                  IconData icon = controller.iconsData[index]['icon'];
                  String text = controller.iconsData[index]['text'];

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor:
                            Theme.of(context).primaryColor.withOpacity(0.75),
                        child: Icon(
                          icon,
                          color: Colors.white,
                        ),
                      ), // Ikon
                      const SizedBox(height: 8), // Spasi antara ikon dan teks
                      Text(
                        text,
                        textAlign: TextAlign.center,
                      ), // Teks singkat di bawah ikon
                    ],
                  ); // Ganti dengan ikon yang sesuai
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Tutup bottom sheet
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    side: const BorderSide(color: Colors.blue),
                    backgroundColor: Colors.white,
                    fixedSize:
                        Size(MediaQuery.of(context).size.width * 0.4, 40),
                  ),
                  child: const Text(
                    'Batal',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    fixedSize:
                        Size(MediaQuery.of(context).size.width * 0.4, 40),
                  ),
                  child: const Text(
                    'Mulai',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
