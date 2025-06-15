import 'package:flutter/material.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Pusat Bantuan',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFF2E6D9C),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bagian Pencarian
            _buildSearchBar(context),
            const SizedBox(height: 30),

            // Bagian Pertanyaan Umum (FAQ)
            Text(
              'Pertanyaan Umum (FAQ)',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
            ),
            const SizedBox(height: 15),
            _buildFAQItem(
              context,
              question: 'Bagaimana cara mengubah kata sandi?',
              answer:
                  'Anda dapat mengubah kata sandi melalui menu Pengaturan > Keamanan Akun > Ubah Kata Sandi.',
            ),
            _buildFAQItem(
              context,
              question: 'Bagaimana cara melaporkan masalah?',
              answer:
                  'Untuk melaporkan masalah, silakan gunakan fitur "Laporkan Masalah" di bagian bawah halaman ini atau hubungi dukungan kami.',
            ),
            _buildFAQItem(
              context,
              question: 'Apakah aplikasi ini gratis digunakan?',
              answer:
                  'Ya, aplikasi ini gratis untuk diunduh dan digunakan, namun beberapa fitur mungkin memerlukan langganan premium.',
            ),
            const SizedBox(height: 30),

            // Bagian Kategori Bantuan
            Text(
              'Kategori Bantuan',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
            ),
            const SizedBox(height: 15),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 15.0,
              crossAxisSpacing: 15.0,
              // KEMBALIKAN childAspectRatio dan sesuaikan nilainya
              // Nilai 0.9 akan membuat tinggi item sedikit lebih besar dari lebarnya
              childAspectRatio: 0.9, // <-- UBAH NILAI INI
              // Hapus mainAxisExtent karena tidak didukung di versi Flutter Anda
              // mainAxisExtent: 140.0, // <-- HAPUS BARIS INI
              children: [
                _buildCategoryCard(context, Icons.account_circle, 'Akun & Profil', () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Navigasi ke Kategori Akun & Profil')));
                }),
                _buildCategoryCard(context, Icons.payment, 'Pembayaran & Langganan', () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Navigasi ke Kategori Pembayaran & Langganan')));
                }),
                _buildCategoryCard(context, Icons.app_settings_alt, 'Penggunaan Aplikasi', () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Navigasi ke Kategori Penggunaan Aplikasi')));
                }),
                _buildCategoryCard(context, Icons.security, 'Keamanan & Privasi', () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Navigasi ke Kategori Keamanan & Privasi')));
                }),
              ],
            ),
            const SizedBox(height: 30),

            // Bagian Butuh Bantuan Lebih Lanjut?
            Text(
              'Butuh Bantuan Lebih Lanjut?',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
            ),
            const SizedBox(height: 15),
            _buildContactOption(context, Icons.chat_bubble_outline, 'Hubungi Kami (Chat)',
                'Dapatkan bantuan instan dari tim dukungan kami melalui chat.', () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Membuka fitur chat')));
            }),
            _buildContactOption(context, Icons.email_outlined, 'Email Kami',
                'Kirimkan pertanyaan Anda melalui email dan kami akan merespons secepatnya.', () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Membuka formulir email')));
            }),
            _buildContactOption(context, Icons.phone_outlined, 'Telepon Kami',
                'Hubungi kami langsung untuk berbicara dengan agen dukungan.', () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Membuka dialer telepon')));
            }),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Widget _buildSearchBar (tidak berubah)
  Widget _buildSearchBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Cari bantuan atau pertanyaan...',
          hintStyle: TextStyle(color: Colors.grey[500]),
          prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        ),
        onChanged: (query) {
          print('Mencari: $query');
        },
      ),
    );
  }

  // Widget _buildFAQItem (tidak berubah)
  Widget _buildFAQItem(BuildContext context,
      {required String question, required String answer}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ExpansionTile(
        title: Text(
          question,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
            child: Text(
              answer,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[700],
                  ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildCategoryCard (tidak berubah, karena masalahnya ada pada GridView)
  Widget _buildCategoryCard(BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Theme.of(context).primaryColor),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildContactOption (tidak berubah)
  Widget _buildContactOption(BuildContext context, IconData icon, String title, String subtitle, VoidCallback onTap) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        leading: Icon(icon, size: 30, color: Theme.of(context).primaryColor),
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
        ),
        subtitle: Text(
          subtitle,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}