import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/services/campus_service.dart';
import '../data/repositories/schedule_repository.dart';
import '../data/repositories/task_repository.dart';
import '../data/repositories/announcement_repository.dart';

import '../ui/home/home_view_model.dart';
import '../ui/schedule/schedule_view_model.dart';
import '../ui/tasks/tasks_view_model.dart';
import '../ui/announcements/announcements_view_model.dart';

class AppDependencies extends StatelessWidget {
  final Widget child;

  const AppDependencies({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<CampusService>(
          create: (_) => CampusService(),
        ),
        ProxyProvider<CampusService, ScheduleRepository>(
          update: (_, service, _) => ScheduleRepository(service),
        ),
        ChangeNotifierProxyProvider<CampusService, TaskRepository>(
          create: (context) => TaskRepository(
            context.read<CampusService>(),
          ),
          update: (_, service, previous) =>
              previous ?? TaskRepository(service),
        ),
        ProxyProvider<CampusService, AnnouncementRepository>(
          update: (_, service, _) =>
              AnnouncementRepository(service),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeViewModel(
            context.read<ScheduleRepository>(),
            context.read<TaskRepository>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => ScheduleViewModel(
            context.read<ScheduleRepository>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => TasksViewModel(
            context.read<TaskRepository>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => AnnouncementsViewModel(
            context.read<AnnouncementRepository>(),
          ),
        ),
      ],
      child: child,
    );
  }
}
