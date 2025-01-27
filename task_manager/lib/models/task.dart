class Task {
  int? id;
  String title;
  String description;
  DateTime dueDate;
  bool isCompleted;
  bool isRepeating;
  String? repeatPattern;
  List<String>? subtasks;
  double progress;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    this.isCompleted = false,
    this.isRepeating = false,
    this.repeatPattern,
    this.subtasks,
    this.progress = 0.0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate.toIso8601String(),
      'isCompleted': isCompleted ? 1 : 0,
      'isRepeating': isRepeating ? 1 : 0,
      'repeatPattern': repeatPattern,
      'subtasks': subtasks?.join('|||'),
      'progress': progress,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      dueDate: DateTime.parse(map['dueDate']),
      isCompleted: map['isCompleted'] == 1,
      isRepeating: map['isRepeating'] == 1,
      repeatPattern: map['repeatPattern'],
      subtasks: map['subtasks']?.split('|||'),
      progress: map['progress'],
    );
  }
}
