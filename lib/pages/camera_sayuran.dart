import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:uas_ubay/color/colors.dart';
import 'package:uas_ubay/getx/sayuran_controller.dart';
import 'package:uas_ubay/widget/button_widget.dart';

class CameraSayuran extends StatelessWidget {
  const CameraSayuran({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SayuranController());

    return GetBuilder<SayuranController>(
      builder: (controller) => Scaffold(
        backgroundColor: Warna.merah,
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(color: Warna.merah),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: InkWell(
                      onTap: () {
                        controller.initCamera();
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 25),
                        height: 500,
                        width: 360,
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: Colors.white,
                          width: 2,
                        )),
                        child: controller.imgCamera == null
                            ? SizedBox(
                                child: Lottie.asset('assets/camera.json'))
                            : AspectRatio(
                                aspectRatio:
                                    controller.kontrolKamera.value.aspectRatio,
                                child: CameraPreview(controller.kontrolKamera),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Center(
                    child: Text(
                      controller.hasil,
                      style: const TextStyle(
                        backgroundColor: Colors.pink,
                        fontSize: 30,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.find<SayuranController>().stopCamera();
                      Get.back();
                    },
                    child: const ButtonClose(),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
