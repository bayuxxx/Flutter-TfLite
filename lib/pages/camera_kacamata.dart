import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tflite_v2/tflite_v2.dart';
import 'package:uas_ubay/color/colors.dart';
import 'package:uas_ubay/main.dart';
import 'package:uas_ubay/widget/button_widget.dart';

class CameraKacamata extends StatefulWidget {
  const CameraKacamata({super.key});

  @override
  State<CameraKacamata> createState() => _CameraKacamataState();
}

class _CameraKacamataState extends State<CameraKacamata> {
  bool show = false;
  late CameraImage imgCamera;
  late CameraController kontrolkamera;
  bool bisagak = false;
  String result = "";

  initCamera() {
    kontrolkamera =
        CameraController(camerasKacamata[0], ResolutionPreset.medium);
    kontrolkamera.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {
        kontrolkamera.startImageStream((imageFromStream) => {
              if (!bisagak)
                {bisagak = true, imgCamera = imageFromStream, runModelOnFrame()}
            });
      });
    });
  }

  loadModelKacamata() async {
    await Tflite.loadModel(
      model: "assets/kacamata/modelKacamata_unquant.tflite",
      labels: "assets/kacamata/labelsKacamata.txt",
    );
  }

  runModelOnFrame() async {
    // ignore: unnecessary_null_comparison
    if (imgCamera != null) {
      var recognitions = await Tflite.runModelOnFrame(
        bytesList: imgCamera.planes.map((plane) {
          return plane.bytes;
        }).toList(),
        imageHeight: imgCamera.height,
        imageWidth: imgCamera.width,
        imageStd: 127.5,
        imageMean: 127.5,
        rotation: 90,
        numResults: 1,
        threshold: 0.1,
        asynch: true,
      );
      result = "";
      recognitions?.forEach((response) {
        result +=
            "${response["label"]} ${(response["confidence"] * 100).toStringAsFixed(0)}% ";
      });
      setState(() {
        result;
      });

      bisagak = false;
    }
  }

  showcamera() {
    setState(() {
      show = !show;
    });
  }

  @override
  void initState() {
    super.initState();
    initCamera();
    loadModelKacamata();
  }

  @override
  void dispose() {
    // Hentikan aliran gambar dan lepaskan sumber daya kamera
    kontrolkamera.stopImageStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Warna.merah,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Warna.merah,
                    border: Border.all(color: Colors.white, width: 2)),
                height: size.height - 250,
                child: (!kontrolkamera.value.isInitialized)
                    ? Container()
                    : AspectRatio(
                        aspectRatio: kontrolkamera.value.aspectRatio,
                        child: CameraPreview(kontrolkamera),
                      ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    color: Colors.pink,
                    borderRadius: BorderRadius.circular(20)),
                margin: const EdgeInsets.only(left: 20, right: 20),
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Text(
                    result,
                    style:
                        GoogleFonts.poppins(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: const ButtonClose(),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
