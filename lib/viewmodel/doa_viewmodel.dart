import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:muslim_app/model/doa_model.dart';

class DoaViewmodel extends ChangeNotifier {
  DoaModel? _doa;
  List<DoaModel> _doaList = [];
  bool _isLoading = false;
  String? _errorMessage;

  DoaModel? get doa => _doa;
  List<DoaModel> get doaList => _doaList;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Ambil 1 doa berdasarkan ID
  Future<void> fetchDoa(String id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final url = 'https://doa-doa-api-ahmadramadhan.fly.dev/api/$id';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        if (jsonData is List && jsonData.isNotEmpty) {
          _doa = DoaModel.fromJson(jsonData.first);
        } else {
          _errorMessage = 'Data tidak valid atau kosong.';
        }
      } else {
        _errorMessage = 'Gagal mengambil data. Kode: ${response.statusCode}';
      }
    } catch (e) {
      _errorMessage = 'Terjadi kesalahan: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Ambil semua doa
  Future<void> fetchAllDoa() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final url = 'https://doa-doa-api-ahmadramadhan.fly.dev/api';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        if (jsonData is List) {
          _doaList = jsonData.map((e) => DoaModel.fromJson(e)).toList();
        } else {
          _errorMessage = 'Data tidak valid.';
        }
      } else {
        _errorMessage = 'Gagal memuat doa. Kode: ${response.statusCode}';
      }
    } catch (e) {
      _errorMessage = 'Terjadi kesalahan: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
