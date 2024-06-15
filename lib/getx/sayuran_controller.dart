import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:tflite_v2/tflite_v2.dart';

class SayuranController extends GetxController {
  late CameraController kontrolKamera; // Pengontrol untuk kamera
  CameraImage? imgCamera; // Representasi gambar dari kamera
  bool bisaGak = false; // Status untuk menentukan apakah model dapat dijalankan
  String hasil = ""; // Hasil pengenalan objek oleh model

  @override
  void onInit() {
    super.onInit();
    initCamera(); // Panggil fungsi untuk menginisialisasi kamera saat controller diinisialisasi
  }

  // Fungsi untuk menginisialisasi kamera dan memuat model saat controller diinisialisasi
  initCamera() async {
    await loadModel(); // Panggil fungsi untuk memuat model

    final cameras = await availableCameras(); // Dapatkan daftar kamera yang tersedia
    kontrolKamera = CameraController(cameras[0], ResolutionPreset.medium);

    await kontrolKamera.initialize(); // Inisialisasi kamera
    if (kontrolKamera.value.isInitialized) {
      // Jika kamera berhasil diinisialisasi
      // print('Camera initialized successfully');
    } else {
      // Jika terdapat error saat inisialisasi kamera
      // print('Error initializing camera');
    }

    // Memulai stream gambar dari kamera dan menjalankan model ketika mendapatkan frame baru
    kontrolKamera.startImageStream((imageFromStream) => {
          // print('Received a frame from the camera stream'),
          if (!bisaGak)
            {
              bisaGak = true,
              imgCamera = imageFromStream,
              runModelOnFrame(),
            }
        });
  }

  // Fungsi untuk memuat model TensorFlow Lite
  loadModel() async {
    // print('Loading the model...');
    await Tflite.loadModel(
      model: "assets/sayuran/sayuran.tflite",
      labels: "assets/sayuran/sayuran.txt",
    );
  }

  // Fungsi untuk menjalankan model pada setiap frame dari stream kamera
  runModelOnFrame() async {
    try {
      if (imgCamera == null) {
        return;
      }

      // Menjalankan model pada frame yang diterima dari stream kamera
      var recognitions = await Tflite.runModelOnFrame(
        bytesList: imgCamera!.planes.map((plane) {
          return plane.bytes;
        }).toList(),
        imageHeight: imgCamera!.height,
        imageWidth: imgCamera!.width,
        imageMean: 127.5,
        imageStd: 127.5,
        rotation: 90,
        numResults: 5,
        threshold: 0.1,
        asynch: true,
      );

      hasil = ""; // Mengosongkan hasil pengenalan sebelumnya

      // Memproses hasil pengenalan dan mengupdate variabel hasil
      if (recognitions != null && recognitions.isNotEmpty) {
        for (var response in recognitions) {
          String label = response['label'] ?? '';
          double confidence = (response['confidence'] as double?) ?? 0.0;
          hasil += " $label: ${(confidence * 100).toStringAsFixed(0)}%\n";
        }
      }
      update(); // Memperbarui tampilan dengan hasil pengenalan terbaru
      bisaGak = false; // Menandakan bahwa model dapat dijalankan lagi
    } catch (e) {
      // print('Error running model: $e');
    }
  }

  // Fungsi untuk menghentikan stream gambar dari kamera
  stopCamera() {
    kontrolKamera.stopImageStream();
  }
}
