import '../../domain/models/course.dart';
import '../services/campus_service.dart';

class ScheduleRepository {
  final CampusService _service;

  ScheduleRepository(this._service);

  Future<List<Course>> getCourses() {
    return _service.getCourses();
  }
}
