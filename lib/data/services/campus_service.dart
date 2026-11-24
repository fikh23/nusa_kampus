import '../../domain/models/course.dart';
import '../../domain/models/task.dart';
import '../../domain/models/announcement.dart';

class CampusService {
  Future<List<Course>> getCourses() async {
    await Future.delayed(const Duration(seconds: 1));

    final data = [
      {
        'id': 1,
        'name': 'Pemrograman Berorientasi Objek',
        'lecturer': 'Dosen PBO',
        'day': 'Senin',
        'time': '08:00 - 09:40',
        'room': 'B4H',
      },
      {
        'id': 2,
        'name': 'Basis Data',
        'lecturer': 'Dosen Basis Data',
        'day': 'Selasa',
        'time': '10:00 - 11:40',
        'room': 'A2',
      },
      {
        'id': 3,
        'name': 'Kecerdasan Buatan',
        'lecturer': 'Dosen AI',
        'day': 'Rabu',
        'time': '13:00 - 14:40',
        'room': 'B4H',
      },
      {
        'id': 4,
        'name': 'Rekayasa Perangkat Lunak',
        'lecturer': 'Dosen RPL',
        'day': 'Kamis',
        'time': '08:00 - 09:40',
        'room': 'A3',
      },
      {
        'id': 5,
        'name': 'Machine Learning',
        'lecturer': 'Dosen ML',
        'day': 'Jumat',
        'time': '15:00 - 16:40',
        'room': 'B4H',
      },
    ];

    return data.map((json) => Course.fromJson(json)).toList();
  }

  Future<List<Task>> getTasks() async {
    await Future.delayed(const Duration(seconds: 1));

    final data = [
      {
        'id': 1,
        'title': 'Membuat program Java',
        'description': 'Membuat program menggunakan konsep OOP',
        'courseName': 'Pemrograman Berorientasi Objek',
        'deadline': '2026-11-28',
        'isCompleted': false,
      },
      {
        'id': 2,
        'title': 'Mengerjakan laporan basis data',
        'description': 'Membuat laporan praktikum basis data',
        'courseName': 'Basis Data',
        'deadline': '2026-11-29',
        'isCompleted': false,
      },
      {
        'id': 3,
        'title': 'Mencari referensi AI',
        'description': 'Mencari lima referensi jurnal kecerdasan buatan',
        'courseName': 'Kecerdasan Buatan',
        'deadline': '2026-11-30',
        'isCompleted': true,
      },
    ];

    return data.map((json) => Task.fromJson(json)).toList();
  }

  Future<List<Announcement>> getAnnouncements() async {
    await Future.delayed(const Duration(seconds: 1));

    final data = [
      {
        'id': 1,
        'title': 'Informasi Perkuliahan',
        'content': 'Mahasiswa diharapkan mengikuti perkuliahan sesuai jadwal yang telah ditentukan.',
        'date': '2026-11-24',
        'category': 'Akademik',
      },
      {
        'id': 2,
        'title': 'Pengumpulan Tugas',
        'content': 'Pastikan seluruh tugas dikumpulkan sebelum batas waktu yang ditentukan.',
        'date': '2026-11-25',
        'category': 'Tugas',
      },
      {
        'id': 3,
        'title': 'Informasi Kegiatan Kampus',
        'content': 'Mahasiswa dapat mengikuti kegiatan dan informasi terbaru dari kampus.',
        'date': '2026-11-26',
        'category': 'Kegiatan',
      },
    ];

    return data.map((json) => Announcement.fromJson(json)).toList();
  }
}
