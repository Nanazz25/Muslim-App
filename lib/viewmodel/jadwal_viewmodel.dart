import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:muslim_app/model/jadwal_model.dart';

class JadwalViewmodel extends ChangeNotifier {
  JadwalModel? _jadwal;
  bool _isLoading = false;
  String? _errorMessage;

  JadwalModel? get jadwal => _jadwal;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Mengambil jadwal sholat berdasarkan lokasi dan tanggal
  Future<void> fetchJadwal(
    String lokasi,
    String tahun,
    String bulan,
    String tanggal,
  ) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final url =
        'https://api.myquran.com/v2/sholat/jadwal/$lokasi/$tahun/$bulan/$tanggal';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        // Validasi dan parsing data ke model
        if (jsonData != null && jsonData['data'] != null) {
          _jadwal = JadwalModel.fromJson(jsonData);
        } else {
          _errorMessage = 'Data tidak ditemukan.';
        }
      } else {
        _errorMessage =
            'Gagal memuat jadwal. Kode: ${response.statusCode}';
      }
    } catch (e) {
      _errorMessage = 'Terjadi kesalahan: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Reset data jika diperlukan
  void reset() {
    _jadwal = null;
    _errorMessage = null;
    notifyListeners();
  }
}
