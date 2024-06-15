import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:uas_ubay/color/colors.dart';
import 'camera_sayuran.dart';

class SayuranPage extends StatelessWidget {
  const SayuranPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Warna.merah,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                AnimatedTextKit(
                  animatedTexts: [
                    TyperAnimatedText(
                      'Broccoli vs Cauliflower',
                      curve: Curves.linear,
                      speed: const Duration(milliseconds: 50),
                      textAlign: TextAlign.center,
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Lottie.asset('assets/deteksi.json'),
                InkWell(
                  onTap: () {
                    // Get.offAll(CameraSayuran());
                    Get.to(const CameraSayuran());
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        color: Colors.pink,
                        borderRadius: BorderRadius.circular(45)),
                    width: double.infinity,
                    child: const Center(
                      child: Text(
                        'OPEN CAMERA',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
