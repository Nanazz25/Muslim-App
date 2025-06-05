import 'package:flutter/material.dart';
import 'package:muslim_app/viewmodel/surat_viewmodel.dart';
import 'package:provider/provider.dart';

class SuratPage extends StatefulWidget {
  const SuratPage({super.key});

  @override
  State<SuratPage> createState() => _SuratPageState();
}

class _SuratPageState extends State<SuratPage> {
  final Map<int, bool> _expandedSurat = {};

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<SuratViewmodel>().fetchSurat();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Daftar Surat',
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.teal,
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: Colors.grey.shade100,
      body: Consumer<SuratViewmodel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (viewModel.errorMessage != null) {
            return Center(
              child: Text(
                viewModel.errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (viewModel.surat == null || viewModel.surat!.data == null || viewModel.surat!.data!.isEmpty) {
            return const Center(child: Text('Data tidak tersedia'));
          }

          final suratList = viewModel.surat!.data!;
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: suratList.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final surat = suratList[index];
              final isExpanded = _expandedSurat[index] ?? false;

              return Material(
                borderRadius: BorderRadius.circular(15),
                elevation: 2,
                shadowColor: Colors.teal.withOpacity(0.3),
                child: InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {
                    setState(() {
                      _expandedSurat[index] = !isExpanded;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeInOut,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header bar surat
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                surat.namaLatin ?? 'Tidak diketahui',
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.teal,
                                ),
                              ),
                            ),
                            AnimatedRotation(
                              turns: isExpanded ? 0.5 : 0,
                              duration: const Duration(milliseconds: 300),
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                size: 30,
                                color: Colors.teal,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Expanded content
                        AnimatedCrossFade(
                          firstChild: const SizedBox.shrink(),
                          secondChild: Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _infoRow(Icons.lightbulb_outline, "Arti", surat.arti),
                                const SizedBox(height: 8),
                                _infoRow(Icons.format_list_numbered, "Nomor", surat.nomor?.toString()),
                                const SizedBox(height: 8),
                                _infoRow(Icons.book, "Jumlah Ayat", surat.jumlahAyat?.toString()),
                                const SizedBox(height: 8),
                                _infoRow(Icons.location_on, "Tempat Turun", surat.tempatTurun),
                              ],
                            ),
                          ),
                          crossFadeState: isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                          duration: const Duration(milliseconds: 350),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _infoRow(IconData icon, String title, String? value) {
    return Row(
      children: [
        Icon(icon, color: Colors.teal, size: 20),
        const SizedBox(width: 10),
        Text(
          '$title: ',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            fontSize: 15,
          ),
        ),
        Expanded(
          child: Text(
            value ?? 'N/A',
            style: TextStyle(
              color: Colors.grey.shade800,
              fontSize: 15,
              fontStyle: value == null ? FontStyle.italic : FontStyle.normal,
            ),
          ),
        ),
      ],
    );
  }
}
