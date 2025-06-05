import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tentang Aplikasi',
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.teal,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Icon(
                Icons.mosque,
                size: 100,
                color: Colors.teal,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Muslim App',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Aplikasi Muslim App dirancang untuk membantu umat Muslim menjalankan ibadah sehari-hari dengan lebih mudah dan terorganisir. Aplikasi ini menyediakan berbagai fitur Islami seperti:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              '• Jadwal Sholat Harian dan Bulanan\n'
              '• Daftar Doa Sehari-hari\n'
              '• Kumpulan Surat dalam Al-Qur\'an\n'
              '• Pengingat Ibadah\n',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Dibuat oleh:\nNanaz - SMKN 1 Cianjur - RPL\n\nVersi: 1.0.0',
              style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
