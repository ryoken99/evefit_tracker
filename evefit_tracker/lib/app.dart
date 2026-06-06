import 'package:flutter/material.dart';

import 'database/app_database.dart';
import 'screens/dashboard_screen.dart';
import 'screens/goals_screen.dart';
import 'screens/measurements_screen.dart';
import 'screens/photos_screen.dart';
import 'screens/profile_gate_screen.dart';
import 'screens/workouts_screen.dart';
import 'theme/app_theme.dart';

class EveFitApp extends StatelessWidget {
  const EveFitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EveFit Tracker',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark(),
      home: const EveFitRoot(),
    );
  }
}

class EveFitRoot extends StatefulWidget {
  const EveFitRoot({super.key});

  @override
  State<EveFitRoot> createState() => _EveFitRootState();
}

class _EveFitRootState extends State<EveFitRoot> {
  final _db = AppDatabase.instance;
  bool _unlocked = false;

  @override
  Widget build(BuildContext context) {
    if (!_unlocked) {
      return ProfileGateScreen(
        database: _db,
        onUnlocked: (_) => setState(() => _unlocked = true),
      );
    }
    return EveFitHome(
      database: _db,
      onProfileLocked: () => setState(() => _unlocked = false),
    );
  }
}

class EveFitHome extends StatefulWidget {
  const EveFitHome({
    super.key,
    required this.database,
    required this.onProfileLocked,
  });

  final AppDatabase database;
  final VoidCallback onProfileLocked;

  @override
  State<EveFitHome> createState() => _EveFitHomeState();
}

class _EveFitHomeState extends State<EveFitHome> {
  int _index = 0;

  late final List<Widget> _screens = [
    DashboardScreen(
      database: widget.database,
      onProfileLocked: widget.onProfileLocked,
    ),
    WorkoutsScreen(database: widget.database),
    MeasurementsScreen(database: widget.database),
    PhotosScreen(database: widget.database),
    GoalsScreen(database: widget.database),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _screens[_index]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (value) => setState(() => _index = value),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.fitness_center_outlined),
            selectedIcon: Icon(Icons.fitness_center),
            label: 'Treinos',
          ),
          NavigationDestination(
            icon: Icon(Icons.monitor_weight_outlined),
            selectedIcon: Icon(Icons.monitor_weight),
            label: 'Medidas',
          ),
          NavigationDestination(
            icon: Icon(Icons.photo_library_outlined),
            selectedIcon: Icon(Icons.photo_library),
            label: 'Fotos',
          ),
          NavigationDestination(
            icon: Icon(Icons.flag_outlined),
            selectedIcon: Icon(Icons.flag),
            label: 'Objetivos',
          ),
        ],
      ),
    );
  }
}
