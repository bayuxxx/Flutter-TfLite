import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uas_ubay/pages/splash_page.dart';

late List<CameraDescription> camerasKacamata;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  camerasKacamata = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
