import 'package:flutter/material.dart';

class LaporanScreen extends StatelessWidget {
  const LaporanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Laporan saya',
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
            context: context,
            name: 'Yulia Nita',
            time: '1 Jam Lalu Pengaduan',
            location: 'Denpasar Selatan, Bali',
            description:
                'Dengan hormat, saya melaporkan kejadian yang terjadi di Bali. Harapan saya agar kejadian ini dapat ditindaklanjuti oleh pihak yang berwenang.',
            imageUrl: 'assets/images/images.png',
            status: 'Dalam Proses',
            statusColor: Colors.orange,
            steps: [
              {'label': 'Pengaduan', 'description': 'Isi Pengaduan yang dilaporkan', 'isDone': true},
              {'label': 'Bukti Gambar', 'description': 'Lihat Gambar.', 'isDone': true},
              {'label': 'Pratinjau', 'description': 'Peninjauan terhadap laporan.', 'isDone': true},
              {'label': 'Selesai', 'description': 'Pengaduan telah dilaporkan', 'isDone': false},
            ],
            currentStepIndex: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildReportCard({
    required BuildContext context,
    required String name,
    required String time,
    required String location,
    required String description,
    required String imageUrl,
    required String status,
    required Color statusColor,
    required List<Map<String, dynamic>> steps,
    required int currentStepIndex,
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
                    // ----- START MODIFICATION HERE -----
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
                    // ----- END MODIFICATION HERE -----
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Hapus Row yang berisi ikon person di sini jika Anda sudah memindahkannya ke kiri
                          Text( // Ini adalah Text(name) Anda
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
            child: Image.asset(
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
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext dialogContext) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            imageUrl,
                            fit: BoxFit.contain,
                          ),
                        ),
                      );
                    },
                  );
                },
                icon: const Icon(Icons.visibility, size: 16),
                label: const Text('Lihat Detail'),
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF2E6D9C),
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  // TODO: Implementasi fungsi bagikan
                },
                icon: const Icon(Icons.share, size: 16),
                label: const Text('Bagikan'),
                style: TextButton.styleFrom(foregroundColor: Colors.grey[600]),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '30 Mei 2025',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
          ),
          const SizedBox(height: 12),

          _buildTimeline(steps, currentStepIndex),
        ],
      ),
    );
  }

  Widget _buildTimeline(List<Map<String, dynamic>> steps, int currentStepIndex) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(steps.length, (index) {
        bool isDone = index < currentStepIndex;
        bool isCurrent = index == currentStepIndex;
        bool isLast = index == steps.length - 1;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                _buildStepCircle(isDone, isCurrent, index),
                if (!isLast)
                  Container(
                    width: 2,
                    height: 50,
                    color: isDone ? const Color(0xFF2E6D9C) : Colors.grey[300],
                  ),
              ],
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      steps[index]['label']!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: isDone || isCurrent ? Colors.black87 : Colors.grey[600],
                      ),
                    ),
                    Text(
                      steps[index]['description']!,
                      style: TextStyle(
                        fontSize: 13,
                        color: isDone || isCurrent ? Colors.grey[700] : Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildStepCircle(bool isDone, bool isCurrent, int stepIndex) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isDone ? const Color(0xFF2E6D9C) : (isCurrent ? const Color(0xFF2E6D9C) : Colors.grey[300]),
        border: isCurrent && !isDone
            ? Border.all(color: Colors.blue, width: 2)
            : null,
      ),
      child: Center(
        child: isDone
            ? const Icon(Icons.check, color: Colors.white, size: 16)
            : (isCurrent
                ? Text(
                    (stepIndex + 1).toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : const SizedBox.shrink()),
      ),
    );
  }
}