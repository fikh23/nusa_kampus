import '../../domain/models/announcement.dart';
import '../services/campus_service.dart';

class AnnouncementRepository {
  final CampusService _service;

  AnnouncementRepository(this._service);

  Future<List<Announcement>> getAnnouncements() {
    return _service.getAnnouncements();
  }
}
