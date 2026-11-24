import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'tasks_view_model.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<TasksViewModel>().load();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Tugas'),
      ),
      body: ListenableBuilder(
        listenable: context.read<TasksViewModel>(),
        builder: (context, child) {
          final vm = context.read<TasksViewModel>();

          if (vm.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (vm.error != null) {
            return Center(child: Text(vm.error!));
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                'Belum Selesai (${vm.pendingTasks.length})',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),

              if (vm.pendingTasks.isEmpty)
                const Card(
                  child: ListTile(
                    title: Text('Tidak ada tugas yang tertunda.'),
                  ),
                ),

              ...vm.pendingTasks.map(
                (task) => Card(
                  child: CheckboxListTile(
                    value: task.isCompleted,
                    onChanged: (_) => vm.toggleTask(task.id),
                    title: Text(task.title),
                    subtitle: Text(
                      '${task.courseName}\nDeadline: ${task.deadline}',
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ),
              ),

              const SizedBox(height: 24),
              Text(
                'Selesai (${vm.completedTasks.length})',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),

              if (vm.completedTasks.isEmpty)
                const Card(
                  child: ListTile(
                    title: Text('Belum ada tugas yang selesai.'),
                  ),
                ),

              ...vm.completedTasks.map(
                (task) => Card(
                  child: CheckboxListTile(
                    value: task.isCompleted,
                    onChanged: (_) => vm.toggleTask(task.id),
                    title: Text(task.title),
                    subtitle: Text(task.courseName),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
