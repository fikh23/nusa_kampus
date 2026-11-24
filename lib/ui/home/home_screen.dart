import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<HomeViewModel>().load();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NusaKampus'),
        centerTitle: false,
      ),
      body: ListenableBuilder(
        listenable: context.read<HomeViewModel>(),
        builder: (context, child) {
          final vm = context.read<HomeViewModel>();

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
                'Selamat Datang!',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 6),
              Text('Hari ini: ${vm.today}'),
              const SizedBox(height: 24),

              Text(
                'Kuliah Hari Ini',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),

              if (vm.todayCourses.isEmpty)
                const Card(
                  child: ListTile(
                    leading: Icon(Icons.event_available),
                    title: Text('Tidak ada jadwal kuliah hari ini'),
                  ),
                )
              else
                ...vm.todayCourses.map(
                  (course) => Card(
                    child: ListTile(
                      leading: const Icon(Icons.school),
                      title: Text(course.name),
                      subtitle: Text(
                        '${course.time} • ${course.room}\n${course.lecturer}',
                      ),
                      isThreeLine: true,
                    ),
                  ),
                ),

              const SizedBox(height: 24),
              Text(
                'Tugas Belum Selesai (${vm.pendingTasks.length})',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),

              if (vm.pendingTasks.isEmpty)
                const Card(
                  child: ListTile(
                    leading: Icon(Icons.check_circle),
                    title: Text('Semua tugas sudah selesai'),
                  ),
                )
              else
                ...vm.pendingTasks.map(
                  (task) => Card(
                    child: ListTile(
                      leading: const Icon(Icons.assignment_outlined),
                      title: Text(task.title),
                      subtitle: Text(
                        '${task.courseName}\nDeadline: ${task.deadline}',
                      ),
                      isThreeLine: true,
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
