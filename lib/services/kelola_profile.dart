import 'package:flutter/material.dart';

// Kelas untuk menampung data profil yang akan dikembalikan
class ProfileData {
  String fullName;
  String email;
  String phoneNumber;

  ProfileData({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
  });
}

class KelolaProfile extends StatefulWidget {
  // Tambahkan initialData untuk mengisi form saat dibuka
  final ProfileData initialData;

  const KelolaProfile({super.key, required this.initialData});

  @override
  State<KelolaProfile> createState() => _KelolaProfileState();
}

class _KelolaProfileState extends State<KelolaProfile> {
  // Gunakan TextEditingController untuk setiap input field
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    // Inisialisasi controller dengan initialData
    _nameController = TextEditingController(text: widget.initialData.fullName);
    _emailController = TextEditingController(text: widget.initialData.email);
    _phoneController = TextEditingController(text: widget.initialData.phoneNumber);
  }

  @override
  void dispose() {
    // Pastikan controller di-dispose untuk mencegah memory leak
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kelola Profil',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF2E6D9C), // Warna biru konsisten
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Saat tombol kembali ditekan, kita tidak mengembalikan data yang diubah
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Gunakan controller untuk setiap TextFormField
            _buildProfileInputField(
              context,
              label: 'Nama Lengkap',
              controller: _nameController, // Gunakan controller di sini
              icon: Icons.person,
            ),
            const SizedBox(height: 16),
            _buildProfileInputField(
              context,
              label: 'Email',
              controller: _emailController, // Gunakan controller di sini
              icon: Icons.email,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            _buildProfileInputField(
              context,
              label: 'Nomor Telepon',
              controller: _phoneController, // Gunakan controller di sini
              icon: Icons.phone,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Saat tombol disimpan ditekan, buat objek ProfileData baru
                // dengan nilai dari controller dan kembalikan ke halaman sebelumnya.
                final updatedProfileData = ProfileData(
                  fullName: _nameController.text,
                  email: _emailController.text,
                  phoneNumber: _phoneController.text,
                );
                Navigator.pop(context, updatedProfileData); // Mengembalikan data
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Perubahan profil disimpan!')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E6D9C), // Warna biru konsisten
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 3,
              ),
              child: const Text(
                'Simpan Perubahan',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // Modifikasi _buildProfileInputField untuk menerima TextEditingController
  Widget _buildProfileInputField(
    BuildContext context, {
    required String label,
    required TextEditingController controller, // Ubah dari initialValue menjadi controller
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller, // Gunakan controller di sini
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.grey),
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFF2E6D9C), width: 1.5),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          ),
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ],
    );
  }
}