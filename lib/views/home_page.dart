import 'package:flutter/material.dart';
import 'package:muslim_app/viewmodel/jadwal_viewmodel.dart';
import 'package:provider/provider.dart';
import 'dart:ui';

class HomePage extends StatefulWidget {
  final Function(int) onNavigate;

  const HomePage({super.key, required this.onNavigate});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedLocation = '1206';

  final List<Map<String, String>> lokasiList = [
    {'id': '1201', 'nama': 'KAB. BANDUNG'},
    {'id': '1202', 'nama': 'KAB. BANDUNG BARAT'},
    {'id': '1203', 'nama': 'KAB. BEKASI'},
    {'id': '1204', 'nama': 'KAB. BOGOR'},
    {'id': '1205', 'nama': 'KAB. CIAMIS'},
    {'id': '1206', 'nama': 'KAB. CIANJUR'},
    {'id': '1207', 'nama': 'KAB. CIREBON'},
    {'id': '1208', 'nama': 'KAB. GARUT'},
    {'id': '1209', 'nama': 'KAB. INDRAMAYU'},
    {'id': '1210', 'nama': 'KAB. KARAWANG'},
    {'id': '1211', 'nama': 'KAB. KUNINGAN'},
    {'id': '1212', 'nama': 'KAB. MAJALENGKA'},
    {'id': '1213', 'nama': 'KAB. PANGANDARAN'},
    {'id': '1214', 'nama': 'KAB. PURWAKARTA'},
    {'id': '1215', 'nama': 'KAB. SUBANG'},
    {'id': '1216', 'nama': 'KAB. SUKABUMI'},
    {'id': '1217', 'nama': 'KAB. SUMEDANG'},
    {'id': '1218', 'nama': 'KAB. TASIKMALAYA'},
    {'id': '1271', 'nama': 'KOTA BANDUNG'},
    {'id': '1272', 'nama': 'KOTA BANJAR'},
    {'id': '1273', 'nama': 'KOTA BEKASI'},
    {'id': '1274', 'nama': 'KOTA CIMAHI'},
    {'id': '1275', 'nama': 'KOTA CIREBON'},
    {'id': '1276', 'nama': 'KOTA DEPOK'},
    {'id': '1277', 'nama': 'KOTA GARUT'},
    {'id': '1278', 'nama': 'KOTA BANJAR'},
    {'id': '1279', 'nama': 'KOTA TASIKMALAYA'},
  ];

  @override
  void initState() {
    super.initState();
    _loadJadwal();
  }

  void _loadJadwal() {
    final now = DateTime.now();
    context.read<JadwalViewmodel>().fetchJadwal(selectedLocation,
        now.year.toString(), now.month.toString(), now.day.toString());
  }

  @override
  Widget build(BuildContext context) {
    final selectedName = lokasiList.firstWhere(
      (lokasi) => lokasi['id'] == selectedLocation,
      orElse: () => {'nama': '-'},
    )['nama'];

    final now = DateTime.now();
    final jamFormatted =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home Muslim App',
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.teal.shade700,
        centerTitle: true,
        elevation: 4,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade50, Colors.teal.shade100],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card Jam dan Cuaca
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.teal.shade100,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.teal.shade300.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.access_time,
                          size: 36, color: Colors.teal),
                      const SizedBox(width: 12),
                      Text(
                        jamFormatted,
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal.shade900),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.wb_sunny,
                          size: 36, color: Colors.orange.shade700),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Cerah',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.orange.shade700)),
                          Text('28°C',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.orange.shade600)),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),

            // SizedBox(
            //   height: 100,
            //   child: ListView(
            //     scrollDirection: Axis.horizontal,
            //     children: [
            //       _shortcutButton(
            //           Icons.book, 'Al-Qur\'an', () => widget.onNavigate(1)),
            //       _shortcutButton(Icons.mosque, 'Masjid Terdekat',
            //           () => widget.onNavigate(2)),
            //       _shortcutButton(
            //           Icons.star, 'Doa Harian', () => widget.onNavigate(3)),
            //       _shortcutButton(
            //           Icons.info, 'Tentang', () => widget.onNavigate(4)),
            //     ],
            //   ),
            // ),

            const SizedBox(height: 20),

            const Text('Pilih Lokasi',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal)),
            const SizedBox(height: 8),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                      color: Colors.teal.shade100.withOpacity(0.5),
                      blurRadius: 12,
                      offset: const Offset(0, 4)),
                ],
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedLocation,
                  isExpanded: true,
                  icon: Icon(Icons.keyboard_arrow_down,
                      color: Colors.teal.shade700, size: 28),
                  items: lokasiList.map((lokasi) {
                    return DropdownMenuItem<String>(
                      value: lokasi['id'],
                      child: Text(
                        lokasi['nama']!,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.teal),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedLocation = value!;
                    });
                    _loadJadwal();
                  },
                ),
              ),
            ),

            const SizedBox(height: 16),

            Text(
              '$selectedName - ${_formatTanggal()}',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade800),
            ),

            const SizedBox(height: 12),

            // Expanded Jadwal Sholat
            Expanded(
              child: Consumer<JadwalViewmodel>(
                builder: (context, viewModel, child) {
                  if (viewModel.isLoading) {
                    return const Center(
                        child: CircularProgressIndicator(color: Colors.teal));
                  } else if (viewModel.errorMessage != null) {
                    return Center(
                      child: Text(
                        viewModel.errorMessage!,
                        style: const TextStyle(
                            color: Colors.redAccent, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    );
                  } else if (viewModel.jadwal == null) {
                    return const Center(
                      child: Text(
                        'Jadwal tidak tersedia.',
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                    );
                  } else {
                    final waktu = viewModel.jadwal!.data?.jadwal;

                    final times = <Map<String, dynamic>>[
                      {
                        'label': 'Imsak',
                        'time': waktu?.imsak,
                        'icon': Icons.alarm
                      },
                      {
                        'label': 'Subuh',
                        'time': waktu?.subuh,
                        'icon': Icons.wb_sunny
                      },
                      {
                        'label': 'Terbit',
                        'time': waktu?.terbit,
                        'icon': Icons.wb_twighlight
                      },
                      {
                        'label': 'Dhuha',
                        'time': waktu?.dhuha,
                        'icon': Icons.brightness_low
                      },
                      {
                        'label': 'Dzuhur',
                        'time': waktu?.dzuhur,
                        'icon': Icons.brightness_medium
                      },
                      {
                        'label': 'Ashar',
                        'time': waktu?.ashar,
                        'icon': Icons.brightness_high
                      },
                      {
                        'label': 'Maghrib',
                        'time': waktu?.maghrib,
                        'icon': Icons.nights_stay
                      },
                      {
                        'label': 'Isya',
                        'time': waktu?.isya,
                        'icon': Icons.nightlight_round
                      },
                    ];

                    return SingleChildScrollView(
                      child: Card(
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: Colors.white.withOpacity(0.9),
                        margin: const EdgeInsets.only(bottom: 24),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ...List.generate(times.length, (index) {
                                final item = times[index];
                                return Padding(
                                  padding: EdgeInsets.only(
                                      bottom:
                                          index == times.length - 1 ? 0 : 12),
                                  child: Row(
                                    children: [
                                      Icon(item['icon'],
                                          color: Colors.teal.shade700),
                                      const SizedBox(width: 14),
                                      Expanded(
                                        child: Text(
                                          item['label'],
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.teal.shade900,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        item['time'] ?? '-',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.teal.shade800,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTanggal() {
    final now = DateTime.now();
    final months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember'
    ];
    return '${now.day} ${months[now.month - 1]} ${now.year}';
  }

  Widget _shortcutButton(IconData icon, String label, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: 90,
          decoration: BoxDecoration(
            color: Colors.teal.shade400,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                  color: Colors.teal.shade300.withOpacity(0.5),
                  blurRadius: 8,
                  offset: const Offset(0, 4)),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white),
              const SizedBox(height: 6),
              Text(label,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 14),
                  textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
