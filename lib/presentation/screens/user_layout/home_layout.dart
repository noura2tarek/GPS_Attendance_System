import 'package:flutter/material.dart';
import 'package:gps_attendance_system/l10n/l10n.dart';
import 'package:gps_attendance_system/presentation/screens/home/check_in.dart';
import 'package:gps_attendance_system/presentation/screens/leaves/leaves_page.dart';
import 'package:gps_attendance_system/presentation/screens/profile/profile_page.dart';

final List<Widget> screens = [
  const Attendance(),
  const LeavesPage(),
  const ProfilePage(),
];



class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<String> titles = [
      AppLocalizations.of(context).home,
      AppLocalizations.of(context).leaves,
      AppLocalizations.of(context).profile,
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(titles[_currentIndex]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: AppLocalizations.of(context).home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.calendar_month),
            label: AppLocalizations.of(context).leaves,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: AppLocalizations.of(context).profile,
          ),
        ],
      ),
      body: screens[_currentIndex],
    );
  }
}
