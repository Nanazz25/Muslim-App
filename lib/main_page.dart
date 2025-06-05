import 'package:flutter/material.dart';
import 'package:muslim_app/views/home_page.dart';
import 'package:muslim_app/views/doa_page.dart';
import 'package:muslim_app/views/jadwal_page.dart';
import 'package:muslim_app/views/month_schedule_page.dart';
import 'package:muslim_app/views/surat_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      HomePage(onNavigate: _onItemTapped),
      const MonthSchedulePage(),
      // const JadwalPage(),
      const SuratPage(),
      const DoaPage(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Bulan'),
          // BottomNavigationBarItem(icon: Icon(Icons.access_time), label: 'Jadwal'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Surat'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Doa'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
