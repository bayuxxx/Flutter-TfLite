import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:uas_ubay/color/colors.dart';
import 'package:uas_ubay/widget/nav_bar_widget.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  final _pageController = PageController();

  void dispose() {
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Timer(
      const Duration(seconds: 5),
      () {
        Get.off(
          () => NavBarWidget(
            pageControlller: _pageController,
            pageController: PageController(),
          ),
          duration: const Duration(seconds: 3),
          transition: Transition.fade,
        );
      },
    );
    return Scaffold(
      backgroundColor: Warna.merah,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/batman.json'),
            AnimatedTextKit(
              animatedTexts: [
                TyperAnimatedText(
                  'I GEDE BAYU BALAWA TANGUB\n2201010048',
                  textAlign: TextAlign.center,
                  textStyle: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
