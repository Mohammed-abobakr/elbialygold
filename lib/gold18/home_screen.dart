import 'package:flutter/material.dart';
import 'package:elbialygold/homepage.dart';
import 'package:elbialygold/money/money_dashboard.dart';
import 'package:elbialygold/reports/report.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _MyHomeScreen();
}

class _MyHomeScreen extends State<HomeScreen> {
  int currentIndex = 0;
  final List<Widget> pages = [HomePage(), MoneyDashboard(), Report()];
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          currentIndex: currentIndex,
          backgroundColor: Colors.amberAccent,
          selectedIconTheme: IconThemeData(
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
          selectedItemColor: Colors.black,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'الرئيسية',
              backgroundColor: const Color.fromARGB(255, 47, 16, 16),
            ),
            BottomNavigationBarItem(icon: Icon(Icons.wallet), label: 'المحفظة'),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: 'التقارير',
            ),
          ],
        ),
        body: pages[currentIndex],
      ),
    );
  }
}
