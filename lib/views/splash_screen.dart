import 'package:flutter/material.dart';
import 'package:muslim_app/main_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // (Optional) Logo atau teks
            Text("Muslim App", style: TextStyle(fontSize: 24, color: Colors.teal.shade700,)),
            SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: LinearProgressIndicator(
                color: Colors.teal.shade700,         // Warna utama progress
                backgroundColor: Colors.grey[300], // Warna latar belakang
                minHeight: 6,               // Tinggi garis
              ),
            ),
          ],
        ),
      ),
    );
  }
}
