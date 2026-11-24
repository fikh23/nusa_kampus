class Task {
  final int id;
  final String title;
  final String description;
  final String courseName;
  final String deadline;
  final bool isCompleted;

  const Task({
    required this.id,
    required this.title,
    required this.description,
    required this.courseName,
    required this.deadline,
    this.isCompleted = false,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      courseName: json['courseName'] as String,
      deadline: json['deadline'] as String,
      isCompleted: json['isCompleted'] as bool? ?? false,
    );
  }

  Task copyWith({
    int? id,
    String? title,
    String? description,
    String? courseName,
    String? deadline,
    bool? isCompleted,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      courseName: courseName ?? this.courseName,
      deadline: deadline ?? this.deadline,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
