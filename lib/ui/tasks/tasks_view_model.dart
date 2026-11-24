import 'package:flutter/foundation.dart';

import '../../data/repositories/task_repository.dart';
import '../../domain/models/task.dart';

class TasksViewModel extends ChangeNotifier {
  final TaskRepository _repository;

  TasksViewModel(this._repository) {
    _repository.addListener(_onTasksChanged);
  }

  bool isLoading = false;
  String? error;

  List<Task> get pendingTasks => _repository.pendingTasks;

  List<Task> get completedTasks => _repository.completedTasks;

  void _onTasksChanged() {
    notifyListeners();
  }

  Future<void> load() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      await _repository.loadTasks();
    } catch (e) {
      error = 'Gagal memuat tugas: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void toggleTask(int id) {
    _repository.toggleTask(id);
  }

  @override
  void dispose() {
    _repository.removeListener(_onTasksChanged);
    super.dispose();
  }
}
