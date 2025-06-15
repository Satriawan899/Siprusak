import 'package:flutter/material.dart';

class AboutAndLicensesScreen extends StatelessWidget {
  const AboutAndLicensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Tentang Aplikasi & Lisensi',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFF2E6D9C),
        foregroundColor: Colors.white,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo Aplikasi (Ganti dengan aset logo Anda)
            Image.asset(
              'assets/images/logosiprusak.png', // Ganti dengan path logo aplikasi Anda
              width: 120,
              height: 120,
              // Jika belum punya logo, bisa pakai Placeholder atau ikon:
              // child: Icon(Icons.build_circle_outlined, size: 100, color: Theme.of(context).primaryColor),
            ),
            const SizedBox(height: 20),

            // Nama Aplikasi & Versi
            Text(
              'SipRusak', // <-- TELAH DIUBAH: Nama aplikasi Anda
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Versi 1.0.0', // Ganti dengan versi aplikasi Anda yang sebenarnya
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
            const SizedBox(height: 30),

            // Deskripsi Aplikasi
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              margin: const EdgeInsets.symmetric(horizontal: 0),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tentang Aplikasi Ini',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'SipRusak adalah aplikasi inovatif yang dirancang untuk mempermudah masyarakat dalam melaporkan segala jenis infrastruktur yang rusak atau tidak berfungsi di lingkungan mereka. Mulai dari jalan berlubang, lampu penerangan jalan yang mati, hingga fasilitas umum yang rusak, semua dapat Anda laporkan dengan mudah melalui SipRusak. Dengan laporan Anda, kami berkomitmen untuk membantu mempercepat proses perbaikan demi kenyamanan dan keamanan bersama.', // <-- TELAH DIUBAH: Deskripsi aplikasi Anda
                      textAlign: TextAlign.justify,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.grey[700],
                            height: 1.5,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Informasi Pengembang & Hak Cipta
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              margin: const EdgeInsets.symmetric(horizontal: 0),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pengembang & Hak Cipta',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                    ),
                    const SizedBox(height: 10),
                    // Anda bisa mengubah informasi ini jika sudah ada nama tim/perusahaan yang spesifik
                    _buildInfoRow(context, Icons.person_outline, 'Pengembang:', 'Tim Pengembang SipRusak'), // <-- Anda bisa ubah ini
                    _buildInfoRow(context, Icons.business_outlined, 'Perusahaan:', 'Pemerintah Daerah / [Nama Perusahaan Anda]'), // <-- Anda bisa ubah ini
                    _buildInfoRow(context, Icons.copyright_outlined, 'Hak Cipta:', '© 2025 SipRusak. Semua Hak Dilindungi.'), // <-- TELAH DIUBAH: Hak Cipta
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Bagian Lisensi & Kebijakan
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              margin: const EdgeInsets.symmetric(horizontal: 0),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.gavel_outlined, color: Theme.of(context).primaryColor),
                    title: Text(
                      'Lisensi Sumber Terbuka',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
                    onTap: () {
                      // Ini akan menampilkan halaman lisensi standar Flutter
                      showLicensePage(context: context, applicationName: 'SipRusak'); // <-- TELAH DIUBAH: Nama aplikasi di Lisensi
                    },
                  ),
                  const Divider(indent: 16, endIndent: 16, height: 1),
                  ListTile(
                    leading: Icon(Icons.policy_outlined, color: Theme.of(context).primaryColor),
                    title: Text(
                      'Kebijakan Privasi',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Navigasi ke Kebijakan Privasi')));
                      // TODO: Implementasi navigasi ke halaman kebijakan privasi
                    },
                  ),
                  const Divider(indent: 16, endIndent: 16, height: 1),
                  ListTile(
                    leading: Icon(Icons.description_outlined, color: Theme.of(context).primaryColor),
                    title: Text(
                      'Syarat & Ketentuan',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Navigasi ke Syarat & Ketentuan')));
                      // TODO: Implementasi navigasi ke halaman syarat & ketentuan
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Footer
            Text(
              'Terima kasih telah menggunakan SipRusak!', // <-- TELAH DIUBAH: Nama aplikasi di Footer
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[500],
                  ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget pembantu untuk baris informasi (Tidak ada perubahan di sini, hanya kontennya yang diubah di atas)
  Widget _buildInfoRow(BuildContext context, IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Theme.of(context).primaryColor.withOpacity(0.8)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                ),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[700],
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}