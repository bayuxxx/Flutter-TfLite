import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'dart:io';
import 'package:tflite_v2/tflite_v2.dart';
import 'package:uas_ubay/color/colors.dart';
import 'package:uas_ubay/widget/table_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _loading = true;
  late File _image;
  late List _output;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    loadmodel().then((value) {
      setState(() {});
    });
  }

  detectImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.6,
      imageMean: 127.5,
      imageStd: 127.5,
    );

    setState(() {
      _output = output!;
      _loading = false;
    });
  }

  loadmodel() async {
    await Tflite.loadModel(
      model: 'assets/hewan/modelHewan_unquant.tflite',
      labels: 'assets/hewan/labelsHewan.txt',
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  pickCamera() async {
    var image = await picker.pickImage(source: ImageSource.camera);
    if (image == null) {
      return null;
    }
    setState(() {
      _image = File(image.path);
    });
    // print("Kamera : ${image.path}");
    detectImage(_image);
  }

  pickcGallery() async {
    var image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return null;
    }
    setState(() {
      _image = File(image.path);
    });
    // print("Galllery : ${image.path}");
    detectImage(_image);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Warna.merah,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const TableWidget(),
            const Table1(),
            const Table2(),
            Center(
              child: _loading
                  ? Center(
                      child: Lottie.asset('assets/animal.json',
                          width: 300, height: 300),
                    )
                  : Container(
                      width: screenWidth,
                      margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 2, color: Colors.white),
                            ),
                            child: Image.file(_image),
                          ),
                          const SizedBox(height: 20),
                          // ignore: unnecessary_null_comparison
                          _output != null
                              ? Text("${_output[0]['label']}",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold))
                              : Container()
                        ],
                      ),
                    ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                      child: InkWell(
                    onTap: () {
                      pickCamera();
                    },
                    child: Container(
                      height: 70,
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(color: Colors.white, spreadRadius: 2)
                        ],
                        color: Colors.pink,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: const Center(
                        child: Text(
                          "Camera",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                    ),
                  )),
                  const SizedBox(width: 10),
                  Expanded(
                      child: InkWell(
                    onTap: () {
                      pickcGallery();
                    },
                    child: Container(
                      height: 70,
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(color: Colors.white, spreadRadius: 2)
                        ],
                        color: Colors.pink,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: const Center(
                        child: Text(
                          "Gallery",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                    ),
                  )),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
