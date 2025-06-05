import 'package:flutter/material.dart';
import 'package:sip_rusak/screens/login_screen.dart'; // Ganti sesuai halaman berikutnya

class ReportNowScreen extends StatelessWidget {
  const ReportNowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          width: size.width,
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(height: 30),
              Image.asset(
                'assets/images/report.png', // Pastikan gambar ini ada di folder assets
                height: size.height * 0.35,
              ),
              Column(
                children: const [
                  Text(
                    'Report now',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E6D9C),
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Ayo laporkan keluh kesah infrastruktur\ndaerah anda sekarang!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) =>
                              const LoginScreen(), // ganti jika login belum jadi
                    ),
                  );
                },
                icon: const Icon(Icons.arrow_forward, color: Colors.white),
                label: const Text(
                  'Mulai',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E6D9C),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 14,
                  ),
                  textStyle: const TextStyle(fontSize: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
