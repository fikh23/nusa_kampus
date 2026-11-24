import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'schedule_view_model.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<ScheduleViewModel>().load();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jadwal Kuliah'),
      ),
      body: ListenableBuilder(
        listenable: context.read<ScheduleViewModel>(),
        builder: (context, child) {
          final vm = context.read<ScheduleViewModel>();

          if (vm.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (vm.error != null) {
            return Center(child: Text(vm.error!));
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text(
                'Pilih Hari',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SegmentedButton<String>(
                  segments: ScheduleViewModel.days.map(
                    (day) => ButtonSegment<String>(
                      value: day,
                      label: Text(day),
                    ),
                  ).toList(),
                  selected: {vm.selectedDay},
                  onSelectionChanged: (selection) {
                    vm.selectDay(selection.first);
                  },
                  showSelectedIcon: false,
                ),
              ),

              const SizedBox(height: 20),

              if (vm.filteredCourses.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Text('Tidak ada jadwal pada hari ini.'),
                  ),
                )
              else
                ...vm.filteredCourses.map(
                  (course) => Card(
                    child: ListTile(
                      leading: const CircleAvatar(
                        child: Icon(Icons.school),
                      ),
                      title: Text(course.name),
                      subtitle: Text(
                        '${course.lecturer}\n${course.time} • ${course.room}',
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
