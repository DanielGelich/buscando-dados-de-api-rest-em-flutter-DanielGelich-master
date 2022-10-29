
import 'package:tempo_template/services/location.dart';
import 'package:tempo_template/services/networking.dart';

  const apiKey = '06b2b944d6c1d78b1fb5cb6df1f8dc8f';
  const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  dynamic getLocationWeather() async {
    Location location = Location();

    await location.getCurrentLocation;

    NetworkHelper networkHelper = NetworkHelper(
     '$openWeatherMapURL?lat=${location.latitute}&lon=${location.longitude}'
      '&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
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
      return 'É tempo de 🍦';
    } else if (temp > 20) {
      return 'O tempo está bom para bermuda e 👕';
    } else if (temp < 10) {
      return 'Você precisará de 🧣 e 🧤';
    } else {
      return 'Leve um 🧥';
    }
  }
}