import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/constants/app_colors.dart';
import '/constants/text_styles.dart';
import '/extensions/datetime.dart';
import '/providers/weekly_weather_provider.dart';
import '/utils/get_weather_icons.dart';
import '/widgets/subscript_text.dart';


DateTime adjustForTimezone(DateTime date, int offsetSeconds) {
  return date.add(Duration(seconds: offsetSeconds));
}

class WeeklyForecastView extends ConsumerWidget {
  const WeeklyForecastView({
    super.key,
    required this.selectedDate,
  });

  final DateTime selectedDate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weeklyForecast = ref.watch(weeklyWeatherProvider);

    return weeklyForecast.when(
      data: (weatherData) {
        // Adjust the selectedDate for the timezone of the data
        final timezoneOffsetSeconds = weatherData.utcOffsetSeconds; // Assuming you have this in your model
        final adjustedSelectedDate = adjustForTimezone(selectedDate, timezoneOffsetSeconds);
        final adjustedSelectedDateString = adjustedSelectedDate.toIso8601String().substring(0, 10);

        // Adjust the dates from the API and match with the selected date
        final selectedIndex = weatherData.daily.time.indexWhere(
              (dateString) {
            final adjustedDate = adjustForTimezone(DateTime.parse(dateString), timezoneOffsetSeconds);
            return adjustedDate.toIso8601String().substring(0, 10) == adjustedSelectedDateString;
          },
        );

        if (selectedIndex == -1) {
          return const Center(
            child: Text('No forecast available for the selected date.'),
          );
        }

        // Show the forecast for the selected date
        final dayOfWeek = DateTime.parse(weatherData.daily.time[selectedIndex]).dayOfWeek;
        final date = weatherData.daily.time[selectedIndex];
        final temp = weatherData.daily.temperature2mMax[selectedIndex];
        final icon = weatherData.daily.weatherCode[selectedIndex];

        return WeeklyForecastTile(
          date: date,
          day: dayOfWeek,
          icon: getWeatherIcon2(icon),
          temp: temp.round(),
        );
      },
      error: (error, stackTrace) {
        return Center(
          child: Text(
            error.toString(),
          ),
        );
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}


class WeeklyForecastTile extends StatelessWidget {
  const WeeklyForecastTile({
    super.key,
    required this.day,
    required this.date,
    required this.temp,
    required this.icon,
  });

  final String day;
  final String date;
  final int temp;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 20,
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 12,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.accentBlue,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                day,
                style: TextStyles.h3,
              ),
              const SizedBox(height: 5),
              Text(
                date,
                style: TextStyles.subtitleText,
              ),
            ],
          ),

          // Temperature
          SuperscriptText(
            text: '$temp',
            color: AppColors.white,
            superScript: '°C',
            superscriptColor: AppColors.white,
          ),

          // weather icon
          Image.asset(
            icon,
            width: 60,
          ),
        ],
      ),
    );
  }
}
