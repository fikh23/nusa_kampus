import 'package:flutter/foundation.dart';

import '../../domain/models/task.dart';
import '../services/campus_service.dart';

class TaskRepository extends ChangeNotifier {
  final CampusService _service;

  List<Task> _tasks = [];
  bool _hasLoaded = false;

  TaskRepository(this._service);

  List<Task> get tasks => List.unmodifiable(_tasks);

  List<Task> get pendingTasks =>
      _tasks.where((task) => !task.isCompleted).toList();

  List<Task> get completedTasks =>
      _tasks.where((task) => task.isCompleted).toList();

  int get pendingCount => pendingTasks.length;

  Future<void> loadTasks() async {
    if (_hasLoaded) return;

    _tasks = await _service.getTasks();
    _hasLoaded = true;
    notifyListeners();
  }

  void toggleTask(int id) {
    _tasks = _tasks.map((task) {
      if (task.id == id) {
        return task.copyWith(
          isCompleted: !task.isCompleted,
        );
      }
      return task;
    }).toList();

    notifyListeners();
  }
}
