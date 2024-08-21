import 'package:flutter/material.dart';
import '/constants/app_colors.dart';
import '/constants/text_styles.dart';
import '/views/famous_cities_weather.dart';
import '/views/gradient_container.dart';
import '/widgets/round_text_field.dart';
import '/services/api_helper.dart';
import '/screens/weather_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController _searchController;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _searchCityWeather(String cityName) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final weather = await ApiHelper.getWeatherByCityName(cityName: cityName);
      if (weather != null) {
        // Navigate to WeatherDetailScreen if weather data is found
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WeatherDetailScreen(cityName: cityName),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'City not found or error fetching data.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      children: [
        // Page title
        const Align(
          alignment: Alignment.center,
          child: Text(
            'Pick Location',
            style: TextStyles.h1,
          ),
        ),

        const SizedBox(height: 20),

        // Page subtitle
        const Text(
          'Find the area or city that you want to know the detailed weather info at this time',
          style: TextStyles.subtitleText,
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 40),

        // Pick location row
        Row(
          children: [
            // Choose city text field
            Expanded(
              child: RoundTextField(
                controller: _searchController,
              ),
            ),
            const SizedBox(width: 15),

            GestureDetector(
              onTap: () {
                final cityName = _searchController.text.trim();
                if (cityName.isNotEmpty) {
                  _searchCityWeather(cityName);
                }
              },
              child: const LocationIcon(),
            ),
          ],
        ),

        const SizedBox(height: 30),

        // Display loading indicator or error message
        if (_isLoading)
          const Center(
            child: CircularProgressIndicator(),
          )
        else if (_errorMessage != null)
          Center(
            child: Text(
              _errorMessage!,
              style: TextStyle(
                color: Colors.red,
                fontSize: 16,
              ),
            ),
          )
        else
          const FamousCitiesWeather(),
      ],
    );
  }
}

class LocationIcon extends StatelessWidget {
  const LocationIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: 55,
      decoration: BoxDecoration(
        color: AppColors.accentBlue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Icon(
        Icons.location_on_outlined,
        color: AppColors.grey,
      ),
    );
  }
}
