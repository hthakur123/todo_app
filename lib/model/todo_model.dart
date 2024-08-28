class TodoModel {
  final int? id;
  final String? title;
  final String? description;
  final DateTime? dueDate;
  final String? time; // Added time as a String
  final int? priority;

  TodoModel({
     this.id,
     this.title,
     this.description,
     this.dueDate,
     this.time,
     this.priority,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate?.toIso8601String(),
      'time': time, // Added time to the map
      'priority': priority,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      dueDate: DateTime.parse(map['dueDate']),
      time: map['time'], // Extracted time from the map
      priority: map['priority'],
    );
  }
}
