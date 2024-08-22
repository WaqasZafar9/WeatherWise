# WeatherWise - Flutter

The **WeatherWise** project is a modern mobile application designed to provide users with real-time weather updates and the latest weather news. It uses multiple APIs to fetch current weather conditions, hourly and daily forecasts, and climate-related news, making it an essential tool for users who need accurate and up-to-date information on the go.

## Video Tutorial


## Tech Stack

- **Client**: Flutter, Dart

- **Pub Packages**: 
   - cupertino_icons: ^1.0.6,
   - dio: ^5.6.0,
   - flutter_riverpod: ^2.5.1,
   - jiffy: ^6.3.1,
   - geolocator: ^13.0.1,
   - google_fonts: ^6.2.1,
   - news_api_flutter_package: ^1.2.0,
   - flutter_webview_plugin: ^0.4.0,
   - http: ^1.2.2,
   - geocoding: ^3.0.0,
   - intl: ^0.19.0,
- **State Managment**: dio x riverpod usage
    - [riverpod](https://riverpod.dev/docs/introduction/why_riverpod)
    - [dio](https://pub.dev/packages/dio) 
  

## API References

- **OpenWeatherMap API**: [One Call API](https://openweathermap.org/api/one-call-3)
  - **File**: `apihelper.dart | openweatherapi_file.dart`
  - **Parameter**: 
    - **apiKey** *(string, required)*: YOUR OpenWeatherMap API Key

- **Open-Meteo API**: [Historical Forecast API](https://open-meteo.com/en/docs/historical-forecast-api#start_date=2024-08-07&timezone=auto)

## Features

- **Live weather info**
- **Live weather News**
- **Hourly forecast for 24 hours**
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

## Fonts

- **Poppins**

## Icon Assets

- **Weather Icons Folder**: Contains various icons used for different weather conditions.
- **Icons Folder**: General icons used throughout the app.

## Installation

```bash
git clone "https://github.com/WaqasZafar9/WeatherWise.git"
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

For support, Email: waqaszafar771@gmail.com

## 🔗 Links

- [LinkedIn](https://www.linkedin.com/in/m-waqas-zafar-645988293/)
