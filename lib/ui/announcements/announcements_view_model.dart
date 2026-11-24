import 'package:flutter/foundation.dart';

import '../../data/repositories/announcement_repository.dart';
import '../../domain/models/announcement.dart';

class AnnouncementsViewModel extends ChangeNotifier {
  final AnnouncementRepository _repository;

  AnnouncementsViewModel(this._repository);

  bool isLoading = false;
  String? error;

  List<Announcement> announcements = [];

  Future<void> load() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      announcements = await _repository.getAnnouncements();
    } catch (e) {
      error = 'Gagal memuat pengumuman: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
