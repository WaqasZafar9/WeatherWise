# WeatherWise - Flutter

The **WeatherWise** project is a modern mobile application designed to provide users with real-time weather updates and the latest weather news. It uses multiple APIs to fetch current weather conditions, hourly and daily forecasts, and climate-related news, making it an essential tool for users who need accurate and up-to-date information on the go.

## Video Tutorial


## Tech Stack

- **Client**: Flutter, Dart

- **Pub Packages**: geocoding, geolocator, http, intl

## API References

- **OpenWeatherMap API**: [One Call API](https://openweathermap.org/api/one-call-3)
  - **File**: `apihelper.dart | openweatherapi_file.dart`
  - **Parameter**: 
    - **apiKey** *(string, required)*: YOUR OpenWeatherMap API Key

- **Open-Meteo API**: [Historical Forecast API](https://open-meteo.com/en/docs/historical-forecast-api#start_date=2024-08-07&timezone=auto)

## Features

- **Live weather info**
- **Hourly forecast for 48 hours**
- **Daily forecast for 7 days**
- **Weather news updates**
- **Cross-platform compatibility**
- **Smooth animations**
- **Weather based on live location**
- **Light & Dark Theme options**

## Color Scheme

### Dark Theme
| Color                | Hex        |
|----------------------|------------|
| Primary Color        | #1F1F1F    |
| Secondary Color      | #282828    |
| Gradient From Color  | #2B5EE5    |
| Gradient To Color    | #EF63E6    |
| Active Text Color    | #FFFFFF    |
| Inactive Text Color  | #BDBDBD    |

### Light Theme
| Color                | Hex        |
|----------------------|------------|
| Primary Color        | #FFFFFF    |
| Secondary Color      | #EDF6F9    |
| Gradient From Color  | #F3F3F3    |
| Gradient To Color    | #EDF6F9    |
| Active Text Color    | #000000    |
| Inactive Text Color  | #757575    |
| Icon Color           | #007AD9    |

## Fonts

- **Poppins**

## Icon Assets

- **Weather Icons Folder**: Contains various icons used for different weather conditions.
- **Icons Folder**: General icons used throughout the app.

## Installation

```bash
git clone "https://github.com/Maliud/weather-app-flutter-main.git"
cd Weather-App-Flutter-main
```

1. Open the project in your desired editor.
2. Paste your API Key in `apihelper.dart`.
3. Build your Flutter app.

### Build Commands

#### Terminal

```bash
flutter build android
flutter build ios
flutter build linux
flutter build macos
flutter build web
flutter build windows
```

#### Android Studio

- **Build > Flutter > Build AAR**
- **Build > Flutter > Build APK**
- **Build > Flutter > Build App Bundle**
- **Build > Flutter > Build iOS**
- **Build > Flutter > Build Web**

## License

This project is licensed under the GNU General Public License v3.0 - see the [GPLv3 License](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.

## Support

For support, Email: m.aliud@outlook.com

## 🔗 Links

- [LinkedIn](https://www.linkedin.com/in/m-waqas-zafar-645988293/)
