// profile_screen.dart
import 'package:flutter/material.dart';
import 'package:sip_rusak/screens/bantuan_screen.dart';
import 'package:sip_rusak/screens/login_screen.dart';
import 'package:sip_rusak/screens/notifikasi_screen.dart';
import 'package:sip_rusak/services/keamanan_screen.dart';
import 'package:sip_rusak/services/kelola_profile.dart'; // Pastikan import ini benar
import 'package:sip_rusak/screens/home_screen.dart'; // Import HomeScreen
import 'package:sip_rusak/screens/lapor_screen.dart'; // Import LaporScreen
import 'package:sip_rusak/screens/riwayat_screen.dart';
import 'package:sip_rusak/services/tentang_aplikasi.dart'; // Import RiwayatScreen

// Ubah ProfileScreen menjadi StatefulWidget
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // State untuk menyimpan data profil
  String _fullName = 'Daniel Cruz';
  String _email = 'daniel.cruz@gmail.com';
  String _phoneNumber = '+62 812 3456 7890'; // State untuk nomor telepon

  // Current index untuk BottomNavigationBar di ProfileScreen ini.
  // Karena ini adalah ProfileScreen, indexnya adalah 3.
  int _currentIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Profil Pengguna',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xFF2E6D9C),
        elevation: 0,
        // Tombol kembali di sini akan mem-pop ProfileScreen dari stack.
        // Jika ProfileScreen didorong dari HomeScreen, ia akan kembali ke HomeScreen.
        // Jika ProfileScreen adalah rute pertama yang di-push dari 'main.dart'
        // dan tidak ada rute lain di bawahnya, tombol ini mungkin tidak muncul
        // atau akan keluar dari aplikasi (tergantung platform).
        leading:
            Navigator.canPop(context)
                ? IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  onPressed: () {
                    // Ketika tombol kembali di AppBar ditekan, cukup pop layar ini.
                    // Ini akan kembali ke HomeScreen yang memanggilnya.
                    Navigator.pop(context);
                  },
                )
                : null,
        automaticallyImplyLeading: false, // Kita mengatur leading secara manual
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF2E6D9C), Color(0xFF4A90C2)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 55,
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                    child: const Icon(
                      // Menggunakan const karena ikonnya statis
                      Icons.person,
                      size: 70,
                      color: Color(0xFF2E6D9C),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _fullName, // Gunakan state _fullName
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _email, // Gunakan state _email
                    style: const TextStyle(color: Colors.white70, fontSize: 15),
                  ),
                  const SizedBox(
                    height: 4,
                  ), // Jarak antara email dan nomor telepon
                  Text(
                    _phoneNumber, // Tambahkan nomor telepon di sini
                    style: const TextStyle(color: Colors.white70, fontSize: 15),
                  ),
                  const SizedBox(height: 8),

                  // Perubahan tampilan "Pengguna Aktif"
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12, // Sedikit lebih lebar
                      vertical: 12, // Sedikit lebih tinggi
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green[400], // Warna hijau terang
                      borderRadius: BorderRadius.circular(15), // Lebih bulat
                      boxShadow: [
                        // Tambahkan sedikit shadow untuk efek 3D
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      // Gunakan Row untuk ikon dan teks
                      mainAxisSize:
                          MainAxisSize.min, // Sesuaikan ukuran dengan konten
                      children: const [
                        Icon(
                          Icons.check_circle,
                          color: Colors.white,
                          size: 16,
                        ), // Ikon ceklis
                        SizedBox(width: 6), // Jarak antara ikon dan teks
                        Text(
                          'Pengguna Aktif', // Status atau peran
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildOptionGroupTitle('Pengaturan Akun'),
                  _buildProfileOptionCard(
                    context,
                    icon: Icons.person_outline,
                    title: 'Kelola Profil',
                    description: 'Ubah informasi pribadi Anda',
                    onTap: () async {
                      final updatedData = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => KelolaProfile(
                                initialData: ProfileData(
                                  fullName: _fullName,
                                  email: _email,
                                  phoneNumber: _phoneNumber,
                                ),
                              ),
                        ),
                      );

                      if (updatedData != null && updatedData is ProfileData) {
                        setState(() {
                          _fullName = updatedData.fullName;
                          _email = updatedData.email;
                          _phoneNumber = updatedData.phoneNumber;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Profil berhasil diperbarui!'),
                          ),
                        );
                      }
                    },
                  ),
                  _buildProfileOptionCard(
                    context,
                    icon: Icons.lock_outline,
                    title: 'Keamanan Akun',
                    description: 'Ubah password, lihat aktivitas login',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const KeamananScreen(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  _buildOptionGroupTitle('Pengaturan Aplikasi'),
                  // _buildProfileOptionCard(
                  //   context,
                  //   icon: Icons.settings_outlined,
                  //   title: 'Pengaturan Umum',
                  //   description: 'Atur preferensi aplikasi dan notifikasi',
                  //   onTap: () {
                  //     ScaffoldMessenger.of(context).showSnackBar(
                  //       const SnackBar(
                  //         content: Text('Navigasi ke Pengaturan Umum'),
                  //       ),
                  //     );
                  //   },
                  // ),
                  _buildProfileOptionCard(
                    context,
                    icon: Icons.notifications_none,
                    title: 'Notifikasi',
                    description: 'Atur preferensi notifikasi',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NotificationScreen(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  _buildOptionGroupTitle('Bantuan & Informasi'),
                  _buildProfileOptionCard(
                    context,
                    icon: Icons.help_outline,
                    title: 'Pusat Bantuan',
                    description: 'Temukan jawaban atas pertanyaan Anda',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HelpCenterScreen(),
                        ),
                      );
                    },
                  ),
                  _buildProfileOptionCard(
                    context,
                    icon: Icons.info_outline,
                    title: 'Tentang Aplikasi',
                    description: 'Informasi dan lisensi',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AboutAndLicensesScreen(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _showLogoutConfirmationDialog(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[600],
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 3,
                      ),
                      icon: const Icon(Icons.logout, size: 20),
                      label: const Text(
                        'Keluar dari Akun',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20), // Jarak di bagian bawah
                  // Tambahkan teks versi di sini
                  Text(
                    'Version application 1.0.0',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black.withOpacity(0.5), // 50% hitam
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 20), // Jarak di bagian paling bawah
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF2E6D9C),
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex, // Gunakan _currentIndex dari ProfileScreen
        onTap: (index) {
          // Jika tab yang sama ditekan, tidak perlu melakukan apa-apa
          if (index == _currentIndex) {
            return;
          }

          // Perbarui _currentIndex ProfileScreen untuk menyorot tab yang benar
          setState(() {
            _currentIndex = index;
          });

          // Navigasi ke halaman yang sesuai
          // Karena HomeScreen tidak diubah, kita akan selalu mendorong halaman baru.
          // Menggunakan pushAndRemoveUntil untuk membersihkan stack navigasi
          // saat berpindah antar tab utama adalah cara terbaik untuk menghindari penumpukan.
          // Namun, karena permintaan Anda adalah "jangan ubah Home Screen",
          // saya akan menggunakan Navigator.pushReplacement untuk menghindari penumpukan yang tak terbatas
          // tapi tetap mempertahankan logika bahwa ProfileScreen adalah rute terpisah.
          // Ini akan mengganti ProfileScreen dengan rute baru.
          switch (index) {
            case 0: // Home
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
              break;
            case 1: // Lapor
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LaporScreen()),
              );
              break;
            case 2: // Riwayat
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const RiwayatScreen()),
              );
              break;
            case 3: // Profile (tetap di halaman ini)
              // Tidak ada yang perlu dilakukan karena kita sudah di ProfileScreen
              break;
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

  // Widget pembantu untuk judul grup opsi
  Widget _buildOptionGroupTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8.0,
        right: 8.0,
        top: 16.0,
        bottom: 8.0,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
          ),
        ),
      ),
    );
  }

  // Widget pembantu untuk setiap kartu opsi profil
  Widget _buildProfileOptionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? description,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 0.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          child: Row(
            children: [
              Icon(icon, color: const Color(0xFF2E6D9C), size: 26),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (description != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Text(
                          description,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 18),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text(
            'Konfirmasi Keluar',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text('Apakah Anda yakin ingin keluar dari akun ini?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(foregroundColor: Colors.grey[600]),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                print('User logged out!');
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (Route<dynamic> route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[600],
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Ya, Keluar'),
            ),
          ],
        );
      },
    );
  }
}
