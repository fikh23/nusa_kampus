import 'package:flutter/material.dart';

import 'config/dependencies.dart';
import 'ui/shell/app_shell.dart';

class NusaKampusApp extends StatelessWidget {
  const NusaKampusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppDependencies(
      child: MaterialApp(
        title: 'NusaKampus',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.indigo,
          ),
          scaffoldBackgroundColor: const Color(0xFFF7F8FC),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
          ),
          cardTheme: CardThemeData(
            elevation: 1,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        home: const AppShell(),
      ),
    );
  }
}
