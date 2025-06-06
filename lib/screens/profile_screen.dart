// home_page.dart
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        automaticallyImplyLeading: false, // Menyembunyikan tombol back
      ),
      body: const Center(child: Text('Selamat datang di halaman Profile!')),
    );
  }
}
