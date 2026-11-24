import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'announcements_view_model.dart';

class AnnouncementsScreen extends StatefulWidget {
  const AnnouncementsScreen({super.key});

  @override
  State<AnnouncementsScreen> createState() => _AnnouncementsScreenState();
}

class _AnnouncementsScreenState extends State<AnnouncementsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<AnnouncementsViewModel>().load();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengumuman Kampus'),
      ),
      body: ListenableBuilder(
        listenable: context.read<AnnouncementsViewModel>(),
        builder: (context, child) {
          final vm = context.read<AnnouncementsViewModel>();

          if (vm.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (vm.error != null) {
            return Center(child: Text(vm.error!));
          }

          if (vm.announcements.isEmpty) {
            return const Center(
              child: Text('Belum ada pengumuman.'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: vm.announcements.length,
            itemBuilder: (context, index) {
              final announcement = vm.announcements[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.campaign_outlined,
                            color: Colors.indigo,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              announcement.category,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.indigo,
                              ),
                            ),
                          ),
                          Text(
                            announcement.date,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        announcement.title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(announcement.content),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
