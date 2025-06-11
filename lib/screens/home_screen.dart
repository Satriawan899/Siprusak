import 'package:flutter/material.dart';
import 'package:sip_rusak/screens/lapor_screen.dart'; // Import LaporScreen
import 'package:sip_rusak/screens/laporan_screen.dart'; // Pastikan ini diimpor jika digunakan
import 'package:sip_rusak/screens/profile_screen.dart'; // Import ProfileScreen
import 'package:sip_rusak/screens/riwayat_screen.dart'; // Import RiwayatScreen
import 'package:sip_rusak/screens/scan_screen.dart'; // Import ScanScreen

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          HomeScreenContent(),
          // Placeholder untuk tab "Lapor"
          Center(child: Text('Halaman Lapor - Akan di-push')),
          // Placeholder untuk tab "Riwayat"
          Center(child: Text('Halaman Riwayat - Akan di-push')),
          ProfileScreen(), // Halaman Profil sebagai body tab
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF2E6D9C),
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (index) async {
          setState(() {
            _currentIndex = index;
          });

          if (index == 1) {
            // Index 1 adalah "Lapor"
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LaporScreen()),
            );
            setState(() {
              _currentIndex = 0;
            });
          } else if (index == 2) {
            // Index 2 adalah "Riwayat"
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RiwayatScreen()),
            );
            setState(() {
              _currentIndex = 0;
            });
          } else if (index == 3) {
            // Index 3 adalah "Profile"
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
            );
            setState(() {
              _currentIndex = 0;
            });
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.report), label: 'Lapor'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Riwayat'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

// Custom Clipper untuk membuat bentuk melengkung pada bagian bawah AppBar
class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 30); // Mulai sedikit di atas dasar

    // Titik kontrol pertama untuk lengkungan ke atas
    path.quadraticBezierTo(
      size.width * 0.25, // x dari titik kontrol 1
      size.height,      // y dari titik kontrol 1 (lebih rendah untuk lengkungan ke atas)
      size.width * 0.5, // x akhir dari segmen pertama
      size.height - 30, // y akhir dari segmen pertama
    );

    // Titik kontrol kedua untuk lengkungan ke bawah
    path.quadraticBezierTo(
      size.width * 0.75, // x dari titik kontrol 2
      size.height - 60,  // y dari titik kontrol 2 (lebih tinggi untuk lengkungan ke bawah)
      size.width,        // x akhir dari segmen kedua
      size.height - 30,  // y akhir dari segmen kedua
    );

    path.lineTo(size.width, 0); // Garis lurus ke sudut kanan atas
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class HomeScreenContent extends StatelessWidget {
  const HomeScreenContent({super.key});

  // Fungsi untuk menampilkan pop-up notifikasi
  void _showNotificationPopup(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 80.0, left: 16.0, right: 16.0),
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Notifikasi',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, size: 20),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 1),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 10.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Hari ini',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.assignment,
                                  color: Colors.green[700],
                                  size: 24,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Pengaduan Jalan Rusak',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.green[800],
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      const Text(
                                        'Pengaduan anda telah berhasil di laporkan.',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Text(
                                  '1 jam lalu',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 1),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Navigasi ke Semua Notifikasi'),
                            ),
                          );
                        },
                        child: const Text(
                          'Lihat semua notifikasi',
                          style: TextStyle(
                            color: Color(0xFF2E6D9C),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // Pembungkus untuk Stack agar tinggi tetap 130
          SizedBox(
            height: 200, // Menentukan tinggi keseluruhan area AppBar
            child: Stack(
              children: [
                // Area melengkung (sekarang sebagai latar belakang di Stack)
                Positioned.fill(
                  child: ClipPath(
                    clipper: CurveClipper(),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF2E6D9C), Color(0xFF4A90C2)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                         boxShadow: [
                          BoxShadow( 
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 15,
                            offset: const Offset(0, 5), // Offset bisa tetap const
                          ),
                        ],
                      ),
                      child: Container(), // Container kosong sebagai latar belakang
                    ),
                  ),
                ),
               // --- BULAT-BULAT DEKORATIF ---
                Positioned(
                  top: -30,
                  left: -30,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  right: -20,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                // Konten AppBar (Hai, pengguna, lokasi, notifikasi, tombol pengaduan)
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hai, pengguna',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: Colors.white70,
                                      size: 16,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      'Jl.Raya Jayagita Gg.II Blok B',
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _showNotificationPopup(context),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.notifications_outlined,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LaporScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 15,
                            ),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 0,
                          ),
                          icon: const Icon(Icons.add, size: 18),
                          label: const Text(
                            'Pengaduan',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Grid Menu 2x2
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1.1,
                    children: [
                      _buildMenuCard(
                        title: 'Pengaduan',
                        icon: Icons.edit_document, // Menggunakan IconData
                        color: Colors.orange, // Menggunakan Color
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LaporScreen(),
                            ),
                          );
                        },
                      ),
                      _buildMenuCard(
                        title: 'Scan',
                        icon: Icons.qr_code_scanner, // Menggunakan IconData
                        color: Colors.blue, // Menggunakan Color
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ScanScreen(),
                            ),
                          );
                        },
                      ),
                      _buildMenuCard(
                        title: 'Laporan',
                        icon: Icons.description, // Menggunakan IconData
                        color: Colors.purple, // Menggunakan Color
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LaporanScreen(),
                            ),
                          );
                        },
                      ),
                      _buildMenuCard(
                        title: 'Riwayat Lapor',
                        icon: Icons.history, // Menggunakan IconData
                        color: Colors.green, // Menggunakan Color
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RiwayatScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Section Laporan Pengaduan
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Laporan Pengaduan',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RiwayatScreen(),
                            ),
                          );
                        },
                        child: const Text('Lihat Semua'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Card Laporan
                  Container(
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
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color:
                                    Colors.grey[200], // Background untuk ikon
                              ),
                              child: const Icon(
                                // Menggunakan Icons.person
                                Icons.person,
                                size: 30, // Sesuaikan ukuran ikon
                                color: Colors.grey, // Sesuaikan warna ikon
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Daniel Cruz',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    '1 Jam Lalu Pengaduan',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        size: 14,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        'Denpasar Selatan, Bali',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Dengan hormat, saya melaporkan kejadian yang terjadi di Bali. Harapan saya agar kejadian ini dapat ditindaklanjuti oleh pihak yang berwenang.',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'assets/images/images.png',
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
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
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color:
                                    Colors.grey[200], // Background untuk ikon
                              ),
                              child: const Icon(
                                // Menggunakan Icons.person
                                Icons.person,
                                size: 30, // Sesuaikan ukuran ikon
                                color: Colors.grey, // Sesuaikan warna ikon
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Nyoman Nilem',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    '1 Jam Lalu Pengaduan',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        size: 14,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        'Denpasar Selatan, Bali',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Dengan hormat, saya melaporkan kejadian yang terjadi di Bali. Harapan saya agar kejadian ini dapat ditindaklanjuti oleh pihak yang berwenang.',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'assets/images/images.png',
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
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
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color:
                                    Colors.grey[200], // Background untuk ikon
                              ),
                              child: const Icon(
                                // Menggunakan Icons.person
                                Icons.person,
                                size: 30, // Sesuaikan ukuran ikon
                                color: Colors.grey, // Sesuaikan warna ikon
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Nelson Hay',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    '1 Jam Lalu Pengaduan',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        size: 14,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        'Denpasar Selatan, Bali',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Dengan hormat, saya melaporkan kejadian yang terjadi di Bali. Harapan saya agar kejadian ini dapat ditindaklanjuti oleh pihak yang berwenang.',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'assets/images/images.png',
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // _buildMenuCard dikembalikan ke versi yang menggunakan IconData dan Color
  Widget _buildMenuCard({
    required String title,
    required IconData icon, // Menggunakan IconData
    required Color color, // Menggunakan Color
    required VoidCallback onTap,
  }) {
    return Material( // Membungkus dengan Material untuk InkWell
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      elevation: 2, // Memberikan sedikit elevasi agar efek shadow terlihat
      shadowColor: Colors.grey.withOpacity(0.1), // Menambahkan shadow ke Material

      child: InkWell( // Mengganti GestureDetector dengan InkWell
        onTap: onTap,
        borderRadius: BorderRadius.circular(12), // Pastikan borderRadius cocok
        splashColor: color.withOpacity(0.3), // Warna riak saat disentuh
        highlightColor: color.withOpacity(0.1), // Warna sorotan saat ditahan

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1), // Background berwarna untuk icon
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                size: 32,
                color: color,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}