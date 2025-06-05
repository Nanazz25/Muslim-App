import 'package:flutter/material.dart';
import 'package:muslim_app/viewmodel/month_schedule_viewmodel.dart';
import 'package:provider/provider.dart';

class MonthSchedulePage extends StatefulWidget {
  const MonthSchedulePage({super.key});

  @override
  State<MonthSchedulePage> createState() => _MonthSchedulePageState();
}

class _MonthSchedulePageState extends State<MonthSchedulePage> {
  String lokasi = '1206';
  int tahun = DateTime.now().year;
  int bulan = DateTime.now().month;

  Map<int, bool> _expandedCards = {};

  final List<Map<String, String>> listKota = [
  {'kode': '1201', 'nama': 'KAB. BANDUNG'},
  {'kode': '1202', 'nama': 'KAB. BANDUNG BARAT'},
  {'kode': '1203', 'nama': 'KAB. BEKASI'},
  {'kode': '1204', 'nama': 'KAB. BOGOR'},
  {'kode': '1205', 'nama': 'KAB. CIAMIS'},
  {'kode': '1206', 'nama': 'KAB. CIANJUR'},
  {'kode': '1207', 'nama': 'KAB. CIREBON'},
  {'kode': '1208', 'nama': 'KAB. GARUT'},
  {'kode': '1209', 'nama': 'KAB. INDRAMAYU'},
  {'kode': '1210', 'nama': 'KAB. KARAWANG'},
  {'kode': '1211', 'nama': 'KAB. KUNINGAN'},
  {'kode': '1212', 'nama': 'KAB. MAJALENGKA'},
  {'kode': '1213', 'nama': 'KAB. PANGANDARAN'},
  {'kode': '1214', 'nama': 'KAB. PURWAKARTA'},
  {'kode': '1215', 'nama': 'KAB. SUBANG'},
  {'kode': '1216', 'nama': 'KAB. SUKABUMI'},
  {'kode': '1217', 'nama': 'KAB. SUMEDANG'},
  {'kode': '1218', 'nama': 'KAB. TASIKMALAYA'},
  {'kode': '1271', 'nama': 'KOTA BANDUNG'},
  {'kode': '1272', 'nama': 'KOTA BANJAR'},
  {'kode': '1273', 'nama': 'KOTA BEKASI'},
  {'kode': '1274', 'nama': 'KOTA CIMAHI'},
  {'kode': '1275', 'nama': 'KOTA CIREBON'},
  {'kode': '1276', 'nama': 'KOTA DEPOK'},
  {'kode': '1277', 'nama': 'KOTA GARUT'},
  {'kode': '1278', 'nama': 'KOTA BANJAR'},
  {'kode': '1279', 'nama': 'KOTA TASIKMALAYA'},
];


  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<MonthScheduleViewmodel>().fetchJadwal(lokasi, tahun.toString(), bulan.toString());
    });
  }

  void _onChangeKota(String? kode) {
    if (kode == null) return;
    setState(() {
      lokasi = kode;
    });
    context.read<MonthScheduleViewmodel>().fetchJadwal(lokasi, tahun.toString(), bulan.toString());
  }

  Future<void> _pickMonthYear() async {
    // Pakai showDatePicker, ambil tanggal, bulan, tahun lalu ambil bulan dan tahun-nya
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(tahun, bulan),
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
      helpText: 'Pilih Bulan dan Tahun',
      fieldLabelText: 'Tanggal',
      selectableDayPredicate: (day) => true, // Semua tanggal bisa dipilih
    );

    if (picked != null) {
      setState(() {
        tahun = picked.year;
        bulan = picked.month;
      });
      context.read<MonthScheduleViewmodel>().fetchJadwal(lokasi, tahun.toString(), bulan.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Jadwal Sholat Bulanan',
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal.shade700,
      ),
      backgroundColor: Colors.teal.shade50,
      body: Consumer<MonthScheduleViewmodel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return Center(
                child: CircularProgressIndicator(color: Colors.teal.shade700));
          } else if (viewModel.errorMessage != null) {
            return Center(
              child: Text(
                viewModel.errorMessage!,
                style: const TextStyle(fontSize: 18, color: Colors.redAccent),
              ),
            );
          } else if (viewModel.jadwal == null ||
              viewModel.jadwal!.data == null) {
            return const Center(
              child: Text('Jadwal tidak tersedia.',
                  style: TextStyle(fontSize: 16)),
            );
          } else {
            final monthSchedule = viewModel.jadwal!;

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Filter Section
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 2,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.location_on,
                                    color: Colors.teal),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: DropdownButtonFormField<String>(
                                    decoration: const InputDecoration(
                                      labelText: 'Pilih Kota',
                                      border: OutlineInputBorder(),
                                    ),
                                    value: lokasi,
                                    items: listKota.map((kota) {
                                      return DropdownMenuItem<String>(
                                        value: kota['kode']!,
                                        child: Text(kota['nama']!),
                                      );
                                    }).toList(),
                                    onChanged: _onChangeKota,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                const Icon(Icons.date_range,
                                    color: Colors.teal),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: _pickMonthYear,
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(
                                          color: Colors.teal.shade700),
                                    ),
                                    child: Text(
                                      'Bulan: $bulan, Tahun: $tahun',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // List Jadwal
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: monthSchedule.data?.jadwal?.length ?? 0,
                      itemBuilder: (context, index) {
                        final jadwal = monthSchedule.data!.jadwal![index];
                        bool isExpanded = _expandedCards[index] ?? false;

                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 3,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          shadowColor: Colors.teal.shade100,
                          child: Column(
                            children: [
                              ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 4),
                                leading: Icon(Icons.calendar_today,
                                    color: Colors.teal.shade700, size: 26),
                                title: Text(
                                  '${jadwal.tanggal}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.teal.shade800,
                                  ),
                                ),
                                trailing: IconButton(
                                  icon: Icon(
                                    isExpanded
                                        ? Icons.expand_less
                                        : Icons.expand_more,
                                    color: Colors.teal.shade700,
                                    size: 28,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _expandedCards[index] = !isExpanded;
                                    });
                                  },
                                ),
                              ),
                              if (isExpanded) ...[
                                const Divider(
                                    thickness: 1, indent: 16, endIndent: 16),
                                _buildPrayerRow(
                                    Icons.wb_twilight, "Imsak", jadwal.imsak),
                                _buildPrayerRow(
                                    Icons.wb_sunny, "Subuh", jadwal.subuh),
                                _buildPrayerRow(Icons.wb_sunny_outlined,
                                    "Terbit", jadwal.terbit),
                                _buildPrayerRow(
                                    Icons.brightness_5, "Dhuha", jadwal.dhuha),
                                _buildPrayerRow(Icons.brightness_6, "Dzuhur",
                                    jadwal.dzuhur),
                                _buildPrayerRow(
                                    Icons.brightness_4, "Ashar", jadwal.ashar),
                                _buildPrayerRow(Icons.brightness_3, "Maghrib",
                                    jadwal.maghrib),
                                _buildPrayerRow(Icons.nightlight_round, "Isya",
                                    jadwal.isya),
                                const SizedBox(height: 12),
                              ],
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildPrayerRow(IconData icon, String title, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      child: Row(
        children: [
          Icon(icon, color: Colors.teal.shade700, size: 24),
          const SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Colors.teal.shade800,
            ),
          ),
          const Spacer(),
          Text(
            value ?? "-",
            style: TextStyle(
              fontSize: 16,
              color: Colors.blueGrey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}
