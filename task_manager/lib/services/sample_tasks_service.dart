import '../models/task.dart';

class SampleTasksService {
  static List<Task> getSampleTasks() {
    final now = DateTime.now();
    
    return [
      Task(
        title: 'Morning Exercise',
        description: 'Start your day with a 30-minute workout routine',
        dueDate: DateTime(now.year, now.month, now.day, 7, 0),
        isRepeating: true,
        repeatPattern: 'daily',
        subtasks: [
          'Stretching',
          'Cardio',
          'Push-ups',
          'Cool down',
        ],
        progress: 0.0,
      ),
      Task(
        title: 'Team Meeting',
        description: 'Weekly team sync-up meeting',
        dueDate: DateTime(now.year, now.month, now.day, 10, 0),
        isRepeating: true,
        repeatPattern: 'weekly',
        subtasks: [
          'Review last week\'s progress',
          'Discuss blockers',
          'Plan next steps',
        ],
        progress: 0.0,
      ),
      Task(
        title: 'Grocery Shopping',
        description: 'Buy essential items for the week',
        dueDate: DateTime(now.year, now.month, now.day, 14, 0),
        isRepeating: false,
        subtasks: [
          'Fruits and vegetables',
          'Dairy products',
          'Bread and cereals',
          'Cleaning supplies',
        ],
        progress: 0.0,
      ),
      Task(
        title: 'Study Flutter',
        description: 'Learn new Flutter concepts and practice coding',
        dueDate: DateTime(now.year, now.month, now.day, 16, 0),
        isRepeating: true,
        repeatPattern: 'daily',
        subtasks: [
          'Watch tutorials',
          'Practice coding',
          'Build small projects',
          'Read documentation',
        ],
        progress: 0.0,
      ),
      Task(
        title: 'Evening Walk',
        description: '30-minute relaxing walk in the park',
        dueDate: DateTime(now.year, now.month, now.day, 18, 0),
        isRepeating: true,
        repeatPattern: 'daily',
        progress: 0.0,
      ),
    ];
  }
}
