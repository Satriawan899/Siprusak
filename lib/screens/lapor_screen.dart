// home_page.dart
import 'package:flutter/material.dart';

class LaporScreen extends StatelessWidget {
  const LaporScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lapor'),
        automaticallyImplyLeading: false, // Menyembunyikan tombol back
      ),
      body: const Center(child: Text('Selamat datang di halaman Lapor!')),
    );
  }
}
