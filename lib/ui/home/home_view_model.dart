import 'package:flutter/foundation.dart';

import '../../data/repositories/schedule_repository.dart';
import '../../data/repositories/task_repository.dart';
import '../../domain/models/course.dart';
import '../../domain/models/task.dart';

class HomeViewModel extends ChangeNotifier {
  final ScheduleRepository _scheduleRepository;
  final TaskRepository _taskRepository;

  HomeViewModel(this._scheduleRepository, this._taskRepository) {
    _taskRepository.addListener(_onTasksChanged);
  }

  bool isLoading = false;
  String? error;

  List<Course> courses = [];

  List<Task> get pendingTasks => _taskRepository.pendingTasks;

  String get today {
    const days = [
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu',
      'Minggu',
    ];

    return days[DateTime.now().weekday - 1];
  }

  List<Course> get todayCourses =>
      courses.where((course) => course.day == today).toList();

  void _onTasksChanged() {
    notifyListeners();
  }

  Future<void> load() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      courses = await _scheduleRepository.getCourses();
      await _taskRepository.loadTasks();
    } catch (e) {
      error = 'Gagal memuat data beranda: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _taskRepository.removeListener(_onTasksChanged);
    super.dispose();
  }
}
