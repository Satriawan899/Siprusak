import 'package:flutter/material.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E6D9C), // Warna biru dari home screen
        title: const Text('Pindai Laporan Infrastruktur', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.grey[50], // Background yang cerah, sesuaikan jika ingin seperti ungu di gambar awal
            child: Column(
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
                // Placeholder Area untuk Pemindai QR
                Center(
                  child: Container(
                    width: 250, // Lebar area scan
                    height: 250, // Tinggi area scan
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey, width: 2), // Border abu-abu
                    ),
                    child: Stack(
                      children: [
                        // Icon QR Code sebagai placeholder
                        const Center(
                          child: Icon(
                            Icons.qr_code_rounded,
                            size: 100,
                            color: Colors.grey,
                          ),
                        ),
                        // Corner brackets (optional, for visual effect)
                        // Top-left
                        Positioned(
                          top: 0,
                          left: 0,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(color: Colors.blue[700]!, width: 5),
                                left: BorderSide(color: Colors.blue[700]!, width: 5),
                              ),
                            ),
                          ),
                        ),
                        // Top-right
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(color: Colors.blue[700]!, width: 5),
                                right: BorderSide(color: Colors.blue[700]!, width: 5),
                              ),
                            ),
                          ),
                        ),
                        // Bottom-left
                        Positioned(
                          bottom: 0,
                          left: 0,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Colors.blue[700]!, width: 5),
                                left: BorderSide(color: Colors.blue[700]!, width: 5),
                              ),
                            ),
                          ),
                        ),
                        // Bottom-right
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Colors.blue[700]!, width: 5),
                                right: BorderSide(color: Colors.blue[700]!, width: 5),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    'Pindai QR code yang tertempel pada infrastruktur yang rusak untuk melaporkan masalahnya.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                      height: 1.5,
                    ),
                  ),
                ),
                const Spacer(),
                // Anda bisa menambahkan tombol lain di sini jika diperlukan,
                // seperti tombol untuk mengunggah bukti foto secara manual.
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: ElevatedButton(
                    onPressed: () {
                      // Fungsi yang akan dijalankan ketika tombol ini ditekan (misal: buka galeri)
                      print('Tombol Unggah Manual Ditekan');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4CAF50), // Warna hijau
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
          ),
        ],
      ),
      // Floating Action Button sebagai tombol utama (opsional, karena ini hanya UI)
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Di sini Anda akan mengintegrasikan fungsionalitas kamera sungguhan jika diperlukan nanti.
          print('Tombol kamera virtual ditekan');
        },
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF2E6D9C),
        child: const Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}