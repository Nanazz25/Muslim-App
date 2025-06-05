import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
import 'package:http/http.dart' as http;
import 'package:muslim_app/model/month_schedule.dart';

class MonthScheduleViewmodel extends ChangeNotifier {
  MonthScheduleModel? _jadwal;
  bool _isLoading = false;
  String? _errorMessage;

  MonthScheduleModel? get jadwal => _jadwal;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchJadwal(
      String lokasi, String tahun, String bulan,) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final url =
          'https://api.myquran.com/v2/sholat/jadwal/$lokasi/$tahun/$bulan';
      final response = await http.get(
        Uri.parse(url),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        _jadwal = MonthScheduleModel.fromJson(jsonData);

        // Memastikan respons berupa array JSON
        // if (jsonData is List && jsonData.isNotEmpty) {
        //   _jadwal = MonthScheduleModel.fromJson(jsonData.first);
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
