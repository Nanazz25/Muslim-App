import 'package:flutter/material.dart';
import 'package:muslim_app/viewmodel/doa_viewmodel.dart';
import 'package:provider/provider.dart';

class DoaPage extends StatefulWidget {
  const DoaPage({super.key});

  @override
  State<DoaPage> createState() => _DoaPageState();
}

class _DoaPageState extends State<DoaPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<DoaViewmodel>().fetchAllDoa(); // fetch semua doa
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Doa Harian',
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
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
        child: Consumer<DoaViewmodel>(
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
            } else if (viewModel.doaList.isEmpty) {
              return const Center(child: Text('Tidak ada doa tersedia.', style: TextStyle(fontSize: 16)));
            } else {
              final list = viewModel.doaList;

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final doa = list[index];

                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ExpansionTile(
                      tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      childrenPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      title: Text(
                        doa.doa ?? 'Judul Tidak Diketahui',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.teal.shade800,
                        ),
                      ),
                      children: [
                        _buildDoaText('📖 Ayat', doa.ayat),
                        const SizedBox(height: 12),
                        _buildDoaText('🔠 Latin', doa.latin),
                        const SizedBox(height: 12),
                        _buildDoaText('📝 Artinya', doa.artinya),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildDoaText(String title, String? content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.teal.shade700,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          content ?? 'Tidak tersedia',
          style: const TextStyle(
            fontSize: 15,
            height: 1.6,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
