import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/repositories/task_repository.dart';
import '../home/home_screen.dart';
import '../schedule/schedule_screen.dart';
import '../tasks/tasks_screen.dart';
import '../announcements/announcements_screen.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = [
    HomeScreen(),
    ScheduleScreen(),
    TasksScreen(),
    AnnouncementsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: ListenableBuilder(
        listenable: context.read<TaskRepository>(),
        builder: (context, child) {
          final pendingCount =
              context.read<TaskRepository>().pendingCount;

          return NavigationBar(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            destinations: [
              const NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'Beranda',
              ),
              const NavigationDestination(
                icon: Icon(Icons.calendar_month_outlined),
                selectedIcon: Icon(Icons.calendar_month),
                label: 'Jadwal',
              ),
              NavigationDestination(
                icon: Badge(
                  label: Text('$pendingCount'),
                  isLabelVisible: pendingCount > 0,
                  child: const Icon(Icons.assignment_outlined),
                ),
                selectedIcon: Badge(
                  label: Text('$pendingCount'),
                  isLabelVisible: pendingCount > 0,
                  child: const Icon(Icons.assignment),
                ),
                label: 'Tugas',
              ),
              const NavigationDestination(
                icon: Icon(Icons.campaign_outlined),
                selectedIcon: Icon(Icons.campaign),
                label: 'Pengumuman',
              ),
            ],
          );
        },
      ),
    );
  }
}
