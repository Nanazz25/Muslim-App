import 'package:flutter/material.dart';
import 'package:muslim_app/viewmodel/jadwal_viewmodel.dart';
import 'package:provider/provider.dart';

class JadwalPage extends StatefulWidget {
  const JadwalPage({super.key});

  @override
  State<JadwalPage> createState() => _JadwalPageState();
}

class _JadwalPageState extends State<JadwalPage> {
  String lokasi = '1206';
  String tahun = '2025';
  String bulan = '2';
  String tanggal = '7';

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<JadwalViewmodel>().fetchJadwal(lokasi, tahun, bulan, tanggal);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Jadwal Sholat Harian',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal[700],
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade100, Colors.teal.shade50],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Consumer<JadwalViewmodel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return const Center(child: CircularProgressIndicator(color: Colors.teal));
            } else if (viewModel.errorMessage != null) {
              return Center(
                child: Text(
                  viewModel.errorMessage!,
                  style: const TextStyle(fontSize: 16, color: Colors.redAccent),
                ),
              );
            } else if (viewModel.jadwal == null) {
              return const Center(child: Text('Jadwal tidak tersedia.', style: TextStyle(fontSize: 16)));
            } else {
              final jadwal = viewModel.jadwal!;
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header lokasi dan tanggal dengan gradient dan shadow
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.teal.shade400, Colors.teal.shade700],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.teal.shade300.withOpacity(0.5),
                            blurRadius: 10,
                            spreadRadius: 3,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Lokasi: ${jadwal.data?.lokasi ?? '-'}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Tanggal: ${jadwal.data?.jadwal?.tanggal ?? '-'}',
                            style: const TextStyle(fontSize: 16, color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // List waktu sholat dengan card keren
                    ..._buildSholatCards(jadwal),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  List<Widget> _buildSholatCards(dynamic jadwal) {
    final times = {
      'Imsak': jadwal.data?.jadwal?.imsak,
      'Subuh': jadwal.data?.jadwal?.subuh,
      'Terbit': jadwal.data?.jadwal?.terbit,
      'Dhuha': jadwal.data?.jadwal?.dhuha,
      'Dzuhur': jadwal.data?.jadwal?.dzuhur,
      'Ashar': jadwal.data?.jadwal?.ashar,
      'Maghrib': jadwal.data?.jadwal?.maghrib,
      'Isya': jadwal.data?.jadwal?.isya,
    };

    return times.entries.map((entry) {
      return Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.teal.shade200.withOpacity(0.3),
              blurRadius: 8,
              spreadRadius: 3,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.access_time, color: Colors.teal.shade700, size: 28),
                const SizedBox(width: 12),
                Text(
                  entry.key,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.teal.shade800,
                  ),
                ),
              ],
            ),
            Text(
              entry.value ?? '-',
              style: TextStyle(
                fontSize: 18,
                color: Colors.teal.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
}
