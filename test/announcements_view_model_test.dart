import 'package:flutter_test/flutter_test.dart';
import 'package:nusa_kampus/data/repositories/announcement_repository.dart';
import 'package:nusa_kampus/data/services/campus_service.dart';
import 'package:nusa_kampus/ui/announcements/announcements_view_model.dart';

void main() {
  group('AnnouncementsViewModel Test', () {
    late AnnouncementsViewModel viewModel;

    setUp(() {
      final service = CampusService();
      final repository = AnnouncementRepository(service);
      viewModel = AnnouncementsViewModel(repository);
    });

    tearDown(() {
      viewModel.dispose();
    });

    test('Load announcements berhasil', () async {
      expect(viewModel.isLoading, false);
      expect(viewModel.announcements, isEmpty);

      final future = viewModel.load();

      expect(viewModel.isLoading, true);

      await future;

      expect(viewModel.isLoading, false);
      expect(viewModel.error, isNull);
      expect(viewModel.announcements, isNotEmpty);
      expect(viewModel.announcements.length, 3);
    });

    test('Data pengumuman memiliki judul', () async {
      await viewModel.load();

      expect(
        viewModel.announcements.first.title,
        'Informasi Perkuliahan',
      );
    });
  });
}
