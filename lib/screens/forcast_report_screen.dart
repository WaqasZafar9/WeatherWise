import 'package:flutter/material.dart';
import '../views/weekly_forecast_view.dart';
import '/constants/app_colors.dart';
import '/constants/text_styles.dart';
import '/extensions/datetime.dart';
import '/views/gradient_container.dart';
import '/views/hourly_forecast_view.dart';


class ForecastReportScreen extends StatefulWidget {
  const ForecastReportScreen({super.key});

  @override
  _ForecastReportScreenState createState() => _ForecastReportScreenState();
}

class _ForecastReportScreenState extends State<ForecastReportScreen> {
  DateTime _selectedDate = DateTime.now();

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 6)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      children: [
        // Page Title
        const Align(
          alignment: Alignment.center,
          child: Text(
            'Forecast Report',
            style: TextStyles.h1,
          ),
        ),

        const SizedBox(height: 40),

        // Today's date
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Today',
              style: TextStyles.h2,
            ),
            Text(
              _selectedDate.dateTime, // Show the selected date
              style: TextStyles.subtitleText,
            ),
          ],
        ),

        const SizedBox(height: 20),

        // Today's forecast
        const HourlyForecastView(),

        const SizedBox(height: 20),

        // Next Forecast
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Next Forecast',
              style: TextStyles.h2,
            ),
            IconButton(
              icon: const Icon(
                Icons.calendar_month_rounded,
                color: AppColors.white,
              ),
              onPressed: () => _pickDate(context), // Open date picker
            ),
          ],
        ),

        const SizedBox(height: 30),

        // Weekly forecast for the selected date
        WeeklyForecastView(selectedDate: _selectedDate), // Pass selected date
      ],
    );
  }
}
