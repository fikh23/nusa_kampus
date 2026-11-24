import 'package:flutter/foundation.dart';

import '../../data/repositories/schedule_repository.dart';
import '../../domain/models/course.dart';

class ScheduleViewModel extends ChangeNotifier {
  final ScheduleRepository _repository;

  ScheduleViewModel(this._repository);

  bool isLoading = false;
  String? error;

  List<Course> courses = [];

  String selectedDay = 'Senin';

  static const List<String> days = [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
  ];

  List<Course> get filteredCourses =>
      courses.where((course) => course.day == selectedDay).toList();

  void selectDay(String day) {
    selectedDay = day;
    notifyListeners();
  }

  Future<void> load() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      courses = await _repository.getCourses();
    } catch (e) {
      error = 'Gagal memuat jadwal: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
