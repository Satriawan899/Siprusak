import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Warna latar belakang yang lembut
      appBar: AppBar(
        title: const Text(
          'Notifikasi',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false, // Judul rata kiri seperti di gambar
        backgroundColor:Color(0xFF2E6D9C),
        foregroundColor: Colors.white,// Latar belakang AppBar putih
        elevation: 1, // Sedikit bayangan di bawah AppBar
        actions: [
          IconButton(
            icon: const Icon(Icons.close), // Ikon 'x' di pojok kanan atas
            onPressed: () {
              Navigator.pop(context); // Kembali ke halaman sebelumnya
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hari ini',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            _buildNotificationCard(
              context,
              icon: Icons.description_outlined, // Ikon dokumen
              iconColor: Colors.green[700]!, // Warna ikon hijau
              title: 'Pengaduan Jalan Rusak',
              description: 'Pengaduan anda telah berhasil di laporkan.',
              time: '1 jam lalu',
              cardColor: Colors.green[50]!, // Warna latar belakang kartu hijau muda
            ),
            // Anda bisa menambahkan notifikasi lain di sini jika diperlukan
            const SizedBox(height: 10),
            _buildNotificationCard(
              context,
              icon: Icons.info_outline,
              iconColor: Colors.blue[700]!,
              title: 'Informasi Terbaru',
              description: 'Terdapat pembaruan aplikasi versi 2.0.',
              time: '2 jam lalu',
              cardColor: Colors.blue[50]!,
            ),
            const SizedBox(height: 10),
            _buildNotificationCard(
              context,
              icon: Icons.warning_amber_outlined,
              iconColor: Colors.orange[700]!,
              title: 'Peringatan Akun',
              description: 'Ada aktivitas login dari perangkat baru.',
              time: 'Kemarin',
              cardColor: Colors.orange[50]!,
            ),
            const SizedBox(height: 20),
            Center(
              child: TextButton(
                onPressed: () {
                  // TODO: Implementasi logika untuk melihat semua notifikasi
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Melihat semua notifikasi')),
                  );
                },
                child: Text(
                  'Lihat semua notifikasi',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor, // Menggunakan warna primer tema
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationCard(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String title,
    required String description,
    required String time,
    required Color cardColor,
  }) {
    return Card(
      color: cardColor, // Latar belakang kartu notifikasi
      elevation: 0, // Tanpa bayangan untuk tampilan yang lebih flat
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0), // Sudut membulat
        side: BorderSide(
            color: Colors.grey[200]!, width: 1), // Border tipis untuk pemisah
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1), // Latar belakang ikon lebih terang
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Text(
              time,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }
}