import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Import ini
import 'dart:io'; // Import ini untuk tipe File

class LaporScreen extends StatefulWidget {
  const LaporScreen({super.key});

  @override
  State<LaporScreen> createState() => _LaporScreenState();
}

class _LaporScreenState extends State<LaporScreen> {
  int currentStep = 0;
  final TextEditingController _complaintController = TextEditingController();

  // URL for the image from SIPRUSAK3.png (unused if _imageFile is set)
  final String _previewImageUrl =
      'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=400&h=200&fit=crop';

  // --- Variabel untuk menyimpan gambar ---
  File? _imageFile;

  // --- Metode untuk mengambil gambar dari galeri ---
  Future<void> _pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
      });
      print('Gambar dipilih dari galeri: ${_imageFile!.path}');
    }
  }

  // --- Metode untuk mengambil foto dari kamera ---
  Future<void> _takePhotoWithCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);

    if (photo != null) {
      setState(() {
        _imageFile = File(photo.path);
      });
      print('Foto diambil dengan kamera: ${_imageFile!.path}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Progress Indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                _buildStepIndicator(1, currentStep >= 0, 'Tulis Pengaduan'),
                _buildStepLine(currentStep >= 1),
                _buildStepIndicator(2, currentStep >= 1, 'Pilih bukti'),
                _buildStepLine(currentStep >= 2),
                _buildStepIndicator(3, currentStep >= 2, 'Pratinjau'),
              ],
            ),
          ),

          Expanded(child: _buildCurrentStep()),

          // Bottom Button
          Container(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _getButtonAction(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E6D9C),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  _getButtonText(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (currentStep) {
      case 0:
        return _buildWriteComplaintStep();
      case 1:
        return _buildSelectEvidenceStep();
      case 2:
        return _buildPreviewStep();
      default:
        return _buildWriteComplaintStep();
    }
  }

  Widget _buildWriteComplaintStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Info Card
          Container(
            padding: const EdgeInsets.all(16),
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
            child: const Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Color.fromARGB(255, 187, 222, 251),
                  child: Icon( // Hapus const di sini karena Icons.person sudah const
                    Icons.person,
                    size: 30,
                    color: Color(0xFF2E6D9C),
                  ),
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Daniel Cruz',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 14, color: Colors.grey),
                        SizedBox(width: 4),
                        Text(
                          'Denpasar Selatan, Bali',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Complaint Text Field
          Container(
            padding: const EdgeInsets.all(16),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Deskripsi keluhan :',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _complaintController,
                  maxLines: 8,
                  decoration: const InputDecoration(
                    hintText:
                        'Saya ingin menyampaikan pengaduan terkait [jenis masalah], yang terjadi pada [waktu dan tempat]. Masalah ini menyebabkan [dampak yang dirasakan]. Berikan penjelasan lebih detailnya',
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- MODIFIKASI _buildSelectEvidenceStep ---
  Widget _buildSelectEvidenceStep() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Tampilkan pratinjau gambar jika sudah ada
            _imageFile != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      _imageFile!,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                : Image.asset('assets/images/camera.png', height: 150), // Gambar placeholder
            const SizedBox(height: 20),
            Text(
              _imageFile != null
                  ? 'Gambar berhasil diunggah!'
                  : 'Ambil Foto Atau Video\nBukti Pengaduan Anda',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              _imageFile != null
                  ? 'Anda dapat melanjutkan ke pratinjau atau mengganti gambar.'
                  : 'Melampirkan bukti foto sangat penting, agar\npengaduanmu memiliki bukti yang jelas. Ambil foto\natau video dengan cahaya yang cukup, serta jelas\nuntuk dilihat.',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, color: Colors.grey, height: 1.5),
            ),
            const SizedBox(height: 30),
            // Tombol untuk memicu pilihan galeri/kamera
          ],
        ),
      ),
    );
  }

  // --- MODIFIKASI _buildPreviewStep ---
  Widget _buildPreviewStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Info Card (from SIPRUSAK3.png)
          Container(
            padding: const EdgeInsets.all(16),
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
            child: const Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Color.fromARGB(255, 187, 222, 251),
                  child: Icon( // Hapus const di sini karena Icons.person sudah const
                    Icons.person,
                    size: 30,
                    color: Color(0xFF2E6D9C),
                  ),
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Daniel Cruz',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 14, color: Colors.grey),
                        SizedBox(width: 4),
                        Text(
                          'Denpasar Selatan, Bali',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Preview Message (from SIPRUSAK3.png)
          Container(
            padding: const EdgeInsets.all(16),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Display the complaint text here
                Text(
                  _complaintController.text.isEmpty
                      ? 'Saya melaporkan kejadian yang terjadi di Bali. Harapan saya agar kejadian ini dapat ditindaklanjuti oleh pihak yang berwenang.mohon segera di urusi agar memudahkan dalam beraktivitas maupun lewat lalulalang di jalan tersebut.\nTerima kasih'
                      : _complaintController
                          .text, // Use the actual text from the controller if available
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 12), // Added some space after the image
                const Text(
                  'Bukti Foto / Video :', // Label for the image
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 12),
                // --- Tampilkan gambar yang dipilih atau placeholder ---
                _imageFile != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          _imageFile!, // Gunakan gambar yang diambil/dipilih
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'assets/images/images.png', // Placeholder jika tidak ada gambar
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
    );
  }

  Widget _buildStepIndicator(int step, bool isActive, String label) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF2E6D9C) : Colors.grey[300],
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              step.toString(),
              style: TextStyle(
                color: isActive ? Colors.white : Colors.grey[600],
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isActive ? const Color(0xFF2E6D9C) : Colors.grey[600],
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildStepLine(bool isActive) {
    return Expanded(
      child: Container(
        height: 2,
        margin: const EdgeInsets.only(bottom: 30),
        color: isActive ? const Color(0xFF2E6D9C) : Colors.grey[300],
      ),
    );
  }

  String _getButtonText() {
    switch (currentStep) {
      case 0:
        return 'Lanjut';
      case 1:
        // Tombol ini akan 'Lanjut' hanya jika gambar sudah dipilih
        return _imageFile != null ? 'Lanjut' : 'Pilih Foto / Video';
      case 2:
        return 'Kirim Pengaduan';
      default:
        return 'Lanjut';
    }
  }

  VoidCallback? _getButtonAction() {
    switch (currentStep) {
      case 0:
        return () {
          setState(() {
            currentStep = 1;
          });
        };
      case 1:
        return _imageFile != null // Hanya bisa lanjut jika sudah ada gambar
            ? () {
                setState(() {
                  currentStep = 2;
                });
              }
            : () {
                // Jika belum ada gambar, tampilkan pilihan ambil/pilih foto
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext bc) {
                    return SafeArea(
                      child: Wrap(
                        children: <Widget>[
                          ListTile(
                            leading: const Icon(Icons.photo_library),
                            title: const Text('Pilih dari Galeri'),
                            onTap: () {
                              _pickImageFromGallery();
                              Navigator.of(context).pop();
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.photo_camera),
                            title: const Text('Ambil Foto Baru'),
                            onTap: () {
                              _takePhotoWithCamera();
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              };
      case 2:
        return () {
          // Submit complaint
          _showSuccessDialog();
        };
      default:
        return null;
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
              20,
            ), // Sesuaikan dengan borderRadius Dialog
            child: Container(
              color:
                  Colors.white, // Mengatur warna latar belakang menjadi putih
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  Image.asset('assets/images/amico.png', height: 100),
                  const SizedBox(height: 20),
                  const Text(
                    'Pengaduan anda\ntelah di terima',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Silahkan cek secara berkala pada page laporan,\nuntuk melihat status pengaduan anda.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E6D9C),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Kembali',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}