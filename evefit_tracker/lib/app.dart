import 'package:flutter/material.dart';

import 'database/app_database.dart';
import 'screens/dashboard_screen.dart';
import 'screens/goals_screen.dart';
import 'screens/measurements_screen.dart';
import 'screens/photos_screen.dart';
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
      home: const EveFitHome(),
    );
  }
}

class EveFitHome extends StatefulWidget {
  const EveFitHome({super.key});

  @override
  State<EveFitHome> createState() => _EveFitHomeState();
}

class _EveFitHomeState extends State<EveFitHome> {
  int _index = 0;
  final _db = AppDatabase.instance;

  late final List<Widget> _screens = [
    DashboardScreen(database: _db),
    WorkoutsScreen(database: _db),
    MeasurementsScreen(database: _db),
    PhotosScreen(database: _db),
    GoalsScreen(database: _db),
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
