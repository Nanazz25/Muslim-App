import 'package:flutter/material.dart';
import 'package:muslim_app/main_page.dart';
import 'package:muslim_app/viewmodel/doa_viewmodel.dart';
import 'package:muslim_app/viewmodel/jadwal_viewmodel.dart';
import 'package:muslim_app/viewmodel/month_schedule_viewmodel.dart';
import 'package:muslim_app/viewmodel/surat_viewmodel.dart';
import 'package:muslim_app/views/home_page.dart';
import 'package:muslim_app/views/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Pastikan Flutter binding sudah berjalan
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DoaViewmodel>(create: (context) => DoaViewmodel()),
        ChangeNotifierProvider<JadwalViewmodel>(create: (context) => JadwalViewmodel()),
        ChangeNotifierProvider<MonthScheduleViewmodel>(create: (context) => MonthScheduleViewmodel()),
        ChangeNotifierProvider<SuratViewmodel>(create: (context) => SuratViewmodel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Muslim App',
        theme: ThemeData(primarySwatch: Colors.teal),
        home: SplashScreen(),
      ),
    );
  }
}


// void main() {
//   runApp(const MainApp());
// }

// class MainApp extends StatelessWidget {
//   const MainApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => DoaViewmodel())
//       ],
//       child: MaterialApp(
//         title: 'Muslim App',
//         theme: ThemeData(primarySwatch: Colors.green),
//         initialRoute: '/Jadwal',
//         routes: {
//           '/Jadwal': (context) => DoaPage()
//         },
//       )
//     );
//   }
// }
