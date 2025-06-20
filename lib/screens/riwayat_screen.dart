import 'package:flutter/material.dart';

class RiwayatScreen extends StatelessWidget {
  const RiwayatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Riwayat',
          style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(221, 255, 255, 255)),
        ),
        backgroundColor: const Color(0xFF2E6D9C), // Warna biru dari home screen
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color.fromARGB(255, 255, 255, 255)),
          onPressed: () => Navigator.pop(context),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildReportCard(
            name: 'Yulia Nita',
            time: '1 Jam Lalu Pengaduan',
            location: 'Denpasar Selatan, Bali',
            description:
                'Dengan hormat, saya melaporkan kejadian yang terjadi di Bali. Harapan saya agar kejadian ini dapat ditindaklanjuti oleh pihak yang berwenang.',
            imageUrl:
                'https://images.unsplash.com/photo-1541888946425-d81bb19240f5?w=400&h=200&fit=crop',
            status: 'Dalam Proses',
            statusColor: Colors.orange,
          ),
          const SizedBox(height: 16),
          _buildReportCard(
            name: 'Ahmad Rizky',
            time: '3 Jam Lalu Pengaduan',
            location: 'Denpasar Utara, Bali',
            description:
                'Jalan di depan rumah saya mengalami kerusakan parah. Banyak lubang yang membahayakan pengendara motor.',
            imageUrl:
                'https://images.unsplash.com/photo-1541888946425-d81bb19240f5?w=400&h=200&fit=crop',
            status: 'Selesai',
            statusColor: Colors.green,
          ),
          const SizedBox(height: 16),
          _buildReportCard(
            name: 'Siti Rahayu',
            time: '1 Hari Lalu Pengaduan',
            location: 'Badung, Bali',
            description:
                'Lampu jalan di sekitar area ini sudah mati sejak seminggu yang lalu. Mohon untuk segera diperbaiki.',
            imageUrl:
                'https://images.unsplash.com/photo-1541888946425-d81bb19240f5?w=400&h=200&fit=crop',
            status: 'Ditolak',
            statusColor: Colors.red,
          ),
          const SizedBox(height: 16),
          _buildReportCard(
            name: 'Made Wirawan',
            time: '2 Hari Lalu Pengaduan',
            location: 'Gianyar, Bali',
            description:
                'Saluran air di jalan utama tersumbat dan menyebabkan banjir saat hujan. Mohon segera dibersihkan.',
            imageUrl:
                'https://images.unsplash.com/photo-1547036967-23d11aacaee0?w=400&h=200&fit=crop',
            status: 'Dalam Proses',
            statusColor: Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _buildReportCard({
    required String name,
    required String time,
    required String location,
    required String description,
    required String imageUrl,
    required String status,
    required Color statusColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100, // Warna latar belakang lingkaran
                        borderRadius: BorderRadius.circular(25), // Membuat lingkaran
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 30, // Ukuran ikon person
                        color: Color(0xFF2E6D9C), // Warna ikon
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            time,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 14,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  location,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.visibility, size: 16),
                label: const Text('Lihat Detail'),
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF2E6D9C),
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.share, size: 16),
                label: const Text('Bagikan'),
                style: TextButton.styleFrom(foregroundColor: Colors.grey[600]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
