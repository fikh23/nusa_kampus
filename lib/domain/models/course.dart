class Course {
  final int id;
  final String name;
  final String lecturer;
  final String day;
  final String time;
  final String room;

  const Course({
    required this.id,
    required this.name,
    required this.lecturer,
    required this.day,
    required this.time,
    required this.room,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] as int,
      name: json['name'] as String,
      lecturer: json['lecturer'] as String,
      day: json['day'] as String,
      time: json['time'] as String,
      room: json['room'] as String,
    );
  }
}
