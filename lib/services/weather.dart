import '../services/networking.dart';
import '../services/location.dart';

const apiKey = "24217bb0a2a2eca674412510c53e6ec1";
const WeatherUrl = "http://api.openweathermap.org/data/2.5/weather?";

class WeatherInfo {
  Future<dynamic> getWeatherInfo() async {
    GetLocation currentLocation = GetLocation();
    await currentLocation.getLocationData();

    Networking network = Networking(
        "${WeatherUrl}lat=${currentLocation.latitude}&lon=${currentLocation.longitude}&appid=$apiKey&units=metric");
    var weatherData = await network.getData();
    return weatherData;
  }

  Future<dynamic> getWeatherInfoVC(String cityName) async {
    Networking network =
        Networking("$WeatherUrl&q=$cityName&appid=$apiKey&units=metric");
    var weatherData = await network.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
