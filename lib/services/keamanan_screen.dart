import 'package:flutter/material.dart';

class KeamananScreen extends StatelessWidget {
  const KeamananScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keamanan Akun'),
        backgroundColor: Color(0xFF2E6D9C), // Warna AppBar
        foregroundColor: Colors.white, // Warna teks di AppBar
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Deskripsi Umum
            Text(
              'Jaga keamanan akun Anda dengan memperbarui kata sandi secara berkala dan memantau aktivitas login.',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.grey[700],
                  ),
            ),
            const SizedBox(height: 30),

            // Bagian Ubah Kata Sandi
            _buildSecurityCard(
              context,
              icon: Icons.lock_reset,
              title: 'Ubah Kata Sandi',
              description:
                  'Perbarui kata sandi Anda secara berkala untuk menjaga keamanan akun. Gunakan kombinasi huruf besar, kecil, angka, dan simbol.',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Navigasi ke halaman ubah kata sandi')),
                );
                // TODO: Implementasi navigasi ke halaman ubah kata sandi
              },
            ),
            const SizedBox(height: 20),

            // Bagian Aktivitas Login
            _buildSecurityCard(
              context,
              icon: Icons.history,
              title: 'Aktivitas Login',
              description:
                  'Lihat riwayat aktivitas login akun Anda. Laporkan jika ada aktivitas yang mencurigakan.',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Navigasi ke halaman detail aktivitas login')),
                );
                // TODO: Implementasi navigasi ke halaman detail aktivitas login
              },
            ),
            const SizedBox(height: 30),

            // Detail Aktivitas Login Terakhir (Opsional, bisa dihilangkan jika ingin halaman terpisah)
            Text(
              'Aktivitas Login Terbaru',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 15),
            _buildLoginAttemptItem(
                context,
                Icons.check_circle_outline,
                '15 Juni 2025, 20:00 WITA',
                'Denpasar, Bali',
                'Samsung Galaxy S24',
                Colors.green),
            _buildLoginAttemptItem(
                context,
                Icons.check_circle_outline,
                '14 Juni 2025, 10:30 WITA',
                'Jakarta, Indonesia',
                'MacBook Air',
                Colors.green),
            _buildLoginAttemptItem(
                context,
                Icons.check_circle_outline,
                '13 Juni 2025, 18:45 WITA',
                'Denpasar, Bali',
                'Xiaomi Redmi Note 12',
                Colors.green),
            // Contoh aktivitas gagal
            // _buildLoginAttemptItem(
            //     context,
            //     Icons.error_outline,
            //     '12 Juni 2025, 09:00 WITA',
            //     'Surabaya, Indonesia',
            //     'Tidak dikenal',
            //     Colors.red),

            const SizedBox(height: 20),
            Center(
              child: OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Melihat semua aktivitas login')),
                  );
                  // TODO: Implementasi navigasi ke halaman semua aktivitas login
                },
                icon: const Icon(Icons.arrow_forward),
                label: const Text('Lihat Semua Aktivitas'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Theme.of(context).primaryColor,
                  side: BorderSide(color: Theme.of(context).primaryColor),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk membuat kartu keamanan yang menarik
  Widget _buildSecurityCard(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String description,
        required VoidCallback onTap,
      }) {
    return Card(
      elevation: 4, // Efek bayangan
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // Sudut membulat
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: 36,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk menampilkan item aktivitas login
  Widget _buildLoginAttemptItem(BuildContext context, IconData icon, String time,
      String location, String device, Color iconColor) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(icon, color: iconColor, size: 28),
        title: Text(
          time,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Lokasi: $location'),
            Text('Perangkat: $device'),
          ],
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Detail aktivitas dari $time')),
          );
          // TODO: Implementasi navigasi ke detail aktivitas login tertentu
        },
      ),
    );
  }
}