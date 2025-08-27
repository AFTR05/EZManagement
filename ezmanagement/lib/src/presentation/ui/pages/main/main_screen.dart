import 'package:ezmanagement/src/presentation/providers_ui/bottom_nav_bar_state.dart';
import 'package:ezmanagement/src/presentation/ui/pages/main/calendar/calendar_screen.dart';
import 'package:ezmanagement/src/presentation/ui/pages/main/home/home_screen.dart';
import 'package:ezmanagement/src/presentation/ui/pages/main/profile/profile_screen.dart';
import 'package:ezmanagement/src/presentation/ui/pages/main/report/report_screen.dart';
import 'package:ezmanagement/src/presentation/ui/pages/main/widgets/bottom_nav_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  final List<Widget> _screens = [
    HomeScreen(),
    ReportScreen(),
    CalendarScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(bottomNavBarStateProvider);

    return Scaffold(
      body: _screens[currentIndex],
      bottomNavigationBar: BottomNavBarWidget(
        currentIndex: currentIndex,
        onTap: (index) {
          ref.read(bottomNavBarStateProvider.notifier).select(index);
        },
      ),
    );
  }
}