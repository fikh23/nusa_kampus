class Announcement {
  final int id;
  final String title;
  final String content;
  final String date;
  final String category;

  const Announcement({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.category,
  });

  factory Announcement.fromJson(Map<String, dynamic> json) {
    return Announcement(
      id: json['id'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
      date: json['date'] as String,
      category: json['category'] as String,
    );
  }
}
