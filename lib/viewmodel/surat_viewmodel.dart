import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:muslim_app/model/surat_model.dart';

class SuratViewmodel extends ChangeNotifier {
  SuratModel? _surat;
  bool _isLoading = false;
  String? _errorMessage;

  SuratModel? get surat => _surat;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchSurat() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final url = 'https://equran.id/api/v2/surat';
      final response = await http.get(
        Uri.parse(url),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print('Response Data: $jsonData');
        _surat = SuratModel.fromJson(jsonData);

        // Memastikan respons berupa array JSON
        // if (jsonData is List && jsonData.isNotEmpty) {
        //   _Surat = SuratModel.fromJson(jsonData.first);
        // } else {
        //   _errorMessage = 'Data tidak valid atau kosong.';
        // }
      } else {
        _errorMessage =
            'Failed to load schedule. Status code: ${response.statusCode}';
      }
    } catch (e) {
      _errorMessage = 'An error occurred: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
