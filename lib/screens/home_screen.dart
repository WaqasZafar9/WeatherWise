import 'package:flutter/material.dart';
import 'package:weatherwise_weather_app/screens/search_screen.dart';
import 'package:weatherwise_weather_app/screens/weather%20screen/weather_screen.dart';
import '/constants/app_colors.dart';
import '/services/api_helper.dart';
import 'forcast_report_screen.dart';
import 'news_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPageIndex = 0;

  final _screens = const [
    WeatherScreen(),
    SearchScreen(),
    ForecastReportScreen(),
    ClimateNewsPage(),
  ];

  @override
  void initState() {
    ApiHelper.getCurrentWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentPageIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: const NavigationBarThemeData(
          backgroundColor: AppColors.secondaryBlack,
        ),
        child: NavigationBar(
          selectedIndex: _currentPageIndex,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          indicatorColor: Colors.transparent,
          onDestinationSelected: (index) =>
              setState(() => _currentPageIndex = index),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined, color: Colors.white),
              selectedIcon: Icon(Icons.home, color: Colors.white),
              label: '',
            ),
            NavigationDestination(
              icon: Icon(Icons.search_outlined, color: Colors.white),
              selectedIcon: Icon(Icons.search, color: Colors.white),
              label: '',
            ),
            NavigationDestination(
              icon: Icon(Icons.wb_sunny_outlined, color: Colors.white),
              selectedIcon: Icon(Icons.wb_sunny, color: Colors.white),
              label: '',
            ),
            NavigationDestination(
              icon: Icon(Icons.newspaper_outlined, color: Colors.white),
              selectedIcon: Icon(Icons.newspaper, color: Colors.white),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}

