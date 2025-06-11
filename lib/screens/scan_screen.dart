import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:image_picker/image_picker.dart'; // <<< PASTIKAN INI ADA
import 'dart:io'; // Untuk menggunakan tipe File

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  MobileScannerController cameraController = MobileScannerController();
  String? scannedQrCodeData;

  // --- Tambahkan variabel ini ---
  File? _imageFile;

  // --- Tambahkan metode ini ---
  Future<void> _pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
      });
      print('Gambar dipilih dari galeri: ${_imageFile!.path}');
      // Anda bisa menavigasi ke layar laporan dengan gambar ini
      // Navigator.push(context, MaterialPageRoute(builder: (context) => LaporScreen(imageFile: _imageFile)));
    }
  }

  // --- Tambahkan metode ini ---
  Future<void> _takePhotoWithCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);

    if (photo != null) {
      setState(() {
        _imageFile = File(photo.path);
      });
      print('Foto diambil dengan kamera: ${_imageFile!.path}');
      // Anda bisa menavigasi ke layar laporan dengan gambar ini
      // Navigator.push(context, MaterialPageRoute(builder: (context) => LaporScreen(imageFile: _imageFile)));
    }
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E6D9C),
        title: const Text('Pindai Laporan Infrastruktur', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              const Text(
                'Arahkan kamera ke kode QR untuk memindai laporan kerusakan.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: MobileScanner(
                      controller: cameraController,
                      onDetect: (capture) {
                        final List<Barcode> barcodes = capture.barcodes;
                        if (barcodes.isNotEmpty) {
                          final String? code = barcodes.first.rawValue;
                          if (code != null && code != scannedQrCodeData) {
                            setState(() {
                              scannedQrCodeData = code;
                            });
                            cameraController.stop();
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("QR Code Terdeteksi!"),
                                  content: Text("Data: $code"),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text("OK"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        cameraController.start();
                                      },
                                    ),
                                    TextButton(
                                      child: const Text("Lapor Sekarang"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        print("Navigasi ke LaporScreen dengan data: $code");
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        }
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  scannedQrCodeData != null
                      ? 'QR Code terdeteksi: $scannedQrCodeData'
                      : 'Pindai QR code yang tertempel pada infrastruktur yang rusak untuk melaporkan masalahnya.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: scannedQrCodeData != null ? 14 : 12,
                    height: 1.5,
                    fontWeight: scannedQrCodeData != null ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: ElevatedButton(
                  onPressed: () {
                    // Tampilkan pilihan antara galeri atau kamera
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext bc) {
                        return SafeArea(
                          child: Wrap(
                            children: <Widget>[
                              ListTile(
                                leading: const Icon(Icons.photo_library),
                                title: const Text('Pilih dari Galeri'),
                                onTap: () {
                                  _pickImageFromGallery();
                                  Navigator.of(context).pop();
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.photo_camera),
                                title: const Text('Ambil Foto Baru'),
                                onTap: () {
                                  _takePhotoWithCamera();
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.upload_file),
                      SizedBox(width: 8),
                      Text('Unggah Bukti Manual', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => cameraController.toggleTorch(),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF2E6D9C),
        child: const Icon(Icons.flash_on),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}