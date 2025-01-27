import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/task.dart';

enum TaskListType { today, completed, repeating }

class TaskList extends StatefulWidget {
  final TaskListType type;

  const TaskList({super.key, required this.type});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  late Future<List<Task>> _tasksFuture;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _loadTasks() {
    switch (widget.type) {
      case TaskListType.today:
        _tasksFuture = DatabaseHelper.instance.getTodayTasks();
        break;
      case TaskListType.completed:
        _tasksFuture = DatabaseHelper.instance.getCompletedTasks();
        break;
      case TaskListType.repeating:
        _tasksFuture = DatabaseHelper.instance.getRepeatingTasks();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Task>>(
      future: _tasksFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final tasks = snapshot.data ?? [];

        if (tasks.isEmpty) {
          return Center(
            child: Text(
              'No ${widget.type.toString().split('.').last} tasks',
              style: const TextStyle(color: Colors.white70),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: ListTile(
                title: Text(
                  task.title,
                  style: TextStyle(
                    decoration: task.isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(task.description),
                    const SizedBox(height: 8),
                    if (task.subtasks != null && task.subtasks!.isNotEmpty)
                      LinearProgressIndicator(value: task.progress),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (task.isRepeating)
                      const Icon(Icons.repeat, color: Colors.blue),
                    Checkbox(
                      value: task.isCompleted,
                      onChanged: (bool? value) async {
                        task.isCompleted = value ?? false;
                        await DatabaseHelper.instance.updateTask(task);
                        setState(() {
                          _loadTasks();
                        });
                      },
                    ),
                  ],
                ),
                onTap: () {
                  // TODO: Implement edit task functionality
                },
              ),
            );
          },
        );
      },
    );
  }
}
