import 'package:flutter/material.dart';

class LaporScreen extends StatefulWidget {
  const LaporScreen({super.key});

  @override
  State<LaporScreen> createState() => _LaporScreenState();
}

class _LaporScreenState extends State<LaporScreen> {
  int currentStep = 0;
  final TextEditingController _complaintController = TextEditingController();

  // URL for the image from SIPRUSAK3.png
  final String _previewImageUrl =
      'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=400&h=200&fit=crop'; // This URL seems to match the image in SIPRUSAK3.png

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
                  child: const Icon(
                    // Menggunakan Icons.person
                    Icons.person,
                    size: 30, // Sesuaikan ukuran ikon
                    color: Color(0xFF2E6D9C), // Sesuaikan warna ikon
                  ),
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Yulia Nita',
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

  Widget _buildSelectEvidenceStep() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/camera.png', height: 150),
            const SizedBox(height: 20),
            const Text(
              'Ambil Foto Atau Video\nBukti Pengaduan Anda',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Melampirkan bukti foto sangat penting, agar\npengaduanmu memiliki bukti yang jelas. Ambil foto\natau video dengan cahaya yang cukup, serta jelas\nuntuk dilihat.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }

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
                  child: const Icon(
                    // Menggunakan Icons.person
                    Icons.person,
                    size: 30, // Sesuaikan ukuran ikon
                        color: Color(0xFF2E6D9C),
                  ),
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Yulia Nita',
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/images/images.png', // Using the defined URL for the image
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
        return 'Ambil foto / gambar';
      case 2:
        return 'Kirim Pengaduan'; // Changed to 'Kirim Pengaduan' for the final step
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
        return () {
          setState(() {
            currentStep = 2;
          });
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
